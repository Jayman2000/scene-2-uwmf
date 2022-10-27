# Scene 2 UWMF

Scene 2 UWMF is a tool that lets you create levels for
[Wolfenstein 3D](https://www.mobygames.com/game/wolfenstein-3d) on (pretty much)
any modern operating system.

![run_for_your_life.tscn is an example of a map created using Scene 2 UWMF.
run_for_your_life.tscn is a scene that can be edited using the Godot Engine
editor. It’s made out of many different Tile Nodes. When a Tile Node is
selected, its textures can be changed from Godot’t
inspector.](screenshot.webp "A level that was created with Scene 2 UWMF")

You can also use Scene 2 UWMF to create levels for:

- [Spear of Destiny](https://www.mobygames.com/game/dos/spear-of-destiny)
- The Spear of Destiny
[mission packs](https://wolfenstein.fandom.com/wiki/Spear_of_Destiny_mission_packs)
- [Super 3D Noah’s Ark](https://wisdomtree.itch.io/s3dna)

## Advantages of using Scene 2 UWMF

- Edit levels on any platform that the Godot Editor can run on:
	- [BSD](https://docs.freebsd.org/en/books/faq/#differences-to-other-bsds)
	- [Linux](https://kernel.org/linux.html)
	- [macOS](https://www.apple.com/macos)
	- [The Web](https://www.w3.org/TR/webarch/#intro)
	- [Windows](http://microsoft.com/windows)
- Edit levels from a 3D perspective view or a 2D top-down view.
- Partial support for ECWolf’s [Universal Wolfenstein Map Format
(UWMF)](https://maniacsvault.net/ecwolf/wiki/Universal_Wolfenstein_Map_Format)
This allows you to:
	- easily assign any texture to any side of any tile.
	- easily create tiles with single-color or invisible textures.
	- create [things] that have fractional coordinates.
- If you already know how to use Godot, then learning how to use Scene 2 UWMF
will be easy.

## Disadvantages of using Scene 2 UWMF

- You can’t create these fundamental level components:
	- Doors
	- Sound zones
	- Pushwalls
	- Standard level exits (you have to create a boss that will end the
	level, a [Spear of Destiny][SOD item] or a trigger that activates
	[`Exit_VictorySpin()` or a similar action special][action specials]).
- Support for vanilla map formats isn’t even planned.
- If you don’t already know how to use Godot, then learning how to use Scene
2 UWMF will be tedious.

## Getting Started

See [`doc/Getting Started.md`](doc/Getting%20Started.md).

## Value 4 Value

Scene 2 UWMF is completely free (it’s both [libre and
gratis](https://www.gnu.org/philosophy/free-sw.en.html)). Have you gotten any
value from using Scene 2 UWMF? If so [**please contribute value back to the
project**](doc/How%20to%20Contribute.md).

## Copying information

See [`COPYING.txt`](COPYING.txt).

[action specials]: https://maniacsvault.net/ecwolf/wiki/Action_specials#List_of_Action_specials
[SOD item]: https://maniacsvault.net/ecwolf/wiki/Classes:SpearOfDestiny
[things]: https://maniacsvault.net/ecwolf/wiki/Universal_Wolfenstein_Map_Format#Things
