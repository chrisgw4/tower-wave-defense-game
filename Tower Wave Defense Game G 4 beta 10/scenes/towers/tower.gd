extends StaticBody2D
class_name Tower

@onready var animated_sprite = $AnimatedSprite2D
@onready var animation_player = $AnimationPlayer

@onready var delay_timer = $FireDelay

@export var num_projectiles: int
@export var fire_delay: float
@export var min_spread: float
@export var max_spread: float

@export var projectile: PackedScene

var closest_enemy = null

# keeps a list of the enemies in its "Area2D" and finds the closest one to attack
var enemies: Array = [] # kind of laggy



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	delay_timer.start(fire_delay)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# finds the enemies in the game list and goes through them to find the closest one in its range
func _get_closest_enemy():
	closest_enemy = enemies[0]

	#for i in range(1, len(enemies)):
	#	if global_position.distance_to(enemies[i].global_position) < global_position.distance_to(closest_enemy.global_position):
	#		closest_enemy = enemies[i]

func spawn_projectile(direction):
	
	# fires each projectile individually and aims at the closest enemy
	#for i in range(num_projectiles):
		#var new_projectile = projectile.instantiate()
		#new_projectile.set_global_position(get_node("ProjectileSpawn").get_global_position())
		
		#get_tree().current_scene.add_child(new_projectile)
		#new_projectile.look_at(closest_enemy.global_position)
		#new_projectile._fire(direction)
	var RNG = RandomNumberGenerator.new()
	
	
	for i in range(num_projectiles):
		RNG.randomize()
	
		var spread = RNG.randf_range(min_spread, max_spread)
		var new_projectile = projectile.instantiate()
		new_projectile.set_global_position(get_node("ProjectileSpawn").get_global_position())
		
		if spread < 0:
			spread += -.05
		elif spread > 0:
			spread += .05
		
		
		if i != 0:
			direction = direction.rotated(spread)
		
		get_tree().current_scene.add_child(new_projectile)
		new_projectile.look_at(new_projectile.global_position + direction)
		new_projectile._fire(direction)



func _on_area_2d_body_entered(body):
	enemies.append(body)
	#if closest_enemy == null:
	#	closest_enemy = body
	#elif global_position.distance_to(body.global_position):
	#	closest_enemy = body


func _on_area_2d_body_exited(body):
	#enemies.pop_at(enemies.find(body))
	enemies.erase(body)
	#if body == closest_enemy:
	#	closest_enemy = null


func _on_fire_delay_timeout():
	if len(enemies) <= 0:
	#if closest_enemy == null:
		delay_timer.start(fire_delay)
		return
	_get_closest_enemy()
	_face_dir()
	var dir = global_position.direction_to(closest_enemy.global_position)
	
	spawn_projectile(dir)
	delay_timer.start(fire_delay)

# changes the sprite to look towards the enemy its firing at
func _face_dir():
	if len(enemies) <= 0:
	#if closest_enemy == null:
		return
	var dir = closest_enemy.global_position - global_position
	
	var dir_x: String = ""
	var dir_y: String = ""
	
	if dir.x > 20:
		dir_x = "right"
	elif dir.x < -20:
		dir_x = "left"
	else:
		dir_x = "middle"
	
	#print(dir.y)
	if dir.y > 20:
		dir_y = "down"
	elif dir.y < -20:
		dir_y = "up"
	else:
		dir_y = "middle"
	
	# will play either left or right animations depending on dir_x
	if dir_y == "middle" and dir_x != "middle":
		animated_sprite.play(dir_x)
	if dir_y == "down" and dir_x != "middle":
		animated_sprite.play(dir_x + "_down")
	if dir_y == "up" and dir_x != "middle":
		animated_sprite.play(dir_x + "_up")
	
	if dir_x == "middle" and dir_y != "middle":
		animated_sprite.play(dir_y)
			
	
	
	
