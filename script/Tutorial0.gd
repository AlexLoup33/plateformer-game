extends Node2D

onready var Player = $Player
var positionPlayer = Vector2(-170, 64)

func _ready():
	Player.global_position = positionPlayer

func _process(delta):
	pass


func _on_Spike_hit():
	_restart()
	pass

func _restart():
	Player.global_position=positionPlayer
