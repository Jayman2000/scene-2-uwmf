tool
extends MapSpotLockedObject

const DEFAULT_EXPLICIT_TAG_ENABLED := false
const DEFAULT_EXPLICIT_TAG_NUMBER := 0
const EAST_FACE_PATH := @"EastFace"
const OVERHEAD_FACE_PATH := @"OverheadFace"
const BOTTOM_FACE_PATH := @"BottomFace"
const WRONG_TYPE := "Tried to set {} to {} which is not {}."

export var texture_east : Texture setget set_texture_east
export var texture_north : Texture setget set_texture_north
export var texture_south : Texture setget set_texture_south
export var texture_west : Texture setget set_texture_west
export var texture_overhead : Texture setget set_texture_overhead

var explicit_tag_enabled : bool = DEFAULT_EXPLICIT_TAG_ENABLED
var explicit_tag_number : int = DEFAULT_EXPLICIT_TAG_NUMBER


func get_mesh_instance(path : NodePath): #-> MeshInstance:  # Doesn’t work.
	var return_value := get_node(path)
	if return_value is MeshInstance:
		return return_value
	else:
		push_error("“%s” wasn’t a MeshInstance." % [path])
		return null


func set_texture(path : NodePath, new_texture : Texture) -> void:
	var face = get_mesh_instance(path)
	if face != null:
		if new_texture == null:
			face.material_override = null
		else:
			var new_material := SpatialMaterial.new()
			new_material.flags_unshaded = true
			new_material.flags_transparent = true
			new_material.albedo_texture = new_texture
			face.material_override = new_material


func update_overhead_and_bottom_materials() -> void:
	if texture_overhead == null:
		var east_face = get_mesh_instance(EAST_FACE_PATH)
		var overhead_face = get_mesh_instance(OVERHEAD_FACE_PATH)
		var bottom_face = get_mesh_instance(BOTTOM_FACE_PATH)
		if east_face != null:
			if overhead_face != null:
				overhead_face.material_override = east_face.material_override
			if bottom_face != null:
				bottom_face.material_override = east_face.material_override
	else:
		set_texture(OVERHEAD_FACE_PATH, texture_overhead)
		set_texture(BOTTOM_FACE_PATH, texture_overhead)


func set_texture_east(new_texture_east : Texture) -> void:
	set_texture(EAST_FACE_PATH, new_texture_east)
	update_overhead_and_bottom_materials()
	texture_east = new_texture_east


func set_texture_north(new_texture_north : Texture) -> void:
	set_texture(@"NorthFace", new_texture_north)
	texture_north = new_texture_north


func set_texture_south(new_texture_south : Texture) -> void:
	set_texture(@"SouthFace", new_texture_south)
	texture_south = new_texture_south


func set_texture_west(new_texture_west : Texture) -> void:
	set_texture(@"WestFace", new_texture_west)
	texture_west = new_texture_west


func set_texture_overhead(new_texture_overhead : Texture) -> void:
	texture_overhead = new_texture_overhead
	update_overhead_and_bottom_materials()


func to_uwmf() -> String:
	var contents := {
		"textureEast" : Util.texture_to_uwmf(texture_east),
		"textureNorth" : Util.texture_to_uwmf(texture_north),
		"textureSouth" : Util.texture_to_uwmf(texture_south),
		"textureWest" : Util.texture_to_uwmf(texture_west)
	}
	if texture_overhead != null:
		contents["textureOverhead"] = Util.texture_to_uwmf(texture_overhead)
	return _named_block_with_custom_properties("tile", contents)


func uwmf_position() -> Vector3:
	var return_value := .uwmf_position()
	return_value = return_value.round()
	# TODO: Errors for when Tiles have coordinates that aren’t whole numbers.
	if return_value.z != 0:
		push_error("Multiple planes haven’t been implemented yet. The Y coordinate for every Tile should be 0.")
	return return_value


func max_uwmf_x_y_z() -> Vector3:
	return uwmf_position() + Vector3(1, 1, 1)


func _get_property_list() -> Array:
	return [
		{
			"name" : "explict_tag/enabled",
			"type" : TYPE_BOOL
		},
		{
			"name" : "explict_tag/number",
			"type" : TYPE_INT
		}
	]


func _get(property):
	match property:
		"explict_tag/enabled":
			return explicit_tag_enabled
		"explict_tag/number":
			return explicit_tag_number
	return null


func _set(property, value) -> bool:
	match property:
		"explict_tag/enabled":
			if value is bool:
				explicit_tag_enabled = value
				return true
			else:
				push_error(WRONG_TYPE % ["explict_tag/enabled", value, "a bool"])
		"explict_tag/number":
			if value is int:
				explicit_tag_number = value
				return true
			else:
				push_error(WRONG_TYPE % ["explict_tag/number", value, "an int"])
	return false


func property_can_revert(name) -> bool:
	match name:
		"explict_tag/enabled":
			if explicit_tag_enabled != DEFAULT_EXPLICIT_TAG_ENABLED:
				return true
		"explict_tag/number":
			if explicit_tag_number != DEFAULT_EXPLICIT_TAG_NUMBER:
				return true
	return false


func property_get_revert(name):
	match name:
		"explict_tag/enabled":
			return DEFAULT_EXPLICIT_TAG_ENABLED
		"explict_tag/number":
			return DEFAULT_EXPLICIT_TAG_NUMBER
	return null
