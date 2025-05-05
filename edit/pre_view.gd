class_name PreView
extends Node3D

var workPath:String
var blockState:BlockState

func setWorkPath(path:String) -> void:
	workPath=path.substr(0,path.rfind("/",path.rfind("/blockstates")-1))
	if path==workPath:
		workPath=""

func newFile(path:String) -> void:
	setWorkPath(path)

func loadBlock(path:String) -> void:
	setWorkPath(path)
	var tmp=BlockState.new(path,workPath,false).getModelFile({})
	for i in tmp:
		add_child(i.getModel())
