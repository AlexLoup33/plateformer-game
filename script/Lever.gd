extends StaticBody2D

onready var ON = $On
onready var OFF = $Off
var open = false
var opening = false

func _ready():
	OFF.show()
	ON.hide()

func _process(delta):
	if opening == true and open == false:
		var bodies_array = $Area2D.get_overlapping_bodies()
		for body in bodies_array:
			if body.has_method("opening"):
				body.opening()
				$Area2D/CollisionShape2D.queue_free()

func interaction():
	ON.show()
	OFF.hide()
	opening = true
