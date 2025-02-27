extends CharacterBody2D

const JUMP_VELOCITY = -300.0

# Variables for character speed and jump count
var speed = 250.0
var jump_count = 0

# Variable for jump sfx
@onready var jump_sfx: AudioStreamPlayer = $jump_sfx

# Variable for acceleration and decceleration physics
@export_range(0,1) var decceleration = 0.1
@export_range(0,1) var acceleration = 0.1

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
	else:
		jump_count = 0
	
	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and jump_count < 2:
		jump_count += 1
		jump_sfx.play()
		velocity.y = JUMP_VELOCITY
		
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("key_left", "key_right")
	if direction:
		velocity.x = move_toward(velocity.x, direction * speed, speed * acceleration)
		$AnimatedSprite2D.play ("run")
	else:
		velocity.x = move_toward(velocity.x, 0, speed * decceleration)
		$AnimatedSprite2D.play ("idle")
		
		
	if direction == 1:
		$AnimatedSprite2D.flip_h = false
	elif direction == -1:
		$AnimatedSprite2D.flip_h = true
	move_and_slide()
	
