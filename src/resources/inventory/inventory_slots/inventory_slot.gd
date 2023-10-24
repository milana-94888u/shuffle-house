@tool
class_name InventorySlot
extends Resource


@export var item: InventoryItem:
	set = apply_item
@export var amount: int:
	set(value):
		amount = value
		emit_changed()


func apply_item(new_item: InventoryItem) -> void:
	item = new_item
	if is_instance_valid(item):
		if not item.changed.is_connected(apply_item):
			item.changed.connect(apply_item.bind(item))
	emit_changed()


func check_can_put_item(_requested_item: InventoryItem) -> bool:
	return true


func get_category_icon() -> Texture2D:
	return null


func get_item_icon() -> Texture2D:
	if is_instance_valid(item):
		return item.icon
	return null


func swap_with(other_slot: InventorySlot) -> void:
	if not(check_can_put_item(other_slot.item) and other_slot.check_can_put_item(item)):
		return
	if other_slot.item == item:
		other_slot.amount += amount
		amount = 0
		item = null
		return
	var temp_item := item
	var temp_amount := amount
	item = other_slot.item
	amount = other_slot.amount
	other_slot.item = temp_item
	other_slot.amount = temp_amount


func take_one(to_slot: InventorySlot) -> void:
	if not is_instance_valid(item):
		return
	if is_instance_valid(to_slot.item) and to_slot.item != item:
		return
	to_slot.item = item
	to_slot.amount += 1
	amount -= 1
	if amount < 1:
		item = null
		amount = 0
