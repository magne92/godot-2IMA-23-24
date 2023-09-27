extends CharacterBody2D

var pos = Vector2.ZERO
var target = position
var rotation_speed = 5
var angle_to_player
var move_vector

var camera
var speed_crash_minimum = 200
var speed = 300
var altitude = 10
var scaling

# Called when the node enters the scene tree for the first time.
func _ready():
	pos = Vector2(100,200)
	position = pos
	#$Camera2D.current = true
	#camera.current = true

func _input(event):
	#if event.is_action_pressed("click"):
	target = get_global_mouse_position()
		

func _altitude(delta, speed):
	if speed < speed_crash_minimum:
		altitude -=  (101 - speed) * delta / 10
		if altitude <= 1:
			queue_free()
	else:
		altitude += 1 * delta
	
	altitude = clamp(altitude, 1, 10)
	print(altitude)
	
func _process(delta):
	_altitude(delta, speed)
	#print(rotation)
	#camera.rotation = rotation
	#move_vector = position.direction_to(target).normalized()
	if Input.is_action_pressed("increase_speed"):
		speed += 5
	if Input.is_action_pressed("decrease_speed"):
		speed -= 5
	scaling = (altitude) / 10
	
	scale.x = scaling
	scale.y = scaling
		
	speed = clamp(speed,0,200)
	print(speed)
	
	if Input.is_action_pressed("turn_right"):
		rotation += rotation_speed * delta
	if Input.is_action_pressed("turn_left"):
		rotation += -rotation_speed * delta
		
	#velocity.x += move_vector.x.rotated(rotation) * speed * delta
	#velocity.y += move_vector.y.rotated(rotation) * speed * delta

	velocity = Vector2(1, 0).rotated(rotation) * speed
	#look_at(target)
	#angle_to_player = global_position.direction_to(target).angle()
	# slowly changes the rotation to face the angle
	#rotation = move_toward(rotation, angle_to_player, delta)
	move_and_slide()
	
#	if position.distance_to(target) > 10:
#		move_and_slide()
#		pass
	
#	pos.x += speed * delta
#	position = pos
	
	#print(Input.is_action_pressed("shoot"))
