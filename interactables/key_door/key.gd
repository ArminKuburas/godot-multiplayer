extends Node2D

@export var follow_offset: Vector2
@export var lerp_speed = 5
@export var target_position: Vector2 = Vector2.INF

var following_body

func _process(delta: float) -> void:
	if multiplayer.multiplayer_peer == null:
		return
	if multiplayer.is_server():
		if following_body != null:
			global_position = lerp(
				following_body.global_position + follow_offset, 
				global_position,
				pow(0.5, delta * lerp_speed))
			target_position = global_position
	else:
		global_position = HelperFunctions.ClientInterpolate(
			global_position,
			target_position,
			delta)


func _on_area_2d_area_entered(area: Area2D) -> void:
	following_body = area
