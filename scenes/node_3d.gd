extends Node3D

var cell_size = 3

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	generate_map()
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()
	if Input.is_action_just_pressed("save_scene"): # credit: https://forum.godotengine.org/t/how-to-save-node-like-scene-via-code/1240
		var node_to_save = $"@Node3D@2" # TODO: Figure out if we can change this name
		var scene = PackedScene.new()
		
		scene.pack(node_to_save)
		
		ResourceSaver.save(scene, "res://map_export.tscn")


#func _on_tile_map_layer_changed() -> void: # Doesn't work for dynamic map changes; signal isn't emitted when editing from Godot editor
	#print("TileMapLayer changed!")
	#if $world != null:
		#$world.queue_free()
	#generate_map()


func generate_map():
	var world = Node3D.new()
	add_child(world)
	$Dungeoneer.hide()
	var cell = preload("res://scenes/cell.tscn")
	var map = $TileMapLayer
	map.hide()
	var start_time = Time.get_ticks_msec()
	for square in map.get_used_cells():
		var new_cell = cell.instantiate()
		var tile_data = map.get_cell_tile_data(square)
		new_cell.mat = tile_data.get_custom_data("material")
		world.add_child(new_cell)
		new_cell.set_owner(world)
		new_cell.position.x = square.x * cell_size
		new_cell.position.z = square.y * cell_size
		if map.get_cell_tile_data(Vector2(square.x + 1, square.y)) == null:
			new_cell.get_child(4).show()
		if map.get_cell_tile_data(Vector2(square.x - 1, square.y)) == null:
			new_cell.get_child(1).show()
		if map.get_cell_tile_data(Vector2(square.x, square.y + 1)) == null:
			new_cell.get_child(5).show()
		if map.get_cell_tile_data(Vector2(square.x, square.y - 1)) == null:
			new_cell.get_child(3).show()
	print("Map built in: ", (Time.get_ticks_msec() - start_time), " ms")
