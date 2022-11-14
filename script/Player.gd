extends KinematicBody2D

export (int) var speed = 300
export (int) var jump_speed = -1000
export (int) var gravity = 4000
export var max_jump = 2
var life = 3
var jump_count = 0

export (float, 0, 1.0) var friction = 0.15
export (float, 0, 1.0) var acceleration = 0.25

export (bool) var key = true

var velocity = Vector2.ZERO
onready var AnimatedSprite = $AnimatedSprite

signal hit;

enum STATE{
	Idle, 
	Run,
	Jump,
	DJump,
	Hit,
}

var dict = {
	0 : "Idle",
	1 : "Run",
	2 : "Jump",
	3 : "DJump",
	4 : "Hit"
}

var state;

func _ready():
	state = STATE.Idle

func get_input():
	var dir = 0
	if Input.is_action_pressed("Right"):
		dir += 1
	if Input.is_action_pressed("Left"):
		dir -= 1
	if dir != 0:
		velocity.x = lerp(velocity.x, dir * speed, acceleration)
	else:
		velocity.x = lerp(velocity.x, 0, friction)
	_update_animation(dir)

func _physics_process(delta):
	get_input()
	velocity.y += gravity * delta
	velocity = move_and_slide(velocity, Vector2.UP)
	
	if Input.is_action_pressed("interaction"):
		_update_interaction()
	
	if is_on_floor():
		jump_count = 0
	
	if Input.is_action_just_pressed("Jump"):
		if is_on_floor() or jump_count < max_jump:
			velocity.y = jump_speed
			jump_count += 1

func flipcheck(dir):
	if dir == -1:
		AnimatedSprite.flip_h =  true
		$Area2D/CollisionShape2D.position.x = -16
	elif dir == 1:
		AnimatedSprite.flip_h = false
		$Area2D/CollisionShape2D.position.x = 16

func _update_state(dir):
	if dir == 0 :
			state = STATE.Idle
	else : 
		state = STATE.Run
		if not is_on_floor():
			state = STATE.Jump
		if jump_count == 2:
			state = STATE.DJump

func _update_animation(dir):
	flipcheck(dir)
	_update_state(dir)
	AnimatedSprite.play(dict[state])

func _update_interaction():
	var bodies_array = $Area2D.get_overlapping_bodies()
	for body in bodies_array:
		if body.has_method("interaction"):
			body.interaction()

func hit():
	if not $Timer.is_stopped():
		pass
	else :
		$Timer.start()
		print("hit")
		state = STATE.Hit
		life -= 1
