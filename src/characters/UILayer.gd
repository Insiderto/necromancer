extends Node2D

var dragging = false
var drag_start = Vector2.ZERO
var drag_end = Vector2.ZERO
var select_rect = RectangleShape2D.new()
var selected = []


func _ready():
	pass


signal selection_started
signal selection_finished(selected)


func _unhandled_input(event):
	if (
		event is InputEventMouseButton
		and (event as InputEventMouseButton).button_index == BUTTON_LEFT
	):
		var mouseEvent = event as InputEventMouseButton
		if mouseEvent.pressed:
			dragging = true
			emit_signal("selection_started")
			drag_start = get_global_mouse_position()
		elif dragging:
			dragging = false
			drag_end = get_global_mouse_position()
			select_rect.extents = (drag_start - drag_end) / 2
			var space = get_world_2d().direct_space_state
			var query = Physics2DShapeQueryParameters.new()
			query.set_shape(select_rect)
			query.transform = Transform2D(0, (drag_end + drag_start) / 2)
			selected = space.intersect_shape(query)
			emit_signal("selection_finished", selected)


func _process(_delta):
	update()


func _draw():
	if dragging:
		draw_rect(
			Rect2(drag_start, get_global_mouse_position() - drag_start), Color(0.5, 0.5, 0.5, 0.3)
		)
