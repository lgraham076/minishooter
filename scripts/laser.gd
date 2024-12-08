extends Area2D


@export var speed = 800

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	global_position.y += delta * -speed


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()