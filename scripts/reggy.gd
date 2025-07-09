extends CharacterBody3D

var walkspeed = 5
var gravity = 9.81
var sensitivity = 0.0015
var mass = 1
var tilesize = 1

var forces = []

signal touched(force)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	movement_3d(delta)
	
	if is_on_floor():
		pass
	
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
	var walk_direction = Vector3.ZERO
	
	if Input.is_action_pressed("ui_up"):
		walk_direction -= Vector3.RIGHT
	if Input.is_action_pressed("ui_down"):
		walk_direction -= Vector3.LEFT
	if Input.is_action_pressed("ui_left"):
		walk_direction -= Vector3.FORWARD
	if Input.is_action_pressed("ui_right"):
		walk_direction -= Vector3.BACK
	
	walk_direction = walk_direction.rotated(Vector3.UP, rotation.y).normalized()
	var walk_velocity = walk_direction * walkspeed
	var velocity_2d = Vector2(velocity.x, velocity.z)
	var walk_velocity_2d = Vector2(walk_velocity.x, walk_velocity.z)
	
	if walk_direction != Vector3.ZERO:
		if velocity != walk_velocity:
			velocity_2d = velocity_2d.move_toward(walk_velocity_2d, delta * 4)
			velocity.x = velocity_2d.x
			velocity.z = velocity_2d.y
	else:
		velocity_2d = velocity_2d.move_toward(Vector2.ZERO, delta * 5)
		velocity.x = velocity_2d.x
		velocity.z = velocity_2d.y
	
	velocity.y -= gravity * delta
		
	for force in forces:
		print(force.magnitude)
		velocity += force.direction * (force.magnitude/mass)
		force.life -= delta
		force.magnitude -= delta * force.decay
		if force.life < 0:
			forces.erase(force)
	
	move_and_slide()


func exert_force(force: Force):
	forces.append(force)
	$"reggy mouth".play()
	spray_blood()
	
	
func spray_blood():
	$blood.emitting = true
	await get_tree().create_timer(0.05).timeout
	$blood.emitting = false
