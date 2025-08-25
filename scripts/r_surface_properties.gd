class_name SurfaceProperties extends Resource

enum SurfaceTypes {STONE, ICE}

@export var surface_type: SurfaceTypes
@export var walk_acceleration: float
@export var stop_acceleration: float
@export var jump_height: float
@export var bounciness: float

func _init(p_surface_type = SurfaceTypes.STONE, p_walk_acceleration = 16, p_stop_acceleration = 24, p_jump_height = 8, p_bounciness = 1):
	surface_type = p_surface_type
	walk_acceleration = p_walk_acceleration
	stop_acceleration = p_stop_acceleration
	jump_height = p_jump_height
	bounciness = p_bounciness
