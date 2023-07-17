extends CharacterBody3D

var speed = 10.0

func _physics_process(delta):
	handle_input2()
	handle_turning()
	move_and_slide()
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
		
		
	# Move the object
	

