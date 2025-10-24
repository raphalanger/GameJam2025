extends Node3D

var dialog_started = false 

func _ready() -> void:

	Global.iniciar_dialogo.connect(_on_global_iniciar_dialogo)
	
	Dialogic.timeline_ended.connect(_on_dialogic_timeline_ended)

func _on_global_iniciar_dialogo(caminho: String) -> void:
	Dialogic.start(caminho)

func _on_dialogic_timeline_ended() -> void:
	
	Global.dialog_on = false
