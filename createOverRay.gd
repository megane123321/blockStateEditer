class_name CreateOverRay
extends Button

func _ready() -> void:
	pressed.connect(createOverRay)

var overRay:OverRay=null

func createOverRay() -> void:#オーバーレイの作成
	overRay=OverRay.new()
	get_parent().add_child(overRay)
	
func getOverRay() -> OverRay:#オーバーレイの取得
	if overRay==null:
		createOverRay()
	return overRay
