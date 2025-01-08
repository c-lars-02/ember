extends MeshInstance3D

var walkspeed = 2
var turn_rate = PI / 2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("ui_up"):
		position += Vector3.FORWARD.rotated(Vector3.DOWN, -rotation.y) * walkspeed * delta
		
	if Input.is_action_pressed("ui_down"):
		position -= Vector3.FORWARD.rotated(Vector3.DOWN, -rotation.y) * walkspeed * delta
	
	if Input.is_action_pressed("ui_left"):
		rotation -= Vector3.DOWN * turn_rate * delta
		
	if Input.is_action_pressed("ui_right"):
		rotation += Vector3.DOWN * turn_rate * delta
		
	print("rotation: ", rotation, "position: ", position)
