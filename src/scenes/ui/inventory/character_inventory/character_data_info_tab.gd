@tool
extends PanelContainer


@export var character_data: PlayableCharacterData:
	set = apply_character_data


func apply_character_data(new_character_data: PlayableCharacterData) -> void:
	if not is_node_ready():
		await ready
	character_data = new_character_data
	if not is_instance_valid(character_data):
		matrix_ui_slot.set_block_signals(true)
		matrix_ui_slot.slot.item = null
		matrix_ui_slot.slot.amount = 0
		matrix_ui_slot.set_block_signals(false)
		weapon_ui_slot.set_block_signals(true)
		weapon_ui_slot.slot.item = null
		weapon_ui_slot.slot.amount = 0
		weapon_ui_slot.set_block_signals(false)
		clothes_ui_slot.set_block_signals(true)
		clothes_ui_slot.slot.item = null
		clothes_ui_slot.slot.amount = 0
		clothes_ui_slot.set_block_signals(false)
		return
	if not character_data.changed.is_connected(apply_character_data):
		character_data.changed.connect(apply_character_data.bind(character_data))
	if is_instance_valid(character_data.matrix):
		matrix_ui_slot.set_block_signals(true)
		matrix_ui_slot.slot.item = EquipmentResourcesManager.get_item(character_data.matrix)
		matrix_ui_slot.slot.amount = 1
		matrix_ui_slot.set_block_signals(false)
	else:
		matrix_ui_slot.set_block_signals(true)
		matrix_ui_slot.slot.item = null
		matrix_ui_slot.slot.amount = 0
		matrix_ui_slot.set_block_signals(false)
	if is_instance_valid(character_data.weapon):
		weapon_ui_slot.set_block_signals(true)
		weapon_ui_slot.slot.item = EquipmentResourcesManager.get_item(character_data.weapon)
		weapon_ui_slot.slot.amount = 1
		weapon_ui_slot.set_block_signals(false)
	else:
		weapon_ui_slot.set_block_signals(true)
		weapon_ui_slot.slot.item = null
		weapon_ui_slot.slot.amount = 0
		weapon_ui_slot.set_block_signals(false)
	if is_instance_valid(character_data.clothes):
		clothes_ui_slot.set_block_signals(true)
		clothes_ui_slot.slot.item = EquipmentResourcesManager.get_item(character_data.clothes)
		clothes_ui_slot.slot.amount = 1
		clothes_ui_slot.set_block_signals(false)
	else:
		clothes_ui_slot.set_block_signals(true)
		clothes_ui_slot.slot.item = null
		clothes_ui_slot.slot.amount = 0
		clothes_ui_slot.set_block_signals(false)


@onready var matrix_ui_slot := %MatrixSlot as Slot
@onready var weapon_ui_slot := %WeaponSlot as Slot
@onready var clothes_ui_slot := %ClothesSlot as Slot


func _on_matrix_slot_updated_slot() -> void:
	if not is_node_ready():
		await ready
	if not is_instance_valid(character_data):
		return
	if is_instance_valid(matrix_ui_slot.slot.item):
		character_data.set_block_signals(true)
		character_data.matrix = matrix_ui_slot.slot.item.equipment as Matrix
		character_data.set_block_signals(false)


func _on_weapon_slot_updated_slot() -> void:
	if not is_node_ready():
		await ready
	if not is_instance_valid(character_data):
		return
	if is_instance_valid(weapon_ui_slot.slot.item):
		character_data.set_block_signals(true)
		character_data.weapon = weapon_ui_slot.slot.item.equipment as Weapon
		character_data.set_block_signals(false)


func _on_clothes_slot_updated_slot() -> void:
	if not is_node_ready():
		await ready
	if not is_instance_valid(character_data):
		return
	if is_instance_valid(clothes_ui_slot.slot.item):
		character_data.set_block_signals(true)
		character_data.clothes = clothes_ui_slot.slot.item.equipment as Clothes
		character_data.set_block_signals(false)
