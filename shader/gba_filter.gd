extends CanvasLayer





func _ready() -> void:
	Globals.do_gba_filter.connect(_on_gba_filter)




func _on_gba_filter():
	if Globals.isGBAFILTER == true:
		self.show()
	else:
		self.hide()
		
	
