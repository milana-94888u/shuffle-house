@tool
class_name ItemCategory
extends Resource


@export var icon: Texture2D:
	set(value):
		icon = value
		emit_changed()

@export var name: String:
	set(value):
		name = value
		emit_changed()
