class_name ToEdit
extends Node

var error:AcceptDialog
var overRay:OverRay

func toEdit(fileName:String="",fileOpen:bool=true) -> void:
	if not (fileOpen or fileName.ends_with(".json")):
		error=AcceptDialog.new()
		error.canceled.connect(closeError)
		error.confirmed.connect(closeError)
		error.dialog_text="選択されたファイルはjson形式ではありません。"
		error.visible=true
		overRay=OverRay.new()
		add_child(overRay)
		add_child(error)
		return
	var sceneNode=load("res://edit/edit.tscn").instantiate()
	sceneNode.path=fileName
	sceneNode.open=fileOpen
	var packed=PackedScene.new()
	packed.pack(sceneNode)
	get_tree().change_scene_to_packed(packed)

func closeError() -> void:
	remove_child(error)
	remove_child(overRay)
