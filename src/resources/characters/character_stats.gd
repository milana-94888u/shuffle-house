@tool
class_name CharacterStats
extends Resource


@export var health := 10:
	set(value):
		if value < 1:
			return
		health = value
		emit_changed()
@export var dexterity := 1:
	set(value):
		if value < 1:
			return
		dexterity = value
		emit_changed()
@export var persuation := 1:
	set(value):
		if value < 1:
			return
		persuation = value
		emit_changed()
@export var strength := 1:
	set(value):
		if value < 1:
			return
		strength = value
		emit_changed()


func apply_skills(new_skills: Array[CharacterSkill]) -> void:
	skills = new_skills
	for skill in skills:
		if is_instance_valid(skill):
			if not skill.changed.is_connected(change_skills):
				skill.changed.connect(change_skills)
	emit_changed()


func change_skills() -> void:
	skills = skills


@export var skills: Array[CharacterSkill]
