extends StaticBody2D

onready var AnimatedSprite = $AnimatedSprite
onready var CollisionShape = $CollisionShape2D
var Player = preload("res://Scene/Player.tscn")

enum STATE{
	Close, 
	Open,
}

var dict = {
	0 : "Close",
	1 : "Open"
}

var state;

func _ready():
	CollisionShape.disabled = false
	state = STATE.Close

func opening():
	state = STATE.Open
	$CollisionShape2D.queue_free()

func _update_animation():
	$AnimatedSprite.play(dict[state])

func interaction():
	if state == STATE.Open:
		get_tree().change_scene("res://Scene/Level/Level" + str(int(get_tree().current_scene.name)+1) + ".tscn")
	else :
		pass

func _process(delta):
	_update_animation()
