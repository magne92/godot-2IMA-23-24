extends CharacterBody2D

var explosion_scene = preload("res://scenes/explosion.tscn")

const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var hp = 20
var follow = false
var target
 
var rng = RandomNumberGenerator.new()


func _ready():
	var x = rng.randf_range(200.0, 1000.0)
	var y = rng.randf_range(200.0, 300.0)
	position = Vector2(x,y)

func _physics_process(delta):
	velocity = Vector2(1, 0).rotated(rotation) * SPEED
	rotation += 1 * delta
	
	if follow:
		look_at(target.position)
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var collider = collision.get_collider()
		#print("I collided with ", collision.get_collider().name)
		#print(collider)
#		if "rocket" in collision.get_collider().name:
#			collider.queue_free()
#			print("delete rocket")
#
#		if collider.is_in_group("rockets"):
#			collider.queue_free()
		#queue_free()
	
	move_and_slide()

	
func take_dmg(dmg):
	hp -= dmg
	if hp <= 0:
		var explosion = explosion_scene.instantiate()
		explosion.position = position
		get_parent().add_child(explosion)
		queue_free()


func _on_area_2d_body_entered(body):
	print("area entered")
	if body.is_in_group("player"):
		follow = true
		print("following")
		target = body


func _on_area_2d_body_exited(body):
	if body.is_in_group("player"):
		follow = false
