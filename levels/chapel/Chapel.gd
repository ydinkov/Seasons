@tool
extends Node3D

@onready var fixed_ = false
@onready var unbroken_ = false

@export var fixed: bool = false:
	get: 
		return fixed_
	set(value):
		fixed_ = value
		if(value):rotation_degrees.z=180
		else: rotation_degrees.z=0
		$Tree/Top.visible = !value
		$Tree/StaticBody3D/CollisionShape3D.disabled = value


@export var unbroken: bool = false:
	get:
		return unbroken_
	set(value):
		unbroken_ = value
		if(value):rotation_degrees.z=180
		else: rotation_degrees.z=0
		$Tree.visible = value
		$Tree/StaticBody3D/CollisionShape3D.disabled = value
