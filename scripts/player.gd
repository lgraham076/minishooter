extends CharacterBody2D

@export var speed = 450

signal laser_shot(laser_scene, location)

var laser_scene = preload("res://scenes/laser.tscn")

func _process(_delta):
	if Input.is_action_just_pressed("shoot"):
		shoot()

func _physics_process(_delta: float) -> void:
	var direction = Vector2(Input.get_axis("move_left", "move_right"), 
					Input.get_axis("move_up", "move_down"))
	velocity = direction * speed
	
	move_and_slide()
	
func shoot():
	laser_shot.emit(laser_scene, $Muzzle.global_position)
