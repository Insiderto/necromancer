extends KinematicBody2D

class_name Minion

var is_selected: bool = false
const outline_shader = preload("res://assets/materials/outline_shader.tres")


func _ready():
	$Sprite.set_material(null)
	is_selected = false


func handle_select():
	is_selected = !is_selected
	if is_selected:
		$Sprite.set_material(outline_shader)
		$Sprite.material.set_shader_param("width", 0.5)
	else:
		$Sprite.set_material(null)


func select():
	is_selected = true
	$Sprite.set_material(outline_shader)
	$Sprite.material.set_shader_param("width", 0.5)


func unselect():
	is_selected = false
	$Sprite.set_material(null)
