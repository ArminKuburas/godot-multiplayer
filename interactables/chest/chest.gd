extends Node2D

@export var key_scene: PackedScene
@export var key_spawn: Node2D
@export var chest_locked: Sprite2D
@export var chest_unlocked: Sprite2D
@export var is_locked = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_test_interact(state):
	if state:
		_on_interactable_interacted()

func _on_interactable_interacted():
	if is_locked:
		is_locked = false
	var key = key_scene.instantiate()
	key_spawn.add_child(key)
	set_chest_properties()

func set_chest_properties():
	chest_unlocked.visible = !is_locked
	chest_locked.visible = is_locked

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_multiplayer_synchronizer_delta_synchronized() -> void:
	set_chest_properties()
