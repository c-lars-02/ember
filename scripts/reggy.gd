extends CharacterBody3D

var walkspeed = 5
var gravity = 9.81
var sensitivity = 0.0015
var mass = 1
var tilesize = 1

var walk_acceleration: float
var stop_acceleration: float

var last_surface: int = -1

var forces = []

signal touched(force)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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
			velocity_2d = velocity_2d.move_toward(walk_velocity_2d, delta * walk_acceleration * walkspeed)
			velocity.x = velocity_2d.x
			velocity.z = velocity_2d.y
	else:
		velocity_2d = velocity_2d.move_toward(Vector2.ZERO, delta * stop_acceleration * walkspeed)
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
	
	var on_surface = null
	for i in get_slide_collision_count():
		var collider = get_slide_collision(i).get_collider()
		if collider.is_in_group("floor"):
			on_surface = collider.surface_properties
			walk_acceleration = on_surface.walk_acceleration
			stop_acceleration = on_surface.stop_acceleration
		if on_surface:
			walk_particles(on_surface.surface_type)

func walk_particles(on_surface_type): # TODO: cleanup, choose better var names
	var particles_old = $Particles.get_child(last_surface)
	var particles_new = $Particles.get_child(on_surface_type)
	if on_surface_type != last_surface:
		particles_old.emitting = false
		last_surface = on_surface_type
	
	if velocity.length() < 0.05:
		particles_new.emitting = false
	else:
		particles_new.amount_ratio = abs(velocity.length() / walkspeed / 2)
		particles_new.emitting = true


func exert_force(force: Force):
	forces.append(force)
	$"reggy mouth".play()
	spray_blood()
	
	
func spray_blood():
	$blood.emitting = true
	await get_tree().create_timer(0.05).timeout
	$blood.emitting = false
