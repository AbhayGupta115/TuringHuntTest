extends KinematicBody2D

onready var ray = $RayCast2D
onready var tween = $Tween

export var speed = 3
var tile_size = 16
var inputs = {"right": Vector2.RIGHT,
			"left": Vector2.LEFT,
			"up": Vector2.UP,
			"down": Vector2.DOWN}

func _ready():
	position = position.snapped(Vector2.ONE * tile_size)
	position += Vector2.ONE * tile_size/2


func _unhandled_input(event):
	if tween.is_active():
		return
	for dir in inputs.keys():
		if event.is_action(dir):
			move(dir)

func move(dir):
	ray.cast_to = inputs[dir] * tile_size
	ray.force_raycast_update()
	if !ray.is_colliding():
#		position += inputs[dir] * tile_size
		move_tween(dir)

func move_tween(dir):
	tween.interpolate_property(self, "position",
		position, position + inputs[dir] * tile_size,
		1.0/speed, Tween.TRANS_SINE, Tween.EASE_IN_OUT)
	tween.start()

#const ACCELERATION = 500
#const MAX_SPEED = 100
#const FRICTION = 500
#
#var velocity = Vector2.ZERO
#
#func _physics_process(delta):
#	var input_vector = Vector2.ZERO
#	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
#	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
#	input_vector = input_vector.normalized()
#
#	if input_vector != Vector2.ZERO:
#		velocity = velocity.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
#	else:
#		velocity = velocity.move_toward(Vector2.ZERO, FRICTION * delta)
#
#	move_and_slide(velocity)
