extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

# Get the gravity fr012om the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var _animation_player = $AnimatedSprite2D

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	#velocity.x = SPEED
	if direction:
		velocity.x = direction * SPEED
		_animation_player.play("run")
		_animation_player.flip_h = direction < 0
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		_animation_player.play("default")
		
	if not is_on_floor():
		_animation_player.play("fall")

	move_and_slide()
	
	# bounding box
	var width = get_viewport_rect().size.x
	if position.x < 30:
		position.x = 30
	if position.x > width - 30:
		position.x = width - 30
	


func _on_mouse_entered():
	print("mouse entered")


func _on_static_body_2d_mouse_entered():
	print("mouse 2 entered") # Replace with function body.


func _on_static_body_2d_mouse_shape_entered(shape_idx):
	print("mouse entered 3") 


func _on_area_2d_area_entered(area):
	print(area.name)
	if area.name == "testarea":
		print("test")
		get_parent().background.texture = load("res://assets/background-1A-filtered-cut.jpg")
		get_parent().removable.position.y = -10000

