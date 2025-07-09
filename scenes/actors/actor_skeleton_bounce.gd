extends Area3D

func _on_body_entered(body: Node3D) -> void:
	body.exert_force(Force.new(16, 0, 1, Vector3.UP))
