class_name OverRay
extends Button

func _ready() -> void:
	pressed.connect(disVisible)
	set_size(get_viewport_rect().size)
	set_position(Vector2(0,0))

func disVisible() -> void:
	visible=false
