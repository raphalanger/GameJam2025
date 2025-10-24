extends Area2D

func action() -> void:
	
	Global.dialog_on = true 
	
	Global.iniciar_dialogo.emit("res://cutscenes/1.dtl")
