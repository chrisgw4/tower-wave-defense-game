extends "res://scenes/character/character.gd"
class_name Player
#const DUST_SCENE: PackedScene = preload("res://Characters/Player/Dust.tscn")

var coins: int = 0

enum {UP, DOWN}

var current_weapon: Node2D

signal weapon_switched(prev_index, new_index)
signal weapon_picked_up(weapon_texture)
signal weapon_droped(index)

#@onready var parent: Node2D = get_parent()
@onready var weapons: Node2D = get_node("Weapons")
@onready var FSM = get_node("FiniteStateMachine")
@onready var weapon_holder: Node2D = get_node("WeaponHolder")
#@onready var dust_position: Position2D = get_node("DustPosition")

var mouse_dir: String = "left"
var mouse_dir_height: String = "up"
var mov_backward: bool = false


func _move_weapon(new_gun_name: String) -> void:
	var temp = weapon_holder.get_child(0)
	weapon_holder.remove_child(temp)
	weapons.add_child(temp)
	temp.visible = false
	
	
	var new_weapon: Weapon = weapons.get_node(new_gun_name)
	weapons.remove_child(new_weapon)
	weapon_holder.add_child(new_weapon)
	new_weapon.visible = true
	new_weapon.position = Vector2(0,0)
	


func _add_coins() -> void:
	coins += 1

func _ready() -> void:
	state_machine = get_node("FiniteStateMachine")
	#emit_signal("weapon_picked_up", weapons.get_child(0).get_texture())
	
	#_restore_previous_state()
	
	
func _restore_previous_state() -> void:
	#self.hp = SavedData.hp
	#for weapon in SavedData.weapons:
	#	weapon = weapon.duplicate()
	#	weapon.position = Vector2.ZERO
	#	weapons.add_child(weapon)
	#	weapon.hide()
		
	#	emit_signal("weapon_picked_up", weapon.get_texture())
	#	emit_signal("weapon_switched", weapons.get_child_count() - 2, weapons.get_child_count() - 1)
		
	#current_weapon = weapons.get_child(SavedData.equipped_weapon_index)
	#current_weapon.show()
	
	#emit_signal("weapon_switched", weapons.get_child_count() - 1, SavedData.equipped_weapon_index)
	pass

func _process(_delta: float) -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	#print(mouse_direction)
	if mouse_direction.x > 0.3:
		mouse_dir = "right"
		weapon_holder.scale = Vector2(1, 1)
	elif mouse_direction.x < -0.3:
		mouse_dir = "left"
		weapon_holder.scale = Vector2(-1, 1)
	else:
		mouse_dir = "middle"
	
	if mouse_direction.y > 0.3:
		mouse_dir_height = "down"
	elif mouse_direction.y < -0.3:
		mouse_dir_height = "up"
	else:
		mouse_dir_height = "middle"
	
	
	get_node("WeaponHolder").get_child(0).look_at(get_global_mouse_position())
	#if mouse_dir == "left":
	#	get_node("WeaponHolder").get_child(0).animated_sprite.flip_v = true
	#if mouse_dir == "left":
		#get_node("WeaponHolder").get_child(0).animated_sprite.flip_v = true
		#weapon_holder.flip_h = true
		#weapon_holder.scale = Vector2(-1, 1)
	#else:
		#get_node("WeaponHolder").get_child(0).animated_sprite.flip_v = false
		#weapon_holder.scale = Vector2(1, 1)
		
	
	#if mouse_dir == "right" and animated_sprite.flip_h:
		#animated_sprite.flip_h = false
	#elif mouse_dir == "left" and not animated_sprite.flip_h:
		#animated_sprite.flip_h = true
	
	
	
	#current_weapon.move(mouse_direction)
		
		
func get_input() -> void:
	Velocity = Vector2.ZERO
	if Input.is_action_pressed("move_down"):
		Velocity += Vector2.DOWN
	if Input.is_action_pressed("move_left"):
		Velocity += Vector2.LEFT
	if Input.is_action_pressed("move_right"):
		Velocity += Vector2.RIGHT
	if Input.is_action_pressed("move_up"):
		Velocity += Vector2.UP
		
	#if not current_weapon.is_busy():
	#	if Input.is_action_just_released("ui_previous_weapon"):
	#		_switch_weapon(UP)
	#	elif Input.is_action_just_released("ui_next_weapon"):
	#		_switch_weapon(DOWN)
		#elif Input.is_action_just_pressed("ui_throw") and current_weapon.get_index() != 0:
		#	_drop_weapon()
		
	#current_weapon.get_input()
	
	
func _switch_weapon(direction: int) -> void:
	var prev_index: int = current_weapon.get_index()
	var index: int = prev_index
	if direction == UP:
		index -= 1
		if index < 0:
			index = weapons.get_child_count() - 1
	else:
		index += 1
		if index > weapons.get_child_count() - 1:
			index = 0
			
	current_weapon.hide()
	current_weapon = weapons.get_child(index)
	current_weapon.show()
	#SavedData.equipped_weapon_index = index
	
	emit_signal("weapon_switched", prev_index, index)
	
	
func pick_up_weapon(weapon: Node2D) -> void:
	#SavedData.weapons.append(weapon.duplicate())
	#var prev_index: int = SavedData.equipped_weapon_index
	var new_index: int = weapons.get_child_count()
	#SavedData.equipped_weapon_index = new_index
	weapon.get_parent().call_deferred("remove_child", weapon)
	weapons.call_deferred("add_child", weapon)
	weapon.set_deferred("owner", weapons)
	current_weapon.hide()
	current_weapon.cancel_attack()
	current_weapon = weapon
	
	emit_signal("weapon_picked_up", weapon.get_texture())
	# emit_signal("weapon_switched", prev_index, new_index)
	
	
#func _drop_weapon() -> void:
	#SavedData.weapons.remove(current_weapon.get_index() - 1)
#	var weapon_to_drop: Node2D = current_weapon
#	_switch_weapon(UP)
	
#	emit_signal("weapon_droped", weapon_to_drop.get_index())
	
#	weapons.call_deferred("remove_child", weapon_to_drop)
#	get_parent().call_deferred("add_child", weapon_to_drop)
#	weapon_to_drop.set_owner(get_parent())
#	await weapon_to_drop.tween.tree_entered
#	weapon_to_drop.show()
	
#	var throw_dir: Vector2 = (get_global_mouse_position() - position).normalized()
#	weapon_to_drop.interpolate_pos(position, position + throw_dir * 50)
		
		
#func cancel_attack() -> void:
#	current_weapon.cancel_attack()
	
	
func spawn_dust() -> void:
	#var dust: Sprite = DUST_SCENE.instance()
	#dust.position = dust_position.global_position
	#parent.add_child_below_node(parent.get_child(get_index() - 1), dust)
	pass
		
		
func switch_camera() -> void:
	var main_scene_camera: Camera2D = get_parent().get_node("Camera2D")
	main_scene_camera.position = position
	main_scene_camera.current = true
	get_node("Camera2D").current = false
