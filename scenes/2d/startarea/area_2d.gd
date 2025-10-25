extends Area2D

@export var nodes_para_mostrar: Array[CanvasItem]
var ja_foi_ativado: bool = false

func _ready():
	for node in nodes_para_mostrar:
		if node:
			node.visible = false
func action():
	pass
func _on_body_entered(body):
	if not ja_foi_ativado:
		ja_foi_ativado = true
		
		print("Ação ativada!") # Bom para testar
		
		for node in nodes_para_mostrar:
			if node:
				node.visible = true
