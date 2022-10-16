extends Node2D

signal hit

func _ready():
	pass

func _process(delta):
	pass

func _on_Area2D_body_entered(body):
	emit_signal("hit")
