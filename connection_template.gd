class_name ConnectionTemplate
extends Node2D

var clicked_pt_count: int
var pts: Array

const CONNECTION_PT_RADIUS = 15 # FIXME: this should be driven from
                                # ConnectionPoint.

# Called when the node enters the scene tree for the first time.
func _ready():
    clicked_pt_count = 0
    pts = Array()
    # Connect every ConnectionPt's "is_clicked" signal to a handler fn. 
    for child in get_children():
        if child is ConnectionPoint:
            child.connect("is_clicked", _on_any_connection_pt_clicked)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
    if clicked_pt_count != 2:
        return
    # Make a segment with the current set of points.
    var landscape = StaticBody2D.new()
    landscape.visible = true
    landscape.input_pickable = true
    var collision_shape = CollisionShape2D.new()
    var shape = RectangleShape2D.new()
    var length = sqrt(pow((pts[0].x - pts[1].x), 2) 
                     +pow((pts[0].y - pts[1].y), 2))
    # Create shape slightly offset from node so we don't
    # accidentally click on it.
    shape.set_size(Vector2(length, 20))
    landscape.position.x = (pts[0].x + pts[1].x)/2
    landscape.position.y = (pts[0].y + pts[1].y)/2
    landscape.rotation = (pts[1] - pts[0]).angle()
    collision_shape.set_shape(shape)
    landscape.add_child(collision_shape)
    # connect to a callback function, but bind the callee.
    landscape.connect("input_event", _on_landscape_clicked.bind(landscape))
    # This works with polgyons too if we have at least 3A built-in data s points.
    #var line = CollisionPolygon2D.new()
    #line.set_polygon([pts[0], pts[1], Vector2(0,0)])
    #landscape.add_child(line)
    # Save it to current node for now.
    self.add_child(landscape)
    queue_redraw() # draw the landscape element.
    # Cleanup for defining a new line from future clicks.
    clicked_pt_count = 0
    pts.clear()
    
func _on_any_connection_pt_clicked(connection_pt):
    # line drawing logic here.
    print("connection point clicked")
    var pt = Vector2(connection_pt.position.x, connection_pt.position.y)
    if pts.size() < 1 || pts[-1] != pt:
        pts.append(pt)
        clicked_pt_count += 1
    elif pts.size() == 1 && pt == pts[-1]:
        pts.pop_back()
        clicked_pt_count -= 1
    # Recolor a connected/unconnected node.
    queue_redraw()
    
func _on_landscape_clicked(viewport: Node, event: InputEvent, shape_idx: int,
                           landscape: Node):
    if event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT:
        #var landscape = child.get_child(0).get_shape().get_size()
        var ends = get_start_end(landscape)
        if (ends[0].distance_to(event.position) < CONNECTION_PT_RADIUS * 2 or 
            ends[1].distance_to(event.position) < CONNECTION_PT_RADIUS * 2):
                return
        print("landscape clicked")
        landscape.queue_free() # remove child safely at the end of frame
        self.remove_child(landscape) # remove child from tree now so we redraw
                                     # correctly.
        queue_redraw()
        
func _draw():
    # Draw all static bodies.
    for child in self.get_children():
        if child is StaticBody2D:
            #print("redrawing")
            var ends = get_start_end(child)
            draw_line(ends[0], ends[1], Color.BLACK, ends[2])
    if pts.size() == 1:
        draw_circle(pts[0], CONNECTION_PT_RADIUS + 5, Color.GREEN)

func get_start_end(child):
    # We only have a CollisionShape2D as our only child.
    # Access that child's RectangleShape2D and underlying size.
    var size = child.get_child(0).get_shape().get_size()
    # size is Vector2D of (length, thickness)
    var centroid = child.position
    var angle = child.rotation
    var r = size.x/2
    var start = Vector2(centroid.x - r*cos(child.rotation),
                        centroid.y - r*sin(child.rotation))
    var stop = Vector2(centroid.x + r*cos(child.rotation),
                        centroid.y + r*sin(child.rotation))
    return [start, stop, size.y]
