@tool
extends HBoxContainer


signal filter_category_requested(category: ItemCategory)


var group: ButtonGroup


func _init() -> void:
	group = ButtonGroup.new()
	group.allow_unpress = true


@export var filter_categories: Array[ItemCategory]:
	set = apply_categories
@export var all_categories_icon: Texture2D:
	set = apply_all_categories_icon

@export var category_button_scene: PackedScene


func apply_categories(new_categories: Array[ItemCategory]) -> void:
	if not is_node_ready():
		await ready
	filter_categories = new_categories
	set_buttons()


func apply_all_categories_icon(new_icon: Texture2D) -> void:
	if not is_node_ready():
		await ready
	all_categories_icon = new_icon
	set_buttons()


func add_button(icon: Texture2D, button_name: String, category: ItemCategory = null) -> void:
	var new_button := category_button_scene.instantiate() as TextureButton
	new_button.texture_normal = icon
	new_button.tooltip_text = button_name
	new_button.toggled.connect(process_button_toggle.bind(category))
	new_button.button_group = group
	add_child(new_button)


func process_button_toggle(button_pressed: bool, category: ItemCategory) -> void:
	if button_pressed:
		filter_category_requested.emit(category)
	else:
		filter_category_requested.emit(null)


func set_buttons() -> void:
	for child in get_children():
		remove_child(child)
	for category in filter_categories:
		if not is_instance_valid(category):
			continue
		if not category.changed.is_connected(apply_categories):
			category.changed.connect(apply_categories.bind(filter_categories))
		add_button(category.icon, category.name, category)
	if is_instance_valid(all_categories_icon):
		group.allow_unpress = false
		add_button(all_categories_icon, "All categories")
		(get_children()[-1] as TextureButton).button_pressed = true
	else:
		group.allow_unpress = true
