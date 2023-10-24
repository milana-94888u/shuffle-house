class_name FloatingSlot
extends TextureRect


@export var slot: InventorySlot:
	set = apply_slot


func apply_slot(new_slot: InventorySlot) -> void:
	if not is_node_ready():
		await ready
	
	slot = new_slot
	if not is_instance_valid(slot):
		texture = null
		return
	
	if not slot.changed.is_connected(apply_slot):
		slot.changed.connect(apply_slot.bind(slot))
	texture = slot.get_item_icon()


func _ready() -> void:
	if slot == null:
		slot = InventorySlot.new()
	else:
		slot = slot.duplicate()


func _process(_delta: float) -> void:
	global_position = get_global_mouse_position()
