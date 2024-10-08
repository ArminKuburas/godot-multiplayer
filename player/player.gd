extends CharacterBody2D

@export var movement_speed = 300
@export var gravity = 30
@export var jump_strength = 600

@export var player_sprite: AnimatedSprite2D

@onready var initial_sprite_scale = player_sprite.scale

func _physics_process(delta: float) -> void:
	var horizontal_input = (
		Input.get_action_strength("move_right")
		- Input.get_action_strength("move_left")
		)
	velocity.x = horizontal_input * movement_speed
	velocity.y += gravity
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_strength
	
	move_and_slide()
	
	player_sprite.play("fall")
	
	if not is_zero_approx(horizontal_input):
		if horizontal_input < 0:
			player_sprite.scale = Vector2(-initial_sprite_scale.x, initial_sprite_scale.y)
		else:
			player_sprite.scale = initial_sprite_scale
