extends Area2D
@export var next_scene_path: String = "res://scenes/2d/vilarev/vila2.tscn"
func action() -> void:
	
	Global.dialog_on = true 
	
	Global.iniciar_dialogo.emit("res://cutscenes/1.dtl")
	get_tree().change_scene_to_file(next_scene_path)
