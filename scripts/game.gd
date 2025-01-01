extends Node2D

@onready var player_spawn = $PlayerSpawnPosition
@onready var laser_container = $LaserContainer
@onready var timer = $EnemySpawnTimer
@onready var enemy_container = $EnemyContainer
@onready var game_over_screen = $UILayer/GameOverScreen
@onready var parallax_background = $ParallaxBackground
@onready var laser_sound = $SFX/LaserSound
@onready var lose_sound = $SFX/LoseSound

@export var enemy_scenes:Array[PackedScene] = []

@onready var hud = $UILayer/HUD

var player = null
var score := 0:
	set(value):
		score = value
		hud.score = score
		
var high_score

var scroll_speed = 200

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var save_file = FileAccess.open("user://save.data", FileAccess.READ)
	if save_file != null:
		high_score = save_file.get_32()
	else:
		high_score = 0
	
	hud.score = 0
	player = get_tree().get_first_node_in_group("player")
	assert(player != null)
	player.global_position = player_spawn.global_position
	player.laser_shot.connect(_on_player_laser_shot)
	player.killed.connect(_on_player_killed)
	game_over_screen.visible = false
	
func save_game():
	var save_file = FileAccess.open("user://save.data", FileAccess.WRITE)
	save_file.store_32(high_score)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	elif  Input.is_action_just_pressed("reset"):
		get_tree().reload_current_scene()
	
	if timer.wait_time > 0.5:	
		timer.wait_time -= delta * 0.005
		print(timer.wait_time)
	elif timer.wait_time < 0.5:
		timer.wait_time = 0.5
		
	parallax_background.scroll_offset.y += delta * scroll_speed
	if parallax_background.scroll_offset.y >= 1440:
		parallax_background.scroll_offset.y = 0
		
func _on_player_laser_shot(laser_scene, location):
	var laser = laser_scene.instantiate()
	laser.global_position = location
	laser_container.add_child(laser)
	laser_sound.play()
	
func _on_player_killed():
	lose_sound.play()
	game_over_screen.set_score(score)
	if score > high_score:
		high_score = score
	save_game()
	game_over_screen.set_highscore(high_score)
	await get_tree().create_timer(1.5).timeout
	game_over_screen.visible = true
	


func _on_enemy_spawn_timer_timeout() -> void:
	var e = enemy_scenes.pick_random().instantiate()
	e.global_position = Vector2(randf_range(50, 760), -50)
	e.killed.connect(_on_enemy_killed)
	enemy_container.add_child(e)
	
func _on_enemy_killed(points):
	score += points
	
