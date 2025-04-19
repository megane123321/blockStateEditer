class_name OpenFile
extends Button

var toEdit=ToEdit.new()

func _ready() -> void:
	pressed.connect(open)
	add_child(toEdit)

var openFile:FileDialog

func open() -> void:
	openFile=FileDialog.new()
	openFile.filters=["*.json"]
	openFile.file_mode=FileDialog.FILE_MODE_OPEN_FILE
	openFile.access=FileDialog.ACCESS_FILESYSTEM
	openFile.file_selected.connect(closeWindow)
	openFile.file_selected.connect(toEdit.toEdit)
	openFile.canceled.connect(closeWindow)
	add_child(openFile)
	openFile.visible=true

func closeWindow() -> void:
	remove_child(openFile)
