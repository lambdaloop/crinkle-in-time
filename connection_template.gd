class_name ConnectionTemplate
extends Node2D

var clicked_pt_count: int
var pts: Array
var segments: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	clicked_pt_count = 0
	pts = Array()
	segments = Dictionary()
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
    var pt = Vector2(connection_pt.position.x, connection_pt.position.y)
    if pts.size() < 1 || pts[-1] != pt:
        pts.append(pt)
        clicked_pt_count += 1
    
func _on_landscape_clicked(viewport: Node, event: InputEvent, shape_idx: int,
                           landscape: Node):
    if event.is_pressed() && event.button_index == MOUSE_BUTTON_LEFT:
        landscape.queue_free() # remove child safely at the end of frame
        self.remove_child(landscape) # remove child from tree now so we redraw
                                     # correctly.
        queue_redraw()
        
func _draw():
    # Draw all static bodies.
    for child in self.get_children():
        if child is StaticBody2D:
            #print("redrawing")
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
            draw_line(start, stop, Color.BLACK, size.y)
