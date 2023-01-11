extends Node2D
class_name Weapon

#const projectile: PackedScene = preload("res://Characters/HitEffect.tscn")
@export var num_projectiles: int = 0
@export var max_spread: float = 0
@export var min_spread: float = 0
@export var fire_delay: float 


@export var projectile: PackedScene

@onready var parent = get_parent().get_parent()
@onready var animated_sprite = get_node("AnimatedSprite2D")

@onready var delay: Timer = get_node("FireDelay")

var can_shoot: bool = true

var stop_shoot: bool = false


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if visible and can_shoot and not stop_shoot and Input.is_action_pressed("fire") :
		spawn_projectile(parent.global_position.direction_to(get_global_mouse_position()))
		delay.start(fire_delay)
		can_shoot = false

func spawn_projectile(direction):
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
		new_projectile.look_at(get_global_mouse_position())
		new_projectile._fire(direction)
	#new_projectile.animated_sprite.h_flip = true
	
	#new_projectile.fire()
	


func _on_fire_delay_timeout():
	can_shoot = true
