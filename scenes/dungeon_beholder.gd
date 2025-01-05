extends Node2D

var dungeoneer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	dungeoneer = $"../dungeoneer"
	_on_dungeoneer_moving()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_dungeoneer_moving() -> void:
	var view = dungeoneer.look()
	
	print("View: ", view)
	
	for child in get_children():
		child.hide()
	
	if view[0] != 0:
		$Layer0.show()
	else:
		$Layer1.show()
		if view[1] == 0:
			$Layer2.show()
