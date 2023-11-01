@tool
class_name CharacterData
extends Resource


@export var weapon: Weapon:
	set = apply_weapon
@export var clothes: Clothes:
	set = apply_clothes
@export var matrix: Matrix:
	set = apply_matrix


func apply_weapon(new_weapon: Weapon) -> void:
	weapon = new_weapon
	if is_instance_valid(weapon):
		if weapon.changed.is_connected(apply_weapon):
			weapon.changed.connect(apply_weapon.bind(weapon))
	emit_changed()


func apply_clothes(new_clothes: Clothes) -> void:
	clothes = new_clothes
	if is_instance_valid(clothes):
		if clothes.changed.is_connected(apply_clothes):
			clothes.changed.connect(apply_clothes.bind(clothes))
	emit_changed()


func apply_matrix(new_matrix: Matrix) -> void:
	matrix = new_matrix
	if is_instance_valid(matrix):
		if matrix.changed.is_connected(apply_matrix):
			matrix.changed.connect(apply_matrix.bind(matrix))
	emit_changed()


func get_character_stats() -> CharacterStats:
	return null
