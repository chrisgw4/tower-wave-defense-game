extends StaticBody2D
class_name Projectile

var mov_dir: Vector2 = Vector2.ZERO
@export var speed: int = 0

# lifespan in seconds
@export var lifespan: float = 0

# the number of enemies the projectile can go through before disappearing
@export var pierce: int 
var pierce_count: int = 0

#@onready var animated_sprite: AnimatedSprite2D = get_node("AnimatedSprite2D")

@onready var timer: Timer = get_node("LifeSpanTimer")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var collision_info = move_and_collide(mov_dir*speed*delta)
	if "Cannon" in name:
		#print(collision_info)
		#if collision_info:
		#	mov_dir = mov_dir.bounce(collision_info.get_normal())
		if mov_dir.x < 0:
			rotate(-0.05)
		else:
			rotate(0.05)
	

func _fire(direction):
	timer.start(lifespan)
	mov_dir = direction



func _on_life_span_timer_timeout():
	queue_free()



