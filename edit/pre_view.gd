class_name PreView
extends Node3D

var BlockStates:Array
var KeyList:Array

func addStateKey(key:String) -> void:
	if not key in KeyList:
		KeyList.append(key)

func loadBlock(path:String) -> void:
	var file=FileAccess.open(path,FileAccess.READ)
	var json:Dictionary=JSON.parse_string(file.get_as_text())
	if "variants" in json:
		var states:Array=json["variants"].keys()
		for tmp:String in states:
			if tmp=="":
				BlockStates.append({"":""})
				addStateKey("")
				continue
			var para:Array=tmp.split(",")
			var tmpDict:Dictionary
			for tmp2:String in para:
				var paras:Array=tmp2.split("=")
				tmpDict[paras[0]]=paras[1]
				addStateKey(paras[0])
			BlockStates.append(tmpDict)
		print(BlockStates)
		print(KeyList)
	if "multipart" in json:
		var multipart:Array=json["multipart"]
		for tmp:Dictionary in multipart:
			tmp.keys()
			print(tmp.keys())
