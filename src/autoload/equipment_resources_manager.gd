@tool
extends Node


@onready var items_with_equipment: Array[InventoryItem]


func add_item(item: InventoryItem) -> void:
	if not is_node_ready():
		await ready
	if not is_instance_valid(item):
		return
	if item in items_with_equipment:
		return
	items_with_equipment.append(item)


func remove_item(item: InventoryItem) -> void:
	if not is_node_ready():
		await ready
	if not is_instance_valid(item):
		return
	if not item in items_with_equipment:
		return
	items_with_equipment.erase(item)


func get_item(equipment: Equipment) -> InventoryItem:
	for item in items_with_equipment:
		if item.equipment == equipment:
			return item
	return null



#@onready var items_to_equipment: Dictionary
#@onready var equipment_to_items: Dictionary
#
#
#func add_item(item: InventoryItem) -> bool:
#	if not is_node_ready():
#		await ready
#	if not is_instance_valid(item):
#		return false
#	if item in items_to_equipment:
#		if items_to_equipment[item] != item.equipment:
#			return false
#		return true
#	if item.equipment in equipment_to_items:
#		return false
#	items_to_equipment[item] = item.equipment
#	equipment_to_items[item.equipment] = item
#	return true
#
#
#func remove_equipment(equipment: Equipment) -> void:
#	if not is_node_ready():
#		await ready
#	if not is_instance_valid(equipment):
#		return
#	if equipment.item in items_to_equipment:
#		if not equipment in equipment_to_items:
##			items_to_equipment.erase(equipment.item)
#			return
#	if equipment in equipment_to_items:
#		if not equipment.item in items_to_equipment:
##			equipment_to_items.erase(equipment)
#			return
#	items_to_equipment.erase(equipment.item)
#	equipment_to_items.erase(equipment)
