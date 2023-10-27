extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for x in 12:
		for y in 9:
			$TileMap.set_cell(0, Vector2i(x, y), 0, Vector2i(7, 4))
			await get_tree().create_timer(0.4).timeout


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(delta)
