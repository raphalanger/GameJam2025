extends Camera3D

onready var phantom_target = $PhantomTarget3D

func _process(delta):
	var vila1 = get_node("../front/SubViewport/Vila1")
	var player = vila1.get_tree().get_nodes_in_group("player")[0]
	if player:
		var p = player.global_position
		phantom_target.position = Vector3(p.x / 100.0, -p.y / 100.0, phantom_target.position.z)
