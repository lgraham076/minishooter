class_name Enemy extends Area2D

@export var speed = 150

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position.y += delta * speed
	
func die():
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		queue_free()
		body.die()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()
