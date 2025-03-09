extends CharacterBody3D

var cell_size = 3
var walkspeed = 4
var turn_rate = PI / 2
var gravity = 9.81
var sensitivity = 0.0015


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#position = Vector3($"../Dungeoneer".coordinates.x * cell_size, 0.91,  $"../Dungeoneer".coordinates.y * cell_size)
	#rotation = Vector3(0, -$"../Dungeoneer".rotation, 0)
	movement_3d(delta)
	
	if Input.is_action_just_pressed("cam_1"):
		$"reggy eyes".make_current()
	elif Input.is_action_just_pressed("cam_2"):
		$"reggy eyes/lakitu cam".make_current()
	elif Input.is_action_just_pressed("cam_3"):
		$"reggy eyes/front cam".make_current()
		
		
func _unhandled_input(event: InputEvent) -> void: # TODO: Code taken from FPS multiplayer template from assetlib; need to understand it better and read up on input handling (e.g. _unhandled_input vs _input)
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * sensitivity)
		$"reggy eyes".rotation.x = clamp(($"reggy eyes".rotation.x - (event.relative.y * sensitivity)), (-PI / 2), (PI / 2))


func movement_3d(delta: float):
	var walk_velocity = Vector3.ZERO
	
	if Input.is_action_pressed("ui_up"):
		walk_velocity -= Vector3.RIGHT.rotated(Vector3.UP, rotation.y)
	if Input.is_action_pressed("ui_down"):
		walk_velocity -= Vector3.LEFT.rotated(Vector3.UP, rotation.y)
	if Input.is_action_pressed("ui_left"):
		walk_velocity -= Vector3.FORWARD.rotated(Vector3.UP, rotation.y)
	if Input.is_action_pressed("ui_right"):
		walk_velocity -= Vector3.BACK.rotated(Vector3.UP, rotation.y)
	
	walk_velocity = walk_velocity.normalized() * walkspeed
	if Input.is_action_pressed("sprint"):
		walk_velocity *= 2
	velocity = walk_velocity
	#if Input.is_action_just_pressed("jump"): TODO: JUMPING - ADD QUAKE SOUND
		#velocity += 64 * Vector3.UP
	velocity += gravity * Vector3.DOWN
	
	move_and_slide()
		
	print("rotation: ", rotation, "position: ", position)
