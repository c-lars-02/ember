extends Node3D

@export var mat = ""

var compass = {0: "front", 1: "right", 2: "back", 3: "left"}
var walls = [0, 0, 0, 0]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if mat != "":
		var resource_path = "res://resources/gfx/materials/cell_" + mat + ".tres"
		var material_resource = load(resource_path) # TODO: Probably best to preload all textures instead?
		var walls = [$back, $left, $front, $right]
		for wall in walls:
			wall.set_material_override(material_resource)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func toggle_wall(wall: int):
	var wall_node = get_node(compass[wall])
	if walls[wall] == 0:
		wall_node.show()
		get_node(compass[wall] + "/StaticBody3D/CollisionShape3D").disabled = false
	elif walls[wall] == 1:
		wall_node.hide()
		get_node(compass[wall] + "/StaticBody3D/CollisionShape3D").disabled = true


func _on_area_3d_body_entered(body: Node3D) -> void:
	print("he steppin on da bricks")
