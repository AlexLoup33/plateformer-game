extends StaticBody2D

onready var AnimatedSprite = $AnimatedSprite
onready var CollisionShape = $CollisionShape2D
var Player = preload("res://Scene/Player.tscn")

enum STATE{
	Close, 
	Idle,
	Open,
}

var dict = {
	0 : "Close",
	1 : "Idle",
	2 : "Open"
}

func _ready():
	CollisionShape.disabled = true

