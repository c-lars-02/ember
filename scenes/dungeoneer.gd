extends Node2D
var step_size = 64 # Should match the tile size of the map; this is the move distance
var coordinates = Vector2i(1, 1)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Vector2.ZERO
	var move_vector
	var destination
	
	if Input.is_action_just_pressed("ui_up"):
		destination = $"../TileMapLayer".get_neighbor_cell(coordinates, 12)
		move_vector = Vector2i(0, -1) # TODO: Optimize this to use pre-created vectors instead of making new every frame (dictionary/enum?)
	elif Input.is_action_just_pressed("ui_right"):
		destination = $"../TileMapLayer".get_neighbor_cell(coordinates, 0)
		move_vector = Vector2i(1, 0)
	elif Input.is_action_just_pressed("ui_down"):
		destination = $"../TileMapLayer".get_neighbor_cell(coordinates, 4)
		move_vector = Vector2i(0, 1)
	elif Input.is_action_just_pressed("ui_left"):
		destination = $"../TileMapLayer".get_neighbor_cell(coordinates, 8)
		move_vector = Vector2i(-1, 0)
	
	if move_vector:
		var tile_data = $"../TileMapLayer".get_cell_tile_data(destination)
		var tile_type = tile_data.get_custom_data("tile_type")
		print(tile_type)
		
		if tile_type == 0:
			coordinates += move_vector
			position = 64 * coordinates
