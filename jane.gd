extends Player
class_name Jane


@onready var _animation_player = $AnimatedSprite2D

func _physics_process(delta):
    # Handle jump.
    velocity.x = 50
    super._physics_process(delta)

    


func _on_area_2d_area_entered(area):
    pass
