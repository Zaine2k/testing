extends Node

@export var normal_time_scale: float = 1.0
@export var slowmo_time_scale: float = 0.5
@export var slowmo_duration: float = 2.0  # Slow-motion lasts for 2 seconds

@onready var power_sfx: AudioStreamPlayer = $power_sfx

var slowmo_active: bool = false

func _input(event):
	if event.is_action_pressed("bullet_time") and not slowmo_active:
		power_sfx.play()
		start_slow_motion()

func start_slow_motion():
	slowmo_active = true
	Engine.time_scale = slowmo_time_scale
	await get_tree().create_timer(slowmo_duration * slowmo_time_scale).timeout
	Engine.time_scale = normal_time_scale
	slowmo_active = false
