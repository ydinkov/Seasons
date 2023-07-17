extends MeshInstance3D

var speed = 1.0
var amplitude = 5.0
var time = 0.0

func _process(delta):
	time += delta * speed

	var x = amplitude * cos(time)
	var y = 1  # Phase shift for figure-8 movement
	var z = amplitude * sin(2 * time)  # Maintain the same Z coordinate

	self.transform.origin = Vector3(x, y, z)

