extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var width = 8
	#var height = 8
	#
	#var map = []
	#for x in range(width):
		#map.append([])
		#for y in range(height):
			#map[x].append(0)
	#
	#for x in range(width):
		#for y in range(height):
			#print(map[x][y])
		#print('\n')
	print("Hello from dungeon.gd!")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("quit"):
		get_tree().quit()
