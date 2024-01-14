extends Player
class_name Spring


func _physics_process(delta):
	velocity.x = 40
	super._physics_process(delta)
