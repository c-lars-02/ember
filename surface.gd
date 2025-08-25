class_name Surface
extends Node

@export var surface_type = "normal"
@export var walk_acceleration = 16
@export var stop_acceleration = 24
@export var jump_height = 8
@export var bounciness = 1

func _init(type = "normal", walk_accel = 16, stop_accel = 24, jump = 8, bounce = 1):
	surface_type = type
	walk_acceleration = walk_accel
	stop_acceleration = stop_accel
	jump_height = jump
	bounciness = bounce
