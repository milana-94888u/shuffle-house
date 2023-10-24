@tool
class_name GameInventory
extends Resource


@export var min_empty_slots := 10


@export var slots: Array[InventorySlot]:
	set = apply_slots


func _init() -> void:
	apply_slots([])


func apply_slots(new_slots: Array[InventorySlot]) -> void:
	slots = new_slots
	for index in len(slots):
		if slots[index] == null:
			slots[index] = InventorySlot.new()
	slots.sort_custom(compare_slots)
	var empty_count := 0
	var index = len(slots) - 1
	while index >= 0 and slots[index].item == null:
		empty_count += 1
		index -= 1
	
	if empty_count < min_empty_slots:
		for i in range(min_empty_slots - empty_count):
			slots.push_back(InventorySlot.new())
	
	for slot in slots:
		if slot.changed.is_connected(apply_slots):
			continue
		slot.changed.connect(apply_slots.bind(slots))

	emit_changed()


func compare_slots(left_slot: InventorySlot, right_slot: InventorySlot) -> bool:
	if not is_instance_valid(right_slot.item):
		return true
	if not is_instance_valid(left_slot.item):
		return false
	if left_slot.item.price == right_slot.item.price:
		return left_slot.get_rid() < right_slot.get_rid()
	return left_slot.item.price > right_slot.item.price


func sort_slots() -> void:
	slots.sort_custom(compare_slots)
