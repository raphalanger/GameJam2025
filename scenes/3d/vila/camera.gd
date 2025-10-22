extends Node3D

@onready var phantom_target = $PhantomCamera3D
var vila1: Node = null
var player: Node2D = null

func _ready():
	await get_tree().create_timer(0.5).timeout
	vila1 = get_node_or_null("../../scenes/2d/vila/vila1")
	if vila1:
		var players = vila1.get_tree().get_nodes_in_group("player")
		if players.size() > 0:
			player = players[0]
			print("🎯 Player encontrado:", player.name)
		else:
			print("⚠ Nenhum player encontrado dentro de Vila1!")
	else:
		print("❌ Não foi possível acessar Vila1 no SubViewport!")

func _process(_delta):
	if not player:
		return

	var p = player.global_position
	phantom_target.position = Vector3(p.x / 100.0, -p.y / 100.0, phantom_target.position.z)
