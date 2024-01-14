extends Player
class_name Jane


@onready var _animation_player = $AnimatedSprite2D

func _physics_process(delta):
	# Handle jump.
	velocity.x = 40
	super._physics_process(delta)

	


func _on_area_2d_area_entered(area):
	print(area.name)
	if area.name == "testarea":
		print("test")
		get_parent().background.texture = load("res://assets/background-1A-filtered-cut.jpg")
		get_parent().removable.position.y = -10000

