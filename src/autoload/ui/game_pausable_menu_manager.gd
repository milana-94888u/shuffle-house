extends CanvasLayer


var is_ongoing_game := false
var current_open_menu: Control


@onready var pause_menu := $PauseMenu


func request_open_menu(menu: Control) -> void:
	if current_open_menu:
		return
	get_tree().paused = true
	current_open_menu = menu
	current_open_menu.show()


func request_close_menu() -> void:
	if current_open_menu == null:
		return
	get_tree().paused = false
	current_open_menu.hide()
	current_open_menu = null


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if current_open_menu:
			request_close_menu()
		else:
			request_open_menu(pause_menu)


func _on_continue_button_pressed() -> void:
	request_close_menu()
