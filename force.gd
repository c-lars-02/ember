class_name Force
extends Node

@export var magnitude = 0
@export var life = 0
@export var decay = 1
@export var direction = Vector3.ZERO

func _init(strength = 160, lifespan = 0, dropoff = 1, orientation = Vector3.UP):
	magnitude = strength
	life = lifespan
	decay = dropoff
	direction = orientation
