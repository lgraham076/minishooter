extends Node2D

@onready var player_spawn = $PlayerSpawnPosition
var player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player = get_tree().get_first_node_in_group("player")
	assert(player != null)
	player.global_position = player_spawn.global_position


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif  Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
