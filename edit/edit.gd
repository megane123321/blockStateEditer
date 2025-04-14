class_name Edit
extends Node3D

@export var path:String

func _ready() -> void:
	$preView.loadBlock(path)
	print(path.substr(0,path.rfind("/test_json")))
	loaded()

func loaded() -> void:
	remove_child($loadingOverRay)
