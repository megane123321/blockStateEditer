class_name Edit
extends Node3D

@export var path:String

func _ready() -> void:
	$preView.loadBlock(path)
	loaded()

func loaded() -> void:
	remove_child($loadingOverRay)
