extends Node


const MAX := 32
const STEP := 1.0/MAX
const Tile := preload("res://wolf_editing_tools/scenes_and_scripts/map/tile.tscn")
const TileType := preload("res://wolf_editing_tools/scenes_and_scripts/map/tile.gd")


func _ready() -> void:
	var parent := get_parent()
	var tile : TileType = Tile.instance()
	for repetitions in 32:
		var base_x_coordinate = MAX * repetitions
		for hue in MAX + 1:
			var color : Color = Color.from_hsv(hue * STEP, 1, 1)
			var texture := SingleColorTexture.new()
			texture.set_color(color)
			for z_coordinate in [0, 2]:
				tile = Tile.instance()
				tile.texture_east = texture
				tile.texture_north = texture
				tile.texture_south = texture
				tile.texture_west = texture
				tile.translation = Vector3(base_x_coordinate + hue, 0, z_coordinate)
				parent.call_deferred("add_child", tile)
	#$"../Thing".translation = tile.translation - Vector3(0.5, 0, 0.5)
	tile.translation.z = 1
	call_deferred("regenerate", parent)


func regenerate(parent : Node) -> void:
	parent.call_deferred("_ready")
