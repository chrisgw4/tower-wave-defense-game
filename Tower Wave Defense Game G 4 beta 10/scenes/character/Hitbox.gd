extends Area2D
class_name Hitbox

@export var damage: int = 1
var knockback_direction: Vector2 = Vector2.ZERO
@export var knockback_force: int = 300

var body_inside: bool = false

@onready var collision_shape: CollisionShape2D = get_child(0)
@onready var timer: Timer = Timer.new()


func _init() -> void:
	var __ = connect("body_entered", _on_body_entered)
	__ = connect("body_exited", _on_body_exited)
	
	
func _ready() -> void:
	assert(collision_shape != null)
	timer.wait_time = 1
	add_child(timer)
	pass
	
	
func _on_body_entered(body: Character) -> void:
	#print(get_parent().pierce_count)
	if get_parent() is Projectile and get_parent().pierce_count >= get_parent().pierce:
		get_parent().queue_free()
		return
	body_inside = true
	timer.start()
	_collide(body)
	get_parent().pierce_count += 1
	#while body_inside:
		#_collide(body)
		#await timer.timeout
		
		
	
	
func _on_body_exited(_body: Character) -> void:
	body_inside = false
	#timer.stop()
	
	
func _collide(body: Character) -> void:
	if body == null or not body.has_method("take_damage"):
		queue_free()
	else:
		if "Fire" in get_parent().name and not body.has_node("OnFire"):
			#print(body.has_node("OnFire"))
			body.set_fire()
		#print(get_parent().name)
		body.take_damage(damage, knockback_direction, knockback_force)
		
