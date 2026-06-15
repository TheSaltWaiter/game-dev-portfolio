# Enemy Manager
# This script chooses from selected enemies, (changes are coming to the selection)
# It collects valid spawn positions from a TileMapLayer and converts them into world positions
# This is replacing an older radius-based spawn approach, and will further change in the future in the enemy seleciton

extends Node


@export var rat_enemy_scene: PackedScene
@export var wizard_enemy_scene: PackedScene
@export var bat_enemy_scene: PackedScene
@export var barbarian_enemy_scene: PackedScene
@export var enemy_array: Array [PackedScene]

@export var arena_time_manager: Node

@onready var timer: Timer = $Timer


var enemy_table: WeightedTable = WeightedTable.new()

var base_spawn_time = 0

var spawn_map: Node = null
@export var nearby_spawn_radius = 128
@export var no_spawn = 64

@export var nearby_enemies_threshold = 20
@export var number_to_spawn = 1



func _ready():
	enemy_table.add_item(rat_enemy_scene, 10)

	base_spawn_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(on_arena_difficulty_increased)


func set_spawn_map(map_instance) -> void:
	spawn_map = map_instance


func get_spawn_position():
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null:
		return
	if spawn_map == null:
		return
	
	var valid_spawn_positions = spawn_map.get_spawn_positions()
	if valid_spawn_positions.is_empty():
		return
	
	var nearby_enemies = get_nearby_enemy_count(player)
	var use_nearby_spawn = nearby_enemies < nearby_enemies_threshold
	
	var candidate_positions: Array[Vector2] = []
	
	for spawn_position in valid_spawn_positions:
		var distance_to_player = spawn_position.distance_to(player.global_position)
		if distance_to_player < no_spawn:
			continue
		if use_nearby_spawn and distance_to_player > nearby_spawn_radius:
			continue
		
		candidate_positions.append(spawn_position)
	
	if candidate_positions.is_empty() and use_nearby_spawn:
		for spawn_position in valid_spawn_positions:
			if spawn_position.distance_to(player.global_position) >= no_spawn:
				candidate_positions.append(spawn_position)
	
	if candidate_positions.is_empty():
		print("No entries")
		return
	
	return candidate_positions.pick_random()


func on_timer_timeout():
	timer.start()
	
	for i in number_to_spawn:
		var spawn_pos = get_spawn_position()
		var enemy_scene = enemy_table.pick_item()
		var enemy = enemy_scene.instantiate() as Node2D
		
		var entities_layer = get_tree().get_first_node_in_group("entities_layer")
		entities_layer.add_child(enemy)
		enemy.global_position = spawn_pos


func get_nearby_enemy_count(player: Node2D) -> int:
	var enemy_count := 0
	var enemies = get_tree().get_nodes_in_group("enemy")
	
	for enemy in enemies:
		var enemy_node = enemy as Node2D
		if enemy_node == null:
			continue
		
		if enemy_node.global_position.distance_to(player.global_position) <= nearby_spawn_radius:
			enemy_count += 1
	
	return enemy_count


func on_arena_difficulty_increased(arena_difficulty: int):
	var time_off = (.1 / 12) * arena_difficulty
	time_off = min(time_off, .7)
	timer.wait_time = base_spawn_time - time_off
	
	if arena_difficulty == 4:
		enemy_table.add_item(bat_enemy_scene,12)
	if arena_difficulty == 8:
		enemy_table.add_item(wizard_enemy_scene, 15)
	if arena_difficulty == 16:
		enemy_table.add_item(barbarian_enemy_scene, 3)
	
	if (arena_difficulty % 6) == 0:
		number_to_spawn += 1
