@tool
class_name InventoryItem
extends Resource

@export var icon: Texture2D:
	set(value):
		icon = value
		emit_changed()

@export var category: ItemCategory:
	set = apply_category
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

@export var equipment: Equipment:
	set = apply_equipment


func apply_category(new_category: ItemCategory) -> void:
	category = new_category
	if is_instance_valid(category):
		if not category.changed.is_connected(apply_category):
			category.changed.connect(apply_category.bind(category))
	emit_changed()


func apply_equipment(new_equipment: Equipment) -> void:
#	if not is_instance_valid(new_equipment):
#		EquipmentResourcesManager.remove_equipment(equipment)
	equipment = new_equipment
	if is_instance_valid(equipment):
		if not equipment.changed.is_connected(apply_equipment):
			equipment.changed.connect(apply_equipment.bind(equipment))
		EquipmentResourcesManager.add_item(self)
	else:
		EquipmentResourcesManager.remove_item(self)
	emit_changed()


func _notification(what: int) -> void:
	if what == NOTIFICATION_POSTINITIALIZE:
		if is_instance_valid(equipment):
			EquipmentResourcesManager.add_item(self)
	if what == NOTIFICATION_PREDELETE:
		EquipmentResourcesManager.remove_item(self)
