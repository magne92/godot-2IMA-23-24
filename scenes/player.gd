extends CharacterBody2D

var pos = Vector2.ZERO
var target = position
var angle_to_player
var move_vector

var camera
var speed_crash_minimum = 200
var max_speed = 200
var speed = max_speed
var rotation_speed = max_speed / speed + 1
var altitude = 10
var scaling
var rocket_scene = preload("res://scenes/rocket.tscn")
var acceleration = 3
var shoot_point


# Called when the node enters the scene tree for the first time.
func _ready():
	pos = Vector2(100,200)
	position = pos
	#$Camera2D.current = true
	#camera.current = true

func _input(event):
	#if event.is_action_pressed("click"):
	target = get_global_mouse_position()
		

func set_altitude(delta, speed):
	if speed < speed_crash_minimum:
		altitude -=  (75 - speed) * delta / 10
		if altitude <= 3:
			queue_free()
	else:
		altitude += 1 * delta
	
	altitude = clamp(altitude, 1, 10)
	#print(altitude)


func shoot():
	$Shoot_CD.start()
	var rocket = rocket_scene.instantiate()
	rocket.position = $Marker2D.global_position
	rocket.rotation = rotation
	rocket.velocity = velocity
	get_parent().add_child(rocket)


func _process(delta):
	set_altitude(delta, speed)
	rotation_speed = max_speed  / (speed + 1)
	rotation_speed = clamp(rotation_speed,1,10)
	print(rotation_speed)
	#print(rotation)
	#camera.rotation = rotation
	#move_vector = position.direction_to(target).normalized()
	if Input.is_action_pressed("increase_speed"):
		speed += acceleration
	if Input.is_action_pressed("decrease_speed"):
		speed -= acceleration
		
	scaling = (altitude) / 10
	scale.x = scaling
	scale.y = scaling
	speed = clamp(speed,0,200)
	#print(speed)
	
	if Input.is_action_pressed("turn_right"):
		rotation += rotation_speed * delta
	if Input.is_action_pressed("turn_left"):
		rotation += -rotation_speed * delta

	velocity = Vector2(1, 0).rotated(rotation) * speed
	move_and_slide()
	
	
	if Input.is_action_pressed("shoot") and $Shoot_CD.is_stopped():
		shoot()
	
		
	#velocity.x += move_vector.x.rotated(rotation) * speed * delta
	#velocity.y += move_vector.y.rotated(rotation) * speed * delta
	#look_at(target)
	#angle_to_player = global_position.direction_to(target).angle()
	# slowly changes the rotation to face the angle
	#rotation = move_toward(rotation, angle_to_player, delta)
#	if position.distance_to(target) > 10:
#		move_and_slide()
#		pass
	
#	pos.x += speed * delta
#	position = pos

func _on_shoot_cd_timeout():
	print("timer timeout")
