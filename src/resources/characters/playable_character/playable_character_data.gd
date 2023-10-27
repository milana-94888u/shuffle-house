@tool
class_name PlayableCharacterData
extends CharacterData


var no_process_flag := false


@export var possible_levels: Array[CharacterLevel]:
	set = apply_levels
@export var experience := 0:
	set(value):
		if value < 0:
			return
		experience = value
		if no_process_flag:
			return
		var accumulated_exp := 0
		var target_level := 0
		while target_level < possible_levels.size() and accumulated_exp <= experience:
			target_level += 1
			if target_level < possible_levels.size():
				accumulated_exp += possible_levels[target_level].experience_from_previous
		no_process_flag = true
		level = target_level
		no_process_flag = false
		emit_changed()

@export var level := 1:
	set(value):
		if value < 1 or value > possible_levels.size():
			return
		level = value
		if no_process_flag:
			return
		no_process_flag = true
		experience = calculate_needed_experience(level)
		no_process_flag = false
		emit_changed()


func calculate_needed_experience(target_level: int) -> int:
	var experience_accumulator := 0
	for i in range(target_level):
		experience_accumulator += possible_levels[i].experience_from_previous
	return experience_accumulator


func apply_levels(new_levels: Array[CharacterLevel]) -> void:
	possible_levels = new_levels
	if possible_levels.is_empty():
		possible_levels = [CharacterLevel.new()]
	if not is_instance_valid(possible_levels[0]):
		possible_levels[0] = CharacterLevel.new()
	if possible_levels[0].experience_from_previous != 0:
		possible_levels[0].set_block_signals(true)
		possible_levels[0].experience_from_previous = 0
		possible_levels[0].set_block_signals(false)
	if not possible_levels[0].changed.is_connected(change_levels):
		possible_levels[0].changed.connect(change_levels)
	for i in range(1, possible_levels.size()):
		if not is_instance_valid(possible_levels[i]):
			possible_levels[i] = CharacterLevel.new()
		print(possible_levels[i].get_class())
		if possible_levels[i].experience_from_previous < 1:
			possible_levels[i].set_block_signals(true)
			possible_levels[i].experience_from_previous = 1
			possible_levels[i].set_block_signals(false)
		if not possible_levels[i].changed.is_connected(change_levels):
			possible_levels[i].changed.connect(change_levels)
	experience = experience
	emit_changed()


func change_levels() -> void:
	possible_levels = possible_levels


func _init() -> void:
	possible_levels = []
