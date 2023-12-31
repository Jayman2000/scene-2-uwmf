# Reference for Scenes and Scripts Included with Scene 2 UWMF

## Glossary

- **map pixel** — the absolute unit used by [UWMF]. Anything in a UWMF map can
be measured in map pixels.

	1 map pixel is not necessarily the same length as 1 pixel in a graphic
	used by the source port. For example, let’s say that an [`Actor`] uses
	a PNG [sprite][Actor states usage] that is 32 pixels wide. A [`TEXTURES` lump]
	could be used to scale that PNG to half of its original size.
	Additionally, the [`Actor`’s `scale`][Actor properties rendering] might
	scale the `Actor` down to half of its regular size. In this example, 1
	pixel in the PNG sprite would become 0.25 map pixels in game.

- **tile unit** — the relative unit used by UWMF. 1 tile unit equals a certain
number of map pixels. A BaseMap’s Tile Size (see below) determines the number of
map pixels in 1 tile unit.

- **wall** — a rectangle. Walls are always 1 tile unit long. The front side of a
wall may have a texture applied to it. The back side of a wall is always
invisible. Walls always face either east, north, south or west. In other words,
you can’t create diagonal walls.

	Walls are normally squares, but they don’t have to be. At the moment,
	Scene 2 UWMF and the latest stable version of ECWolf (1.3.3) only
	support square walls.

- **tile** — a group of four walls. Specifically, a tile is made up of an east,
a north, a south and a west wall.

	In Godot, tiles will appear to have top and a bottom face. This is just
	to help you preview what your level’s automap will look like. In source
	ports, tiles don’t have top or bottom faces.

- **map spot** — a space that’s shaped like a tile. In UWMF, a map is a grid of
map spots. Each map spot can be empty or filled with a tile.

- **sector** — a group of map spots. Every map spot in a sector has the same
floor and ceiling texture.

- **thing** — either an [`Actor`] or a player start.

- **trigger** — an invisible area that’s shaped like a tile. When a trigger is
activated, its [action special] is activated. A trigger’s properties determine
how it can be activated.

## Usable Textures

[There are many different types of textures that can be used in Godot
games.](https://docs.godotengine.org/en/3.4/classes/class_texture.html)
Only some of them can be used in Wolfenstein maps.

### Textures generated by the Graphics Extractor

The Graphics Extractor will generate textures and put them in
`res://wolf_editing_tools/generated/art/walls/<name>`. The `<name>` will be the
file name of what ever VSWAP file you used (`VSWAP.WL6` for Wolfenstein 3D,
`VSWAP.SOD` for Spear of Destiny, etc.).

The term “walls” is only used because that’s what they’re called in [the VSWAP
file format](https://vpoupet.github.io/wolfenstein/docs/files#vswapwl6). ECWolf
(and, presumably, any other port that supports UWMF) lets you use “wall”
textures on floors and ceilings.

It’s important that you only use textures from a single VSWAP file. If you
create a map that uses textures from both `VSWAP.WL6` and from `vswap.n3d`, then
you run the risk of creating a map that has missing textures no matter which
game it’s run with. The only exception to this rule is with [the Spear of
Destiny mission packs](https://wolfenstein.fandom.com/wiki/Spear_of_Destiny_mission_packs).
ECWolf also loads `VSWAP.SOD` when you start either mission pack, so it’s OK to
use textures from both `VSWAP.SOD` and `VSWAP.SD2` or textures from both
`VSWAP.SOD` and `VSWAP.SD3` in a single map.

### `SingleColorTexture`

A `SingleColorTexture` can be created using any `Texture` property’s drop-down
menu. If property is set to a `SingleColorTexture`, then you can click on the
texture and edit its one and only property: `color`

### `InvisibleTexture`

You probably shouldn’t use one of these. For one thing, they aren’t
actually invisible. I called them that and later realized that they
actually cause [the hall of mirrors effect]. In the future, they’ll be
renamed.

## Custom UWMF properties

Many of the scenes that you’ll build maps with have a property named
“Custom Uwmf Properties”. That property is a [`Dictionary`]. You can use
it to access features of UWMF that Scene 2 UWMF doesn’t support yet.

For example, [according to the UWMF spec, tiles can have a property named
`comment`][UWMF comment]. The Tile scene doesn’t have a property that
corresponds to UWMF’s `comment` property. If you want to create a tile
that has a `comment`, then here’s what you can do:

1. Create a Tile.
2. Select it.
3. In the [Inspector][editor vocab], find the property named
Uwmf Properties”.
4. Click on “Dictionary (size 0)”.
5. Set “New Key” to a `String` that says “comment”. Every custom
property key should be a `String`.
6. Set “New Value” to a `String` that says anything. [According the
UWMF spec, `string` is the data type for `comment`.][UWMF comment] Other
properties may use other data types.
7. Click “Add Key/Value Pair”.

## Scenes used to build levels

### BaseMap

**Location:** `res://wolf_editing_tools/scenes_and_scripts/map/base_map.tscn`

**Description:** When a `BaseMap` `Node` is [ready], it will use information
about itself and its children to generate a [WAD] file that contains a map. In
other words when you run a BaseMap scene, it will build your map.

#### Properties

- **Internal Name:** This name is used as the [map header] in the [WAD] file
that the `BaseMap` generates. It should be eight characters or less since
[that’s the limit for lump names][WAD directory]. Additionally, the generated
[WAD] file’s name will be based on the internal name.
- **Automap Name:** The name of the level that will be displayed when the player
opens the automap. In ECWolf, this name may be overridden by [MAPINFO].
- **Tile Size:** Determines the length (in map pixels) of 1 tile unit.

	You should probably leave this set at 64. The Tile Size property
	corresponds to [the global `tileSize` property in
	UWMF][global properties]. The latest stable version of ECWolf (1.3.3)
	seems to ignore `tileSize` at the moment. I’m not sure if `tileSize` can
	be used in other ports or the latest development version of ECWolf.

- **Default Sector:** These properties determine which sector every map spot is
a part of. This section contains the following properties:

	- **Enabled:**

		If _enabled_ is checked, then every map spot will be a part
		of a sector. That sector can be configured using the rest of the
		properties in this section.

		If _enabled_ is unchecked, then every map spot won’t be a part
		of any sector. This will cause every floor and ceiling to have
		no texture which will in turn cause
		[the hall of mirrors effect].

		It’s strongly recommended that you keep _enabled_ checked.

	- **Texture Ceiling:** What every ceiling in the map will look like.
	- **Texture Floor:** What every floor in the map will look like.

### Thing

**Location:** `res://wolf_editing_tools/scenes_and_scripts/map/thing.tscn`

**Description:** See the glossary’s definition of “thing”.

#### Properties

- **Type Number:** This thing’s editor number.

	- To create a player 1 start, set this to 1.
	- To create an [`Actor`], set this to the `Actor`’s
	[editor number (`ednum`)](https://maniacsvault.net/ecwolf/wiki/DECORATE#Syntax).
	You can find a complete list of `Actor`s that are built into ECWolf
	[here](https://maniacsvault.net/ecwolf/wiki/Classes). Click on the
	`Actor` that you want and look for the box that says “DoomEd Number”.

- **Skill 1:** Whether or not this thing will exist on the easiest
difficulty (“Can I play, Daddy?” in Wolf 3D).
- **Skill 2:** Whether or not this thing will exist on the easy-medium
difficulty (“Don’t hurt me.” in Wolf 3D).
- **Skill 3:** Whether or not this thing will exist on the medium-hard
difficulty (“Bring ’em on!” in Wolf 3D).
- **Skill 4:** Whether or not this thing will exist on the hardest
difficulty (“I am Death incarnate!” in Wolf 3D).
- **Texture:** This property comes from Godot itself, not from Scene 2 UWMF. It
doesn’t change anything about the map that gets generated. You can change a
Thing’s texture so that the Thing looks different in Godot. Give each type of
Thing in your map a different texture to make your map easier to edit.

### Tile

**Location:** `res://wolf_editing_tools/scenes_and_scripts/map/tile.tscn`

**Description:** See the glossary’s definition of “tile”.

#### Properties

- **Texture East**, **Texture North**, **Texture South** and **Texture West:**
The texture used by each of the tile’s walls. In normal maps, the east and west
textures will be dark and the north and south textures will be bright in order
to create [fake contrast].

	The default values for these properties are all \[empty]. When one of
	these properties is \[empty], the face of the Tile will look like a crudely
	drawn letter E, N, S or W. _If you leave any of these properties set to
	\[empty], then Scene 2 UWMF will fail to export your map._

- **Texture Overhead:** What the tile will look like on the automap.

### Trigger

**Location:** `res://wolf_editing_tools/scenes_and_scripts/map/trigger.tscn`

**Description:** See the glossary’s definition of “trigger”.

#### Properties

- **Action Number:** the number of the action special that this trigger
activates. The list of action specials supported by ECWolf (along with
their numbers) can be found [here][action special].

	By default, _action_ is set to -1 which is an invalid action special
	number. This is to ensure that you change the action special before
	using it. In other words, don’t rely on the default!

- **Player Cross:** If _Player Cross_ is checked, then the _Action_ will be
activated when the player crosses one of the trigger’s faces.

- **Active Color:** What color the Trigger will use in Godot. This is purely
cosmetic. You might change this property because you’re color blind or because
you’re putting the Trigger in the same space as a green Tile.

[`Actor`]: https://maniacsvault.net/ecwolf/wiki/Classes:Actor
[action special]: https://maniacsvault.net/ecwolf/wiki/Action_specials
[Actor properties rendering]: https://maniacsvault.net/ecwolf/wiki/Actor_properties#Rendering
[Actor states usage]: https://maniacsvault.net/ecwolf/wiki/Actor_states#Usage
[`Dictionary`]: https://docs.godotengine.org/en/3.4/classes/class_dictionary.html
[editor vocab]: https://docs.godotengine.org/en/3.4/community/contributing/docs_writing_guidelines.html#common-vocabulary-to-use-in-godot-s-documentation
[fake contrast]: https://doomwiki.org/wiki/Fake_contrast#Previous_implementations
[global properties]: https://maniacsvault.net/ecwolf/wiki/Universal_Wolfenstein_Map_Format#Global_Properties
[map header]: https://zdoom.org/wiki/Universal_Doom_Map_Format#Map_lumps
[MAPINFO]: https://maniacsvault.net/ecwolf/wiki/MAPINFO
[ready]: https://docs.godotengine.org/en/3.4/classes/class_node.html#class-node-constant-notification-ready
[`TEXTURES` lump]: https://maniacsvault.net/ecwolf/wiki/TEXTURES
[the hall of mirrors effect]: https://doomwiki.org/wiki/Hall_of_mirrors
[UWMF]: https://maniacsvault.net/ecwolf/wiki/Universal_Wolfenstein_Map_Format
[UWMF comment]: https://maniacsvault.net/ecwolf/wiki/UWMF#Optional_Properties
[WAD]: https://doomwiki.org/wiki/WAD
[WAD directory]: https://doomwiki.org/wiki/WAD#Directory
