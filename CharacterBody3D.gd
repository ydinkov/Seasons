extends CharacterBody3D

var speed = 40.0
var can_teleport = true;
var interactable : Node3D



func _physics_process(delta):
	handle_input2()
	handle_turning()
	velocity.y += -100 * delta
	move_and_slide()
	
	if Input.is_action_pressed("interact") and interactable != null:
		if interactable.name == "Apple":
			interactable.queue_free()
			$UI/Apple.visible = true
		elif interactable.name == "Axe":
			interactable.queue_free()
			$UI/Axe.visible = true
		elif interactable.name == "Sword":
			interactable.queue_free()
			$UI/Sword.visible = true
		elif interactable.name == "Tree":
			if $UI/Axe.visible:
				interactable.get_node("AnimationPlayer").play("fall")
				interactable.get_parent().get_parent().get_parent().get_node("Winter/Chapel").fixed = true
				if interactable.get_parent().get_parent().name =="Summer":
					interactable.get_parent().get_parent().get_parent().get_node("Fall/Chapel").fixed = true
				if interactable.get_parent().get_parent().name =="Spring":
					interactable.get_parent().get_parent().get_parent().get_node("Fall/Chapel").fixed = true
					interactable.get_parent().get_parent().get_parent().get_node("Summer/Chapel").fixed = true
				
				
	pass
	#$Camera3D.global_rotation_degrees = Vector3(-35,0,0)

var joystick = 0
	
func handle_turning():
	var motion = Vector3()
	var input_x = Input.get_joy_axis(joystick, JOY_AXIS_RIGHT_X)
	var input_z = Input.get_joy_axis(joystick, JOY_AXIS_RIGHT_Y)
	if (input_x != 0 || input_z != 0):		
		$Body.look_at(global_position - Vector3(input_x, 0, input_z), Vector3.UP)
	
func handle_input2():
	var motion = Vector3()
	var input_x = Input.get_joy_axis(joystick, JOY_AXIS_LEFT_X)
	var input_z = -Input.get_joy_axis(joystick, JOY_AXIS_LEFT_Y)
	motion.x = input_x
	motion.z = -input_z
	if motion.length() > 1:
		self.velocity = motion.normalized() * speed
	else:
		var direction = Vector3.ZERO
		if Input.is_action_pressed("ui_right"):
			direction.x += 1
		if Input.is_action_pressed("ui_left"):
			direction.x -= 1
		if Input.is_action_pressed("ui_down"):
			direction.z += 1
		if Input.is_action_pressed("ui_up"):
			direction.z -= 1
		self.velocity = direction.normalized() * speed

func _on_area_3d_area_entered(area):
	interactable = area.get_parent()
	$UI/Label.text = "[X] to interact with " + interactable.name


func _on_area_3d_area_exited(area):	
	interactable = null
	$UI/Label.text = ""
