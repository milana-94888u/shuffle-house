@tool
class_name InventoryGrid
extends CenterContainer


signal swap_items_with_floating_requested(ui_slot: Slot)
signal take_one_item_requested(ui_slot: Slot)


@onready var inventory_grid := %InventoryItemsGrid as GridContainer

@export var slot_scene: PackedScene
@export var filter_category: ItemCategory:
	set(new_category):
		filter_category = new_category
		inventory = inventory


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
		if is_instance_valid(filter_category):
			if is_instance_valid(inventory_slot.item):
				if inventory_slot.item.category != filter_category:
					continue
		var new_slot := slot_scene.instantiate() as Slot
		new_slot.slot = inventory_slot
		new_slot.swap_items_with_floating_requested.connect(swap_with_floating_requested)
		new_slot.take_one_item_requested.connect(take_one_to_floating_requested)
		inventory_grid.add_child(new_slot)


func swap_with_floating_requested(static_slot: Slot) -> void:
	swap_items_with_floating_requested.emit(static_slot)


func take_one_to_floating_requested(static_slot: Slot) -> void:
	take_one_item_requested.emit(static_slot)
