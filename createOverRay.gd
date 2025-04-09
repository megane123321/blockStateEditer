class_name CreateOverRay
extends Button

func _ready() -> void:
	pressed.connect(createOverRay)

func createOverRay() -> void:
	var overRay=OverRay.new()
	print("create!")
	add_child(overRay)
