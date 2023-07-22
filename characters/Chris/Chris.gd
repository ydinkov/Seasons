extends Node3D

@export var dialog : String:
	get:
		return $DialogBox/Label.text
	set(val):
		$DialogBox/Label.text = val
		

@export_enum("NOTHING","Matches","Dynamite") var loot : String

func _on_area_3d_body_entered(body):
	if(body is CharacterBody3D):
		$DialogBox.visible = true
	pass # Replace with function body.


func _on_area_3d_body_exited(body):
	$DialogBox.visible = false
	pass # Replace with function body.
