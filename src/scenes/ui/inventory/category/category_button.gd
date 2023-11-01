extends TextureButton


@onready var selected_texture := $SelectedTexture as TextureRect


func _on_toggled(is_button_pressed: bool) -> void:
	selected_texture.visible = is_button_pressed
