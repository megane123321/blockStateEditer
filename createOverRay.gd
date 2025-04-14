class_name CreateOverRay
extends Button

func _ready() -> void:
	pressed.connect(createOverRay)

var overRay:OverRay=null

func createOverRay() -> void:
	overRay=OverRay.new()
	get_parent().add_child(overRay)
	
func getOverRay() -> OverRay:
	if overRay==null:
		createOverRay()
	return overRay
