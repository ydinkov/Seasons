@tool
extends Area3D

@export var teleport_distance : int = 0


@export_range(0, 3) var frame: int = 0:
	get:
		return $Sprite3D.frame
	set(value):
		$Sprite3D.frame = value

func _on_body_entered(body : CharacterBody3D):
	if body.can_teleport == false: return
	body.can_teleport = false
	body.global_position.y = teleport_distance + 5
	pass # Replace with function body.


func _on_body_exited(body):
	if body is CharacterBody3D:
		body.can_teleport = true
	pass # Replace with function body.
