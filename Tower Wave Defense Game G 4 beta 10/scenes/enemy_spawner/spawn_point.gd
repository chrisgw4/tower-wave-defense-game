extends Node2D

@onready var enemy: PackedScene = preload("res://scenes/character/enemy/slime/slime.tscn")
@export var max_enemies: int
@export var spawn_time: float

# if the timer goes off when there is too many enemies to spawn more, this will keep track if its ready 
var ready_to_spawn: bool = false

var dont_spawn: bool = false

var enemy_count: int = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$SpawnDelay.start(spawn_time)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# if it is ready to spawn an enemy after previously being full, this will call timer to start with 0 seconds to spawn an enemy the next frame
	if ready_to_spawn:
		ready_to_spawn = false
		$SpawnDelay.start(0)
	pass
	
# slow way to count enemies
func _count_enemies() -> int:
	enemy_count = 0
	for child in get_tree().current_scene.get_node("TileMap").get_children():
		if "Slime" in child.name:
			enemy_count += 1
	return enemy_count

func _spawn_enemy():
	var temp_enemy = enemy.instantiate()
	
	#temp_enemy.set_global_position(global_position)
	#get_tree().current_scene.get_node("Enemies").add_child(temp_enemy)
	get_tree().current_scene.get_node("TileMap").add_child(temp_enemy)
	temp_enemy.global_position = global_position
	$SpawnDelay.start(spawn_time)
	
	
	#temp_enemy.hp = 40
	enemy_count += 1
	

func _on_spawn_delay_timeout():
	# if the timer goes off while there are the max amount of enemies allowed onscreen it will save the need to spawn an enemy as a boolean to do so once one enemy dies
	if enemy_count >= max_enemies or dont_spawn:
		ready_to_spawn = true
		return
	_spawn_enemy()


func _on_button_pressed():
	dont_spawn = not dont_spawn
