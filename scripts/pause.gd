extends Node2D

func _ready():
	process_mode = Node.PROCESS_MODE_WHEN_PAUSED

func _process(delta: float) -> void:
	show()
	await get_tree().create_timer(0.167).timeout
	if Input.is_action_just_pressed("pause"):
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		hide()
		get_tree().paused = false


func _on_button_pressed() -> void:
	get_tree().quit()
