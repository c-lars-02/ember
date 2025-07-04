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
	var views = dungeoneer.look()
	
	print("View: ", views)
	
	for child in get_children():
		for sprite in child.get_children():
			sprite.hide()
	
	if views[0][0] != 0:
		$Layer0/center.show()
		return
	
	$Layer1/floor.show()
	$Layer1/ceiling.show()
	if views[0][1] != 0:
		$Layer1/right.show()
	if views[0][2] != 0:
		$Layer1/left.show()
	if views[1][0] != 0:
		$Layer1/center.show()
	
	$Layer2/floor.show()
	$Layer2/ceiling.show()
	if views[1][1] != 0:
		$Layer2/right.show()
		$Layer1/right_front.show()
	if views[1][2] != 0:
		$Layer2/left.show()
		$Layer1/left_front.show()
	if views[2][0] != 0:
		$Layer2/center.show()
	
	$Layer3/floor.show()
	$Layer3/ceiling.show()
	if views[2][1] != 0:
		$Layer3/right.show()
		$Layer2/right_front_1.show()
	if views[2][2] != 0:
		$Layer3/left.show()
		$Layer2/left_front_1.show()
	if views[2][3] != 0:
		$Layer2/right_front_2.show()
	if views[2][4] != 0:
		$Layer2/left_front_2.show()
	if views[3][0] != 0:
		$Layer3/center.show()
		
	if views[3][1] != 0:
		$Layer3/right_front_1.show()
	if views[3][2] != 0:
		$Layer3/left_front_1.show()
	if views[3][3] != 0:
		$Layer3/right_front_2.show()
	if views[3][4] != 0:
		$Layer3/left_front_2.show()
	if views[3][5] != 0:
		$Layer3/right_front_3.show()
	if views[3][6] != 0:
		$Layer3/left_front_3.show()
	if views[3][7] != 0:
		$Layer3/right_front_4.show()
	if views[3][8] != 0:
		$Layer3/left_front_4.show()
