# Selected code sample from Knight's Mash.
# This script collects valid spawn positions from a TileMapLayer
# and converts them into world positions for the enemy spawning system.
# It replaced an older radius-based spawn approach that caused issues with walls and narrow maps.

extends Node2D

var valid_spawn_cells: Array[Vector2i] = []
var valid_spawn_positions: Array[Vector2] = []


func _ready() -> void:
	var arena_layer: TileMapLayer = get_tree().get_first_node_in_group("arena")
	if arena_layer == null:
		return
	
	valid_spawn_cells = arena_layer.get_used_cells()
	valid_spawn_positions = convert_cells_to_world_positions(arena_layer, valid_spawn_cells)


func convert_cells_to_world_positions(arena_layer: TileMapLayer, cells: Array[Vector2i]) -> Array[Vector2]:
	var positions: Array[Vector2] = []
	
	for cell in cells:
		var local_position = arena_layer.map_to_local(cell)
		var world_position = arena_layer.to_global(local_position)
		positions.append(world_position)
		
	return positions


func get_spawn_positions() -> Array[Vector2]:
	return valid_spawn_positions
