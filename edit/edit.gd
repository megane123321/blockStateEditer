class_name Edit
extends Node3D

@export var path:String
@export var open:bool

func _ready() -> void:
	if open:
		$preView.loadBlock(path)
	else:
		$preView.newFile(path)
	loaded()

func loaded() -> void:
	remove_child($loadingOverRay)
