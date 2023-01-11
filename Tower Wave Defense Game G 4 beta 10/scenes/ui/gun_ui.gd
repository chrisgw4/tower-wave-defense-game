extends Control


@onready var player: Player = get_tree().current_scene.get_node("TileMap/Player")
@onready var item_list: ItemList = %ItemList

@onready var tower_ui: TowerUI = get_tree().current_scene.get_node("TileMap/Player/Camera2D/TowerUI")

var dict: Dictionary = {0:"Flamethrower", 1:"Cannon"}

signal change_weapon

var on_screen:bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	#player.connect("change_weapon", player._move_weapon)
	item_list.select(0)
	connect("change_weapon", _change_weapon)
	
	


func _change_weapon():
	if _get_selected_weapon_index() == -1:
		return
	
	if not on_screen:
		$AnimationPlayer.play_backwards("move_off")
		on_screen = true
	$Delay.start(1.5)
	#print(dict[_get_selected_weapon_index()])
	player._move_weapon(dict[_get_selected_weapon_index()])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if tower_ui.stop_weapons:
		return
	
	if Input.is_action_just_pressed("key_one") and not item_list.is_selected(0):
		item_list.select(0)
		emit_signal("change_weapon")
	if Input.is_action_just_pressed("key_two")and not item_list.is_selected(1):
		item_list.select(1)
		emit_signal("change_weapon")
	if Input.is_action_just_pressed("key_three") and not item_list.is_selected(2):
		item_list.select(2)
		emit_signal("change_weapon")
	if Input.is_action_just_pressed("key_four") and not item_list.is_selected(3):
		item_list.select(3)
		emit_signal("change_weapon")
	if Input.is_action_just_pressed("key_five") and not item_list.is_selected(4):
		item_list.select(4)
		emit_signal("change_weapon")
	if Input.is_action_just_pressed("key_six") and not item_list.is_selected(5):
		item_list.select(5)
		emit_signal("change_weapon")
	if Input.is_action_just_pressed("key_seven") and not item_list.is_selected(6):
		item_list.select(6)
		emit_signal("change_weapon")
	if Input.is_action_just_pressed("key_eight") and not item_list.is_selected(7):
		item_list.select(7)
		emit_signal("change_weapon")
	if Input.is_action_just_pressed("key_nine") and not item_list.is_selected(8):
		item_list.select(8)
		emit_signal("change_weapon")

func _get_selected_weapon_index() -> int:
	for i in range(item_list.item_count):
		if item_list.is_selected(i):
			#print(i)
			return i
	return -1


func _on_delay_timeout():
	on_screen = false
	$AnimationPlayer.play("move_off")
