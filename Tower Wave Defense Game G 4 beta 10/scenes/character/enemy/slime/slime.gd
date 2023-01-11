extends Enemy


# Called when the node enters the scene tree for the first time.
func _ready():
	state_machine = get_node("SlimeFSM")


