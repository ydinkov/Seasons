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
		if interactable.name.contains("Apple"):
			interactable.queue_free()
			$UI/Apple.visible = true
			$Progress.play()
		elif interactable.name == "Clara":
			if($UI/Apple.visible == true and interactable.loot == "Matches"):
				interactable.dialog = "CLARA: Yum! I feel like skating when the river is frozen over like this"
				$UI/Apple.visible = false
				$UI/Matches.visible = true
				$Progress.play()
		elif interactable.name == "Chris":
			if($UI/Apple.visible == true and interactable.loot == "Dynamite"):
				interactable.dialog = "CHRIS: Mmm..That dynamite can blast through anything. But it's not as strong as the flow of the river over time..."
				$UI/Apple.visible = false
				$UI/Dynamite.visible = true
				$Progress.play()
		elif interactable.name == "Axe":
			interactable.queue_free()
			$UI/Axe.visible = true
			$Progress.play()
		elif interactable.name == "Sword":
			interactable.queue_free()
			interactable.get_parent().get_parent().get_node("Winter/Sword").queue_free
			interactable.get_parent().get_parent().get_node("Fall/Sword").queue_free	
			$UI/ColorRect.visible = true
			$Progress.play()			
			$WinterMusic.stop()
			$FallMusic.stop()
			$SummerMusic.stop()
			$SpringMusic.stop()
			$UI/ColorRect/Credits.play();		
			$UI/ColorRect/AnimationPlayer.play("scroll_up")
			$UI/Sword.visible = true
			get_tree().paused = true
		elif interactable.name == "Tree":
			if $UI/Axe.visible:
				interactable.get_node("AnimationPlayer").play("fall")
				interactable.get_parent().get_parent().get_parent().get_node("Winter/Chapel").fixed = true
				if interactable.get_parent().get_parent().name =="Summer":
					interactable.get_parent().get_parent().get_parent().get_node("Fall/Chapel").fixed = true
				if interactable.get_parent().get_parent().name =="Spring":
					interactable.get_parent().get_parent().get_parent().get_node("Fall/Chapel").fixed = true
					interactable.get_parent().get_parent().get_parent().get_node("Summer/Chapel").fixed = true
		elif interactable.name == "Crystal":
			if $UI/Dynamite.visible and $UI/Matches.visible:
				$UI/Dynamite.visible = false				
				if interactable.get_parent().name =="Winter":
					interactable.get_parent().get_parent().get_node("Winter/Crystal/AnimationPlayer").play("fall")
				if interactable.get_parent().name =="Fall":
					interactable.get_parent().get_parent().get_node("Winter/Crystal/AnimationPlayer").play("fall")
					interactable.get_parent().get_parent().get_node("Fall/Crystal/AnimationPlayer").play("fall")
				if interactable.get_parent().name =="Summer":
					interactable.get_parent().get_parent().get_node("Winter/Sword").visible = true
					interactable.get_parent().get_parent().get_node("Winter/Crystal").visible = false
					interactable.get_parent().get_parent().get_node("Fall/Crystal/AnimationPlayer").play("fall")
					interactable.get_parent().get_parent().get_node("Summer/Crystal/AnimationPlayer").play("fall")
				if interactable.get_parent().name =="Spring":
					interactable.get_parent().get_parent().get_node("Winter/Sword").visible = true
					interactable.get_parent().get_parent().get_node("Fall/Sword").visible = true
					interactable.get_parent().get_parent().get_node("Winter/Crystal").visible = false
					interactable.get_parent().get_parent().get_node("Fall/Crystal").visible = false					
					interactable.get_parent().get_parent().get_node("Summer/Crystal/AnimationPlayer").play("fall")
					interactable.get_parent().get_parent().get_node("Spring/Crystal/AnimationPlayer").play("fall")
					pass
				#	interactable.get_parent().get_parent().get_parent().get_node("Fall/Chapel").fixed = true
				#	interactable.get_parent().get_parent().get_parent().get_node("Summer/Chapel").fixed = true
				
				
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


func _on_spring_music_finished():
	$SpringMusic.play()

func _on_summer_music_finished():
	$SummerMusic.play()

func _on_fall_music_finished():
	$FallMusic.play()

func _on_winter_music_finished():
	$WinterMusic.play()

func switch_music_to(season):	
	$WinterMusic.stop()
	$FallMusic.stop()
	$SummerMusic.stop()
	$SpringMusic.stop()
	get_node(season+"Music").play()
	

func _on_rich_text_label_finished():
	get_tree().quit() # 
	pass # Replace with function body.
