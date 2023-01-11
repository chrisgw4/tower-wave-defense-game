extends AnimatedSprite2D

@onready var parent = get_parent()

# Called when the node enters the scene tree for the first time.
func _ready():
	$DamageTick.start(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_damage_tick_timeout():
	parent.hp -= 1
	if parent.hp <= 0:
		parent.check_hp()
		return
		#queue_free()
	get_parent().animated_sprite.self_modulate = Color(10, 10, 10)
	$DamageTick.start(1)
	$ResetModulate.start(0.4)



func _on_burn_length_timeout():
	get_parent().animated_sprite.self_modulate = Color(1, 1, 1)
	queue_free()


func _on_reset_modulate_timeout():
	get_parent().animated_sprite.self_modulate = Color(10, 1, 1)
