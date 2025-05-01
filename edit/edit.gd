class_name Edit
extends Node3D

@export var path:String
@export var open:bool

func _ready() -> void:
	if open:#新規か否か
		$preView.loadBlock(path)
	else:
		$preView.newFile(path)
	loaded()

func loaded() -> void:#読み込み終了
	remove_child($loadingOverRay)
