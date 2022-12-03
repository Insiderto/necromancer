extends KinematicBody2D

onready var vieport: Vector2 = get_viewport().size
export(int) var speed = 200

var is_selecting = false

var controlled_minions = []


func _process(_delta):
	if !Input.is_action_pressed("left_mouse"):
		var mouse_position: Vector2 = get_global_mouse_position()
		($Camera2D as Camera2D).offset_h = (mouse_position.x - global_position.x) / (vieport.x / 3)
		($Camera2D as Camera2D).offset_v = (mouse_position.y - global_position.y) / (vieport.y / 3)


func get_input() -> Vector2:
	var velocity = Vector2()
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
	return velocity


func _physics_process(_delta):
	move_and_slide(get_input())


func _on_SelectionNode_selection_finished(selected):
	is_selecting = false

	if selected.size() == 0:
		unselect_all()
	else:
		if !Input.is_action_pressed("shift_mod"): # fasdfas
			unselect_all()
		select_all(selected)


func _on_SelectionNode_selection_started():
	is_selecting = true


func unselect_all():
	for el in controlled_minions:
		el.unselect()
	controlled_minions = []


func select_all(candidates):
	for el in candidates:
		var selected_object = el.collider
		if selected_object.has_method("select"): # is ISelectable 
			controlled_minions.append(selected_object)
			selected_object.select()
