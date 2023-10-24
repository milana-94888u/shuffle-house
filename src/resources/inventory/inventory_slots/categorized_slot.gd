@tool
class_name CategorizedSlot
extends InventorySlot

@export var accepted_category: ItemCategory:
	set = apply_category


func apply_category(category: ItemCategory) -> void:
	accepted_category = category
	if is_instance_valid(accepted_category):
		if not accepted_category.changed.is_connected(apply_category):
			accepted_category.changed.connect(apply_category.bind(accepted_category))
	emit_changed()


func get_category_icon() -> Texture2D:
	if is_instance_valid(accepted_category):
		if is_instance_valid(accepted_category.icon):
			return accepted_category.icon
	return null


func check_can_put_item(requested_item: InventoryItem) -> bool:
	if requested_item == null:
		return true
	return accepted_category == requested_item.category
