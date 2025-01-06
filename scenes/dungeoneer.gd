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
	map = $"../TileMapLayer"
	
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
		var tile_type = tile_data.get_custom_data("tile_type")
		print(tile_type)
		
		if tile_type == 0:
			coordinates += move_vector
			position = (step_size * coordinates) + OFFSET
	
	if not idle:
		emit_signal("moving")


func get_cell_tile_type(cell: Vector2i):
	return map.get_cell_tile_data(cell).get_custom_data("tile_type")
	
	
func look(): # TODO: Handle null instances coming up when exceeding bounds of the map
	var views = []
	
	var depth_increment = CARDINAL_DIRECTIONS[orientation]
	var lateral_positive = CARDINAL_DIRECTIONS[((orientation + 1) % 4)]
	var lateral_negative = CARDINAL_DIRECTIONS[((orientation - 1) % 4)]
	
	var view_0 = []
	view_0.append(get_cell_tile_type(coordinates + depth_increment))
	view_0.append(get_cell_tile_type(coordinates + depth_increment + lateral_positive))
	view_0.append(get_cell_tile_type(coordinates + depth_increment + lateral_negative))
	views.append(view_0)
	
	var view_1 = []
	view_1.append(get_cell_tile_type(coordinates + (depth_increment * 2)))
	view_1.append(get_cell_tile_type(coordinates + (depth_increment * 2) + lateral_positive))
	view_1.append(get_cell_tile_type(coordinates + (depth_increment * 2) + lateral_negative))
	views.append(view_1)
	
	var view_2 = []
	view_2.append(get_cell_tile_type(coordinates + (depth_increment * 3)))
	view_2.append(get_cell_tile_type(coordinates + (depth_increment * 3) + lateral_positive))
	view_2.append(get_cell_tile_type(coordinates + (depth_increment * 3) + lateral_negative))
	view_2.append(get_cell_tile_type(coordinates + (depth_increment * 3) + (lateral_positive * 2)))
	view_2.append(get_cell_tile_type(coordinates + (depth_increment * 3) + (lateral_negative * 2)))
	views.append(view_2)
	
	var view_3 = []
	view_3.append(get_cell_tile_type(coordinates + (depth_increment * 4)))
	view_3.append(get_cell_tile_type(coordinates + (depth_increment * 4) + lateral_positive))
	view_3.append(get_cell_tile_type(coordinates + (depth_increment * 4) + lateral_negative))
	view_3.append(get_cell_tile_type(coordinates + (depth_increment * 4) + (lateral_positive * 2)))
	view_3.append(get_cell_tile_type(coordinates + (depth_increment * 4) + (lateral_negative * 2)))
	view_3.append(get_cell_tile_type(coordinates + (depth_increment * 4) + (lateral_positive * 3)))
	view_3.append(get_cell_tile_type(coordinates + (depth_increment * 4) + (lateral_negative * 3)))
	view_3.append(get_cell_tile_type(coordinates + (depth_increment * 4) + (lateral_positive * 4)))
	view_3.append(get_cell_tile_type(coordinates + (depth_increment * 4) + (lateral_negative * 4)))
	views.append(view_3)
	
	return views
	
