extends CharacterBody2D

var explosion_scene = preload("res://scenes/explosion.tscn")

var speed = 500
var dmg = 20

# Called when the node enters the scene tree for the first time.
func _ready():
	name = "rocket"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	velocity = Vector2(1, 0).rotated(rotation) * speed
	move_and_slide()

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		print("I collided with ", collision.get_collider().name)
		collision.get_collider().take_dmg(dmg)
		var explosion = explosion_scene.instantiate()
		explosion.position = position
		get_parent().add_child(explosion)
		print("spawned explosion")
		queue_free()


