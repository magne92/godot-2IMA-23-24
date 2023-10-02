extends CharacterBody2D


const SPEED = 100.0
const JUMP_VELOCITY = -400.0
 
var rng = RandomNumberGenerator.new()


func _ready():
	var x = rng.randf_range(200.0, 300.0)
	var y = rng.randf_range(200.0, 300.0)
	
	position = Vector2(x,y)

func _physics_process(delta):
	velocity = Vector2(1, 0).rotated(rotation) * SPEED
	rotation += 1 * delta
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		print("I collided with ", collision.get_collider().name)
		queue_free()
	
	move_and_slide()
