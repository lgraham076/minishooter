extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_button_pressed() -> void:
	get_tree().reload_current_scene()
	
func set_score(value):
		$Panel/Score.text = "SCORE: " + str(value)
		
func set_highscore(value):
	$Panel/HighScore.text = "HI-Score: " + str(value)
