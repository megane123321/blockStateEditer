class_name OverRay
extends ColorRect

var ray:Ray

func _ready() -> void:
	set_size(get_viewport_rect().size)
	set_position(Vector2(0,0))
	color=Color(0,0,0,0.5)
	ray=Ray.new()
	add_child(ray)

func disVisible() -> void:
		get_parent().remove_child(self)

class Ray:
	extends BaseButton

	func _ready() -> void:
		pressed.connect(disVisible)
		set_size(get_viewport_rect().size)
		set_position(Vector2(0,0))

	func disVisible() -> void:
		get_parent().disVisible()
