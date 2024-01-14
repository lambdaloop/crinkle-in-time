extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var line = Line2D.new() # Replace with function body.
	line.points = PackedVector2Array([
		Vector2(100, 100),
		Vector2(150, 150)
	])
	add_child(line)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
