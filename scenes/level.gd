extends Node2D

const rotation_speed = 100
var enemy_scene = preload("res://scenes/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	#$player.rotation_degrees = 90.set_current()

	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if $Enemy_spawn.is_stopped():
		var enemy = enemy_scene.instantiate()
		$TileMap.add_child(enemy)
		$Enemy_spawn.start()
