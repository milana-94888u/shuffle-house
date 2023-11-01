@tool
extends Control


@onready var floating_slot := %FloatingUIItemSlot as FloatingSlot
@onready var all_player_inventory_grid := %AllPlayerInventoryGrid as InventoryGrid


@export var slot_scene: PackedScene
@export var filter_category: ItemCategory


func swap_with_floating(static_slot: Slot) -> void:
	floating_slot.slot.swap_with(static_slot.slot)


func take_one_to_floating(static_slot: Slot) -> void:
	static_slot.slot.take_one(floating_slot.slot)


func _on_category_buttons_filter_category_requested(category: ItemCategory) -> void:
	if not is_node_ready():
		await ready
	all_player_inventory_grid.filter_category = category
