extends CharacterBody2D
class_name Player

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var _animation = $AnimatedSprite2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _physics_process(delta):
    # Add the gravity.
    if not is_on_floor():
        velocity.y += gravity * delta

    move_and_slide()
    
    # bounding box
    var width = get_viewport_rect().size.x
    if position.x < 30:
        position.x = 30
    if position.x > width - 30:
        position.x = width - 30

    if abs(velocity.x) > 0:
        _animation.play("run")
        _animation.flip_h = velocity.x < 0
    else:
        _animation.play("default")

    if not is_on_floor():
        _animation.play("fall")

func add_controls(delta):
    if Input.is_action_just_pressed("ui_up") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    # Get the input direction and handle the movement/deceleration.
    # As good practice, you should replace UI actions with custom gameplay actions.
    var direction = Input.get_axis("ui_left", "ui_right")
    if direction:
        self.velocity.x = direction * SPEED
    else:
        velocity.x = move_toward(velocity.x, 0, SPEED)
        
