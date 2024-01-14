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
	var landscape = Area2D.new()
	landscape.visible = true
	var line = CollisionShape2D.new()
	var shape = SegmentShape2D.new()
	shape.a = pts[0]
	shape.b = pts[1]
	line.set_shape(shape)
	# This works with polgyons too if we have at least 3 points.
	#var line = CollisionPolygon2D.new()
	#line.set_polygon([pts[0], pts[1], Vector2(0,0)])
	landscape.add_child(line)
	# Save it somewhere. Dictionary?
	# Save it to current node for now.
	self.add_child(landscape)
	# Use position as dict key. FIXME: sort.
	#var pt_key_array = [pts[0].x, pts[0].y, pts[1].x, pts[1].y]
	#segments[pt_key_array] = landscape
	# Cleanup for defining a new line from future clicks.
	clicked_pt_count = 0
	pts.clear()
	
func _on_any_connection_pt_clicked(connection_pt):
	# line drawing logic here.
	var pt = Vector2(connection_pt.position.x, connection_pt.position.y)
	if pts.size() < 1 || pts[-1] != pt:
		pts.append(pt)
		clicked_pt_count += 1
	#print(pts)
