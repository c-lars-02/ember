extends Node3D

@export var colors = [Color.ORANGE, Color.ORANGE_RED]

var tween = create_tween()

func _ready():
	#$AnimationPlayer.play("flicker")
	torch_flicker(colors[0], colors[1])


func _process(delta: float):
	pass


func torch_flicker(color_start: Color, color_end: Color):
	tween.set_loops()
	tween.tween_property($OmniLight3D, "light_color", color_start, 2)
	tween.parallel().tween_property($MeshInstance3D2, "mesh:material:albedo_color", color_start, 2)
	tween.parallel().tween_property($OmniLight3D, "light_energy", 1.0, 2)
	tween.parallel().tween_property($MeshInstance3D2, "scale", Vector3(-0.12, -0.20, -0.13), 2)
	tween.tween_property($OmniLight3D, "light_color", color_end, 2)
	tween.parallel().tween_property($MeshInstance3D2, "mesh:material:albedo_color", color_end, 2)
	tween.parallel().tween_property($OmniLight3D, "light_energy", 0.5, 2)
	tween.parallel().tween_property($MeshInstance3D2, "scale", Vector3(-0.12, -0.20, -0.13) * 0.5, 2)
