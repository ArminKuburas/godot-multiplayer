extends Node2D

signal toggle(state)

@export var plate_up: Sprite2D
@export var plate_down: Sprite2D
@export var is_down = false

var bodies_on_plate = 0

func _on_area_2d_body_entered(_body: Node2D) -> void:
	if not multiplayer.is_server():
		return
	bodies_on_plate += 1
	update_plate_state()


func _on_area_2d_body_exited(_body: Node2D) -> void:
	if multiplayer.multiplayer_peer == null:
		return
	if not multiplayer.is_server():
		return
	bodies_on_plate -= 1
	update_plate_state()

func update_plate_state():
	var was_down: bool = is_down
	is_down = bodies_on_plate >= 1
	if was_down != is_down:
		toggle.emit(is_down)
	set_plate_properties()

func set_plate_properties():
	plate_down.visible = is_down
	plate_up.visible = !is_down


func _on_multiplayer_synchronizer_synchronized() -> void:
	set_plate_properties()


func _on_multiplayer_synchronizer_delta_synchronized() -> void:
	set_plate_properties()
