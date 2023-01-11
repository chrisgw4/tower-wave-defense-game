extends RichTextLabel


@onready var parent: Character = get_parent().get_parent()


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	text = ""
	text += "State: " + parent.FSM.states_names[parent.FSM.state]
	text += "\n"
	text += "FPS: " + str(Engine.get_frames_per_second())
	text += "\n"
	text += "Enemy Count: " + str(get_tree().current_scene.get_node("SpawnPoint").enemy_count)
	text += "\n"
	text += "Coins: " + str(parent.coins)
	
