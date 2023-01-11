extends CharacterBody2D
class_name Character
#class_name Character, "res://Art/v1.1 dungeon crawler 16x16 pixel pack/heroes/knight/knight_idle_anim_f0.png"

#const HIT_EFFECT_SCENE: PackedScene = preload("res://Characters/HitEffect.tscn")

const FRICTION: float = 0.15

@export var max_hp: int = 2
@export var hp: int = 2:
	set(new_hp):
		hp = clamp(new_hp, 0, max_hp)
		emit_signal("hp_changed", hp)

signal hp_changed(new_hp)

@export var accerelation: int = 40
@export var max_speed: int = 100

@export var flying: bool = false

#@onready var state_machine: Node = get_node("FiniteStateMachine")
@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")

@onready var state_machine

@onready var death_effect: PackedScene = preload("res://scenes/character/death_effect/death_effect.tscn")

var mov_direction: Vector2 = Vector2.ZERO
var Velocity: Vector2 = Vector2.ZERO



func _physics_process(_delta: float) -> void:
	if state_machine.state == state_machine.states.death:
		velocity = Vector2.ZERO
		Velocity = Vector2.ZERO
	#if state_machine.state == state_machine.states.hurt or state_machine.state == state_machine.states.death:
		#velocity = Vector2.ZERO
		#Velocity = Vector2.ZERO
	move(_delta)
	
	
func move(delta) -> void:
	velocity += Velocity  * accerelation * 30
	velocity = velocity.clamp(-Vector2(max_speed, max_speed), Vector2(max_speed, max_speed))
	move_and_slide()
	#move_and_collide(velocity*delta)
	
	velocity = lerp(velocity, Vector2.ZERO, FRICTION)
	
func take_damage(dam: int, dir: Vector2, force: int) -> void:
	#if state_machine.state != state_machine.states.hurt and state_machine.state != state_machine.states.dead:
		#_spawn_hit_effect()
	#	self.hp -= dam
		#if name == "Player":
			#SavedData.hp = hp
			#if hp == 0:
			#	SceneTransistor.start_transition_to("res://Game.tscn")
			#	SavedData.reset_data()
	#	if hp > 0:
			#state_machine.set_state(state_machine.states.hurt)
	#		velocity += dir * force
	#	else:
			#state_machine.set_state(state_machine.states.dead)
	#		velocity += dir * force * 2
	pass
		

	
	
func _spawn_hit_effect() -> void:
	#var hit_effect: Sprite = HIT_EFFECT_SCENE.instance()
	#add_child(hit_effect)
	pass


func _spawn_death_effect() -> void:
	pass
	#var effect = death_effect.instantiate()
	#effect.global_position = global_position
	#get_tree().current_scene.get_node("TileMap").add_child(effect)
	#effect.get_node("AnimationPlayer").play("death")
	
	
