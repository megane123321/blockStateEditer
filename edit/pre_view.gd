class_name PreView
extends Node3D

var workPath:String
var BlockStates:Array
var KeyList:Array

func addStateKey(key:String) -> void:
	if not key in KeyList:
		KeyList.append(key)

func setWorkPath(path:String) -> void:
	workPath=path.substr(0,path.rfind("/",path.rfind("/blockstates")-1))
	if path==workPath:
		workPath=""

func newFile(path:String) -> void:
	setWorkPath(path)

func loadBlock(path:String) -> void:
	setWorkPath(path)
	var file=FileAccess.open(path,FileAccess.READ)
	var json:Dictionary=JSON.parse_string(file.get_as_text())
	if "variants" in json:
		var states:Array=json["variants"].keys()
		for tmp:String in states:
			if tmp=="":
				BlockStates.append({"":""})
				addStateKey("")
			else:
				var para:Array=tmp.split(",")
				var tmpDict:Dictionary
				for tmp2:String in para:
					var paras:Array=tmp2.split("=")
					tmpDict[paras[0]]=paras[1]
					addStateKey(paras[0])
				BlockStates.append(tmpDict)
			var tmpModel=json["variants"][tmp]
			if tmpModel is Array:
				for tmpModel2:Dictionary in tmpModel:
					print(modelInBlockState.new(tmpModel2,workPath).to_string())
			else:
				print(modelInBlockState.new(tmpModel,workPath).to_string())
			print(tmpModel)
		#print(BlockStates)
		#print(KeyList)
	if "multipart" in json:
		var multipart:Array=json["multipart"]
		for tmp:Dictionary in multipart:
			tmp.keys()
			print(tmp.keys())
