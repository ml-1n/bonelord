extends Node

# This script checks the tile the entity is on to see if it is a roof or bridge
# And adjusts collisions/rendering accordingly
class_name HeightAdjuster

# Character to adjust collision layers for
@export var character : CharacterBody2D
	
# Regular ground layer
@export var ground_layer: int = 1

# Elevated (bridge) layer
@export var high_layer : int = 7

# Tilemap
@export var tilemap : TileMap :
	set(value):
		tilemap = value
		layers = tilemap.get_layers_count()
		
var layers : int

func _ready():
	character = get_parent()
	tilemap = %TileMap
	pass
	
# Elevate character when standing on elevated tile
# collide with ground like normal otherwise
func _physics_process(delta):
	var make_above_ground = _check_if_elevated()
	
	# If inside tile that elevates, set active layer/mask from high to default
	# Otherwise make ground layer the default
	_set_mask_and_collision(ground_layer, !make_above_ground)
	_set_mask_and_collision(high_layer, make_above_ground)
	
	
func _on_level_loaded(level : Node2D):
	for child in level.get_children():
		if(child is TileMap):
			tilemap = child
			break
	
	# Level needs a tilemap for this to work
		assert(tilemap)
	
func _check_if_elevated() -> bool:
	# Check tiles under character
	var tile_under : Vector2i = tilemap.local_to_map(character.position)
	
	for layer in layers:
		var tile_data = tilemap.get_cell_tile_data(layer, tile_under)
		
		if(tile_data && tile_data.get_custom_data("rise")):
			return true
			
	return false


func _set_mask_and_collision(layer : int, value : bool):
	character.set_collision_layer_value(layer,value)
	character.set_collision_mask_value(layer,value)
