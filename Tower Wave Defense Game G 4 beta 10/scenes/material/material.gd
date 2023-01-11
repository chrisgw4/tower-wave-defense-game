extends RigidBody2D


@export var bounce_height: int
@export var upwards_velocity: Vector2 = Vector2(0, -3)
var x_vel: float
@export var friction_y: float
@export var friction_x: float

@onready var coin_particle: PackedScene = preload("res://scenes/explosion/coin_drop.tscn")


var start_pos: Vector2

# boolean saying whether the coin is floating back down to start_pos
var going_back: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	_spawn_particle_on_self()
	


func _spawn_particle_on_self():
	var temp = coin_particle.instantiate()
	add_child(temp)
	temp.get_child(0).emitting = true	
	temp.global_position = global_position

func _spawn_particle():
	var temp = coin_particle.instantiate()
	get_tree().current_scene.get_node("TileMap").add_child(temp)
	
	
	temp.global_position = global_position
	temp.get_child(0).emitting = true
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_and_collide(upwards_velocity)
	upwards_velocity.y = lerp(upwards_velocity.y, 0.0, friction_y)
	upwards_velocity.x = lerp(upwards_velocity.x, 0.0, friction_x)
	if upwards_velocity.y > -0.02 and not going_back:
		upwards_velocity.y = .4
		friction_y = 0.00001
		going_back = true
	#print(start_pos)
	if global_position.y >= start_pos.y and going_back:
		#set_process(false)
		upwards_velocity = Vector2.ZERO
		#print("DONE")
	




func _on_body_entered(body: Character) -> void:
	#print("deez")
	if body is Player:
		body._add_coins()
		_spawn_particle()
		queue_free()
		#print("CACA")
		
