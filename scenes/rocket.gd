extends CharacterBody2D

var speed = 500

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
		queue_free()


