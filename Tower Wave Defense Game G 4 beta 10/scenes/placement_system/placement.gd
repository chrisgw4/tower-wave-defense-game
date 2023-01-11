extends TileMap


@onready var player = get_tree().current_scene.get_node("TileMap/Player")

@onready var towers: Dictionary = {0:preload("res://scenes/towers/flame_tower/flame_tower.tscn"), 1: preload("res://scenes/towers/cannon_tower/cannon_tower.tscn")}

var tower_placing: int = -1

var build_mode: bool = false

var mouse_blocked: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _set_tower(num: int):
	tower_placing = num
	#print(tower_placing)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	#var thread = Thread.new()
	
	#thread.start(_spawn_temp_tower)
	#thread.wait_to_finish()
	
			
	if Input.is_action_just_pressed("enter_build_mode"):
		build_mode = not build_mode
		player.get_node("WeaponHolder").get_child(0).stop_shoot = not player.get_node("WeaponHolder").get_child(0).stop_shoot
		
		#print(player.get_node("WeaponHolder").get_child(0).stop_shoot)
		_clear_temp_towers()
	
	if tower_placing == -1:
			return
	
	if mouse_blocked:
		return
	
	if build_mode:
		_spawn_temp_tower()
	
	



func _input(event):
	if tower_placing == -1:
			return
	
	if mouse_blocked:
		return
	
	#if event is InputEventMouseButton:
	if Input.is_action_just_pressed("fire"):
		#if event.button_index != MOUSE_BUTTON_LEFT:
		#	return
		#print("D")
		if not _get_tower_in_cell():
			_place_tower()
	#if event is InputEventMouseMotion:
		#print("deez")
		#var temp_tower = towers[0].instantiate()
		#temp_tower.global_position = local_to_map(map_to_local(get_global_mouse_position()))
		
		#for child in get_tree().current_scene.get_node("Towers").get_children():
		#	if child.global_position == map_to_local(local_to_map(get_local_mouse_position())):
		#		return
		#if get_tree().current_scene.get_child("Towers").get_child_count() > 0:
			
		#temp_tower.global_position = map_to_local(local_to_map(get_local_mouse_position()))
		#get_tree().current_scene.get_node("TempTowers").add_child(temp_tower)
		#map_to_local(get_global_mouse_position()
		#print(map_to_local(local_to_map(get_local_mouse_position())))
		
func _clear_temp_towers():
	for i in get_tree().current_scene.get_node("TempTowers").get_children():
		i.queue_free()
	
func _spawn_temp_tower():
	_clear_temp_towers()
	var temp_tower = towers[tower_placing].instantiate()
	temp_tower.modulate = Color(0.552941, 0.552941, 0.552941, 0.290196)
	
	get_tree().current_scene.get_node("TempTowers").add_child(temp_tower)
	temp_tower.global_position = map_to_local(local_to_map(get_local_mouse_position()))


func _place_tower():
	if _get_tower_in_cell() or not build_mode:
		return
	var t = towers[tower_placing].instantiate()
	get_tree().current_scene.get_node("TileMap").add_child(t)
	t.global_position = map_to_local(local_to_map(get_local_mouse_position()))


func get_tile_at_mopuse_pos():
	return local_to_map(get_local_mouse_position())


func _get_tower_in_cell():
	for child in get_tree().current_scene.get_node("TileMap").get_children():
		#print(child.name)
		if "Tower" in child.name and child.global_position == map_to_local(local_to_map(get_local_mouse_position())):
			return true
	return false
