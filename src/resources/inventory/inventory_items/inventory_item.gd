@tool
class_name InventoryItem
extends Resource

@export var icon: Texture2D:
	set(value):
		icon = value
		emit_changed()

@export var category: ItemCategory:
	set(value):
		category = value
		emit_changed()
@export var name: String:
	set(value):
		name = value
		emit_changed()
@export_multiline var description: String:
	set(value):
		description = value
		emit_changed()
@export var price: float:
	set(value):
		price = value
		emit_changed()
