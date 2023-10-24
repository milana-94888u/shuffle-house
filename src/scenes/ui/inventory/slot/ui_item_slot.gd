@tool
class_name Slot
extends PanelContainer


signal swap_items_with_floating_requested(ui_slot: Slot)
signal take_one_item_requested(ui_slot: Slot)


@onready var category_icon := $CategoryIcon as TextureRect
@onready var item_icon := $ItemIcon as TextureRect
@onready var item_amount_label := $ItemIcon/ItemAmountLabel as Label


@export var slot: InventorySlot:
	set = apply_slot


func apply_slot(new_slot: InventorySlot) -> void:
	if not is_node_ready():
		await ready
	
	slot = new_slot
	if not is_instance_valid(slot):
		category_icon.texture = null
		item_icon.texture = null
		item_amount_label.hide()
		return
	
	if not slot.changed.is_connected(apply_slot):
		slot.changed.connect(apply_slot.bind(slot))

	category_icon.texture = slot.get_category_icon()
	item_icon.texture = slot.get_item_icon()
	item_amount_label.text = str(slot.amount)
	item_amount_label.visible = slot.amount > 1
	


func _ready() -> void:
	if Engine.is_editor_hint():
		if slot == null:
			slot = InventorySlot.new()
		else:
			slot = slot.duplicate()


func _on_mouse_entered() -> void:
	pass # Add selected effect


func _on_mouse_exited() -> void:
	pass # Remove selected effect


func process_click(event: InputEventMouseButton) -> void:
	match event.button_index:
		MOUSE_BUTTON_LEFT:
			swap_items_with_floating_requested.emit(self)
		MOUSE_BUTTON_RIGHT:
			take_one_item_requested.emit(self)


func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		process_click(event)
		
