extends "res://scenes/character/FSM.gd"


func _init() -> void:
	_add_state("idle_side")
	_add_state("idle_down")
	_add_state("idle_up")
	_add_state("idle_diag_up")
	_add_state("idle_diag_down")
	
	_add_state("move_side")
	_add_state("move_up")
	_add_state("move_down")
	_add_state("move_diag_up")
	_add_state("move_diag_down")
	
	_add_state("hurt")
	_add_state("death")
	
	#_add_state("hurt")
	#_add_state("dead")
	
	
func _ready() -> void:
	set_state(states.idle_side)
	
	
	
func _state_logic(_delta: float) -> void:
	#if state == states.idle or state == states.move_side or state == states.move_up or state == states.move_down:
	parent.get_input()
	parent.animated_sprite.flip_h = false
		
	
	
func _get_transition() -> int:
	parent.mov_backward = false
	#parent.weapon_holder.scale = Vector2(1,1)
	# diagonal to the right and down/up
	if (parent.velocity.x > 10):
		if parent.velocity.y > 10:
			if parent.mouse_dir == "left":
				parent.animated_sprite.flip_h = true
				#parent.weapon_holder.scale = Vector2(-1,1)
				parent.mov_backward = true
				return states.move_diag_up
			
			
			parent.animated_sprite.flip_h = false
			return states.move_diag_down
			
		if parent.velocity.y < -10:
			if parent.mouse_dir == "left":
				parent.mov_backward = true
				parent.animated_sprite.flip_h = true
				#parent.weapon_holder.scale = Vector2(-1,1)
				return states.move_diag_down
			
			parent.animated_sprite.flip_h = false
			return states.move_diag_up
	
	# diagonal to the left and down/up
	if (parent.velocity.x < -10):
		if parent.velocity.y > 10:
			if parent.mouse_dir == "right":
				parent.mov_backward = true
				parent.animated_sprite.flip_h = false
				return states.move_diag_up
			
			parent.animated_sprite.flip_h = true
			#parent.weapon_holder.scale = Vector2(-1,1)
			return states.move_diag_down
			
		if parent.velocity.y < -10:
			if parent.mouse_dir == "right":
				parent.mov_backward = true
				parent.animated_sprite.flip_h = false
				return states.move_diag_down
			
			parent.animated_sprite.flip_h = true
			#parent.weapon_holder.scale = Vector2(-1,1)
			return states.move_diag_up
			
	
	
	if (parent.velocity.x) > 10:
		#print("side")
		if parent.mouse_dir == "left":
			parent.mov_backward = true
			parent.animated_sprite.flip_h = true
		if parent.mouse_dir == "right":
			parent.animated_sprite.flip_h = false
		return states.move_side
	if (parent.velocity.x) < -10:
		#print("side")
		if parent.mouse_dir == "left":
			parent.animated_sprite.flip_h = true
		if parent.mouse_dir == "right":
			parent.mov_backward = true
			parent.animated_sprite.flip_h = false
		return states.move_side
	if parent.velocity.y > 10:
		#print("down")
		if parent.mouse_dir_height == "up":
			parent.mov_backward = true
			return states.move_up
		return states.move_down
	if parent.velocity.y < -10:
		#print("up")
		if parent.mouse_dir_height == "down":
			parent.mov_backward = true
			return states.move_down
		return states.move_up
	#if states.move_side == state or states.move_up == state or states.move_down == state:
	
	
	
	if parent.mouse_dir == "left" and parent.mouse_dir_height == "middle": #and parent.velocity.length() < 10:
		parent.animated_sprite.flip_h = true
		return states.idle_side
	if parent.mouse_dir == "right" and parent.mouse_dir_height == "middle": #and parent.velocity.length() < 10:
		#parent.animated_sprite.flip_h = false
		return states.idle_side
	if parent.mouse_dir == "middle" and parent.mouse_dir_height == "down":
		return states.idle_down
	if parent.mouse_dir == "middle" and parent.mouse_dir_height == "up":
		return states.idle_up
	
	if parent.mouse_dir == "left" and parent.mouse_dir_height == "up":
		parent.animated_sprite.flip_h = true
		return states.idle_diag_up
	if parent.mouse_dir == "right" and parent.mouse_dir_height == "up":
		#parent.animated_sprite.flip_h = true
		return states.idle_diag_up
	
	if parent.mouse_dir == "left" and parent.mouse_dir_height == "down":
		parent.animated_sprite.flip_h = true
		return states.idle_diag_down
	if parent.mouse_dir == "right" and parent.mouse_dir_height == "down":
		#parent.animated_sprite.flip_h = true
		return states.idle_diag_down
	
	#if parent.velocity.length() < 10:
		#print("idle")
	#	return states.idle
	#if states.hurt == state:
	#	if not animation_player.is_playing():
	#		return states.idle
	return -1
	
	
func _enter_state(_previous_state: int, new_state: int) -> void:
	
	#print(new_state)
	if states.idle_side == new_state:
		animation_player.play("idle_side")
	if states.idle_down == new_state:
		animation_player.play("idle_down")
	if states.idle_up == new_state:
		animation_player.play("idle_up")
	if states.idle_diag_up == new_state:
		animation_player.play("idle_diag_up")
	if states.idle_diag_down == new_state:
		animation_player.play("idle_diag_down")
		
	if states.move_side == new_state:
		if parent.mov_backward:
			animation_player.play_backwards("move_side")
		else:
			animation_player.play("move_side")
	if states.move_up == new_state:
		if parent.mov_backward:
			animation_player.play_backwards("move_up")
		else:
			animation_player.play("move_up")
	if states.move_down == new_state:
		if parent.mov_backward:
			animation_player.play_backwards("move_down")
		else:
			animation_player.play("move_down")
	if states.move_diag_down == new_state:
		if parent.mov_backward:
			animation_player.play_backwards("move_diag_down")
		else:
			animation_player.play("move_diag_down")
	if states.move_diag_up == new_state:
		if parent.mov_backward:
			animation_player.play_backwards("move_diag_up")
		else:
			animation_player.play("move_diag_up")
	#if states["hurt"] == new_state:
	#	animation_player.play("hurt")
		#parent.cancel_attack()
	#if states["dead"] == new_state:
	#	animation_player.play("dead")
		#parent.cancel_attack()
