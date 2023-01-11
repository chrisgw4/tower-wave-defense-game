extends Control
class_name TowerUI

@onready var player: Player = get_tree().current_scene.get_node("TileMap/Player")
@onready var item_list: ItemList = $Node2D/ItemList
@onready var placement_tile: TileMap = get_tree().current_scene.get_node("Placement")

var stop_weapons:bool = false

signal change_tower

# Called when the node enters the scene tree for the first time.
func _ready():
	#item_list.select(0)
	connect("change_tower", _set_placement_tower)

func _set_placement_tower():
	if _get_selected_weapon_index() == -1:
		return
	
	# sets the place index in the Placement scene to a tower that is selected
	placement_tile._set_tower(_get_selected_weapon_index())

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# checks if player has entered build mode (E key)
	if Input.is_action_just_pressed("enter_build_mode") and not placement_tile.build_mode:
		$AnimationPlayer.play_backwards("move_off")
		stop_weapons = true
	# checks if player has exited build mode (E key) [was already in build mode before to close it]
	if Input.is_action_just_pressed("enter_build_mode") and placement_tile.build_mode:
		$AnimationPlayer.play("move_off")
		stop_weapons = false
	
	
	if Input.is_action_just_pressed("key_one") and not item_list.is_selected(0):
		item_list.select(0)
		emit_signal("change_tower")
	if Input.is_action_just_pressed("key_two")and not item_list.is_selected(1):
		item_list.select(1)
		emit_signal("change_tower")
	if Input.is_action_just_pressed("key_three") and not item_list.is_selected(2):
		item_list.select(2)
		emit_signal("change_tower")
	if Input.is_action_just_pressed("key_four") and not item_list.is_selected(3):
		item_list.select(3)
		emit_signal("change_tower")
	if Input.is_action_just_pressed("key_five") and not item_list.is_selected(4):
		item_list.select(4)
		emit_signal("change_tower")
	if Input.is_action_just_pressed("key_six") and not item_list.is_selected(5):
		item_list.select(5)
		emit_signal("change_tower")
	if Input.is_action_just_pressed("key_seven") and not item_list.is_selected(6):
		item_list.select(6)
		emit_signal("change_tower")
	if Input.is_action_just_pressed("key_eight") and not item_list.is_selected(7):
		item_list.select(7)
		emit_signal("change_tower")
	if Input.is_action_just_pressed("key_nine") and not item_list.is_selected(8):
		item_list.select(8)
		emit_signal("change_tower")


func _get_selected_weapon_index() -> int:
	for i in range(item_list.item_count):
		if item_list.is_selected(i):
			#print(i)
			return i
	return -1


func _on_item_list_item_selected(index):
	emit_signal("change_tower")



	






func _on_item_list_mouse_entered():
	#print("entered")
	placement_tile.mouse_blocked = true


func _on_item_list_mouse_exited():
	#print("exited")
	placement_tile.mouse_blocked = false
	
