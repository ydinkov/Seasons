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


@export var lit: bool = false:
	get:
		return $Bottom/OmniLight3D.visible
	set(value):
		$Bottom/OmniLight3D.visible = value

@export var closed: bool = false:
	get:
		return $Bottom/Closed.visible
	set(value):
		$Bottom/Closed.visible = value
		$Bottom/Closed/Closed2/Area3D.monitorable = !value
		$Bottom/Closed/Closed2/Area3D.monitoring = !value
