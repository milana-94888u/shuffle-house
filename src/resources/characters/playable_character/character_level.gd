@tool
class_name CharacterLevel
extends Resource


@export var stats: CharacterStats:
	set = apply_stats
@export var experience_from_previous := 0:
	set(value):
		experience_from_previous = value
		emit_changed()


func apply_stats(new_stats: CharacterStats) -> void:
	stats = new_stats
	if not is_instance_valid(stats):
		stats = CharacterStats.new()
	if not stats.changed.is_connected(apply_stats):
		stats.changed.connect(apply_stats.bind(stats))
	emit_changed()
