extends FiniteStateMachine


func _init() -> void:
	_add_state("hurt")
	_add_state("move_side")
	_add_state("move_south")
	_add_state("move_north")
	_add_state("death")


# Called when the node enters the scene tree for the first time.
func _ready():
	set_state(states.move_side)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _get_transition() -> int:
	if states.death == state:
		return -1
	elif (parent.velocity.x) > 10 and states.hurt != state:
		parent.animated_sprite.flip_h = true
		return states.move_side
		
	elif (parent.velocity.x) < -10 and states.hurt != state:
		parent.animated_sprite.flip_h = false
		return states.move_side
	
	elif parent.velocity.y > 10 and states.hurt != state:
		return states.move_south
	
	elif state == states.hurt and not animation_player.is_playing():
		return states.move_side
	
	return -1


func _enter_state(_previous_state: int, new_state: int) -> void:
	
	#if states.idle == new_state:
	#	animation_player.play("idle")
	if states.move_side == new_state:
		animation_player.play("move_side")
	elif states.move_north == new_state:
		animation_player.play("move_north")
	elif states.move_south == new_state:
		animation_player.play("move_south")
	elif states.hurt == new_state:
		animation_player.play("hurt")
	elif states.death == new_state:
		animation_player.play("death")
		


func _state_logic(_delta: float) -> void:
	# makes it so the slime cant move while in the hurt state
	# side_effect makes it so it has a sort of knockback when hit 
	#if state == states.move_side or state == states.move_north or state == states.move_south:
	if state != states.death and state != states.hurt:
		parent.get_input()
		
		
