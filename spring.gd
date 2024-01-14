extends Player
class_name Spring

var jumping = false

func _physics_process(delta):
    if jumping: 
        move_and_slide()
        return
    velocity.x = 50
    super._physics_process(delta)

func jump():
    jumping = true
    $AnimatedSprite2D.play("jump")
    velocity.x = 100
    var tween = create_tween()
    tween.tween_property(self, "position:y", position.y - 100, 1)
    tween.tween_callback(func(): jumping = false)

func _on_area_2d_area_entered(area):
    if area.name == "jump":
        jump()
