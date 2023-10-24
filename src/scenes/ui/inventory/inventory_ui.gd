@tool
extends Control


@onready var inventory_grid := %InventoryItemsGrid as GridContainer
@onready var floating_slot := %FloatingUIItemSlot as FloatingSlot


@export var slot_scene: PackedScene
@export var filter_category: ItemCategory


@export var inventory: GameInventory:
	set = apply_inventory


func apply_inventory(new_inventory: GameInventory) -> void:
	if not is_node_ready():
		await ready
	inventory = new_inventory
	for child in inventory_grid.get_children():
		inventory_grid.remove_child(child)
	if inventory == null:
		return
	if not inventory.changed.is_connected(apply_inventory):
		inventory.changed.connect(apply_inventory.bind(inventory))
	for inventory_slot in inventory.slots:
		var new_slot := slot_scene.instantiate() as Slot
		new_slot.slot = inventory_slot
		new_slot.swap_items_with_floating_requested.connect(swap_with_floating)
		new_slot.take_one_item_requested.connect(take_one_to_floating)
		inventory_grid.add_child(new_slot)


func swap_with_floating(static_slot: Slot) -> void:
	floating_slot.slot.swap_with(static_slot.slot)


func take_one_to_floating(static_slot: Slot) -> void:
	static_slot.slot.take_one(floating_slot.slot)


func _on_matrix_category_button_pressed() -> void:
	pass # Replace with function body.


func _on_weapon_category_button_pressed() -> void:
	pass # Replace with function body.


func _on_armor_category_button_pressed() -> void:
	pass # Replace with function body.


func _on_story_category_button_pressed() -> void:
	pass # Replace with function body.


func _on_all_categories_button_pressed() -> void:
	pass # Replace with function body.
