extends Character
class_name Enemy

@onready var nav_agent = $NavigationAgent2D
@onready var health_bar = get_node("Sprite2D")

@onready var player = get_tree().current_scene.get_node("TileMap/Player")

@onready var coin = preload("res://scenes/material/coin/coin.tscn")

@onready var explosion = preload("res://scenes/explosion/explosion.tscn")

var set_target_loc = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	_set_label_hp()
	


func take_damage(dam: int, dir: Vector2, force: int) -> void:
	#print("ouch")
	#if state_machine.state != state_machine.states.hurt:
		hp -= dam
		_set_label_hp()
		#velocity = Vector2.ZERO
		#velocity += dir * force * 100
		state_machine.set_state(state_machine.states.hurt)
		check_hp()


func check_hp():
	if hp <= 0:
		state_machine.set_state(state_machine.states.death)
		

func _set_label_hp():
	$LabelHolder/RichTextLabel.text = "Hp: " + str(hp)

func _check_on_fire():
	if has_node("OnFire"):
		animated_sprite.self_modulate = Color(10, 1, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	# Calculate the percentage of the current health
	#$LabelHolder/RichTextLabel.text = "Hp: " + str(hp)
	#var health_percent:float = (hp + 0.0) / max_hp
	#print(health_percent)
	# Scale the health bar sprite according to the health percentage
	#health_bar.scale = Vector2(health_percent, 0.125)
	pass

func get_input():
	
	Velocity = global_position.direction_to(nav_agent.get_next_location())
	
	#if not set_target_loc:
	
		#set_target_loc = true
	#nav_agent.set_target_location(target.global_position)
	

func set_fire():
	var fire = load("res://scenes/status_effects/on_fire.tscn").instantiate()
	add_child(fire)
	animated_sprite.self_modulate = Color(10, 1, 1)

func _update_enemy_count():
	get_tree().current_scene.get_node("SpawnPoint").enemy_count -= 1
	#_spawn_coins()


func _on_update_route_timeout():
	nav_agent.set_target_location(player.global_position)


func _spawn_coins():
	var RNG: RandomNumberGenerator = RandomNumberGenerator.new()
	RNG.randomize()
	for i in RNG.randi_range(1,4):
		var temp_coin = coin.instantiate()
		get_tree().current_scene.get_node("TileMap").add_child(temp_coin)
		temp_coin.global_position = global_position
		RNG.randomize()
		temp_coin.upwards_velocity.x = RNG.randf_range(-3, 3)
		temp_coin.start_pos = global_position
		temp_coin.x_vel = temp_coin.upwards_velocity.x

func _spawn_explosion():
	var temp_explosion = explosion.instantiate()
	temp_explosion.global_position = global_position
	temp_explosion.get_child(0).emitting = true
	temp_explosion.get_child(0).get_child(0).emitting = true
	get_tree().current_scene.get_node("TileMap").add_child(temp_explosion)
