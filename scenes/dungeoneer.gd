extends Node2D
var step_size = 64 # Should match the tile size of the map; this is the move distance
var coordinates
var map
var orientation
var CARDINAL_DIRECTIONS = [Vector2i.UP, Vector2i.RIGHT, Vector2i.DOWN, Vector2i.LEFT]
var CARDINAL_NEIGHBORS = [12, 0, 4, 8]
var OFFSET = Vector2i(32, 32)
signal moving

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	orientation = 2
	map = $"../terrain"
	
	var x_coordinate = int(position.x) / step_size
	var y_coordinate = int(position.y) / step_size
	
	coordinates = Vector2i(x_coordinate, y_coordinate)
	position = (step_size * coordinates) + OFFSET
	
	print("Coordinates: ", coordinates)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2i.ZERO
	var move_vector
	var destination
	var idle = false
	
	if Input.is_action_just_pressed("ui_up"):
		move_vector = CARDINAL_DIRECTIONS[orientation]
		destination = map.get_neighbor_cell(coordinates, CARDINAL_NEIGHBORS[orientation])
	elif Input.is_action_just_pressed("ui_down"):
		var reverse_orientation = (orientation + 2) % 4
		move_vector = CARDINAL_DIRECTIONS[reverse_orientation]
		destination = map.get_neighbor_cell(coordinates, CARDINAL_NEIGHBORS[reverse_orientation])
	elif Input.is_action_just_pressed("ui_left"):
		orientation = (orientation - 1) % 4
		rotate(-PI/2)
	elif Input.is_action_just_pressed("ui_right"):
		orientation = (orientation + 1) % 4
		rotate(PI/2)
	else:
		idle = true
	
	if move_vector:
		var tile_data = map.get_cell_tile_data(destination)
		if tile_data == null:
			return
		#var tile_type = tile_data.get_custom_data("tile_type")
		#print(tile_type)
		#
		#if tile_type == 0
		else:
			coordinates += move_vector
			position = (step_size * coordinates) + OFFSET
	
	if not idle:
		emit_signal("moving")


#func get_cell_tile_type(cell: Vector2i):
	#return map.get_cell_tile_data(cell).get_custom_data("tile_type")
	
