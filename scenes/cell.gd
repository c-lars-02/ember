extends Node3D

@export var mat = ""

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
