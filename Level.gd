extends Node3D

func _process(delta):
	#var d = get_distance($CharacterBody3D,$MeshInstance3D) + 20
	#$CameraRig/Node/Camera3D.size = d
	#var pos = get_midpoint($CharacterBody3D,$MeshInstance3D)
	##pos.y += 5.0
	#$CameraRig.position = pos
	#$CameraRig.translate_object_local(Vector3(0,0,100))
	pass
	
func get_distance(node1: Node3D, node2: Node3D) -> float:
	return (node1.global_transform.origin - node2.global_transform.origin).length()

func get_midpoint(node1: Node3D, node2: Node3D) -> Vector3:
	return (node1.global_transform.origin + node2.global_transform.origin) / 2
