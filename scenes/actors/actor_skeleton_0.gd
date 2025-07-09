extends CharacterBody3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	body.exert_force(Force.new(16, 0, 1, -body.velocity.normalized()))
