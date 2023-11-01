@tool
class_name Equipment
extends Resource


@export var min_character_level := 1:
	set(value):
		min_character_level = value
		emit_changed()

@export var equipment_progress: Array[CharacterStats]:
	set = apply_progress


func apply_progress(new_progress: Array[CharacterStats]) -> void:
	equipment_progress = new_progress
	for level in equipment_progress.size():
		if not is_instance_valid(equipment_progress[level]):
			equipment_progress[level] = CharacterStats.new()
		var progress_level := equipment_progress[level]
		if not progress_level.changed.is_connected(change_progress):
			progress_level.changed.connect(change_progress)
	emit_changed()


func change_progress() -> void:
	equipment_progress = equipment_progress


func get_character_stats(character_level: int) -> CharacterStats:
	var index := character_level - min_character_level
	if index < 0 or index > len(equipment_progress):
		return null
	return equipment_progress[index]
