extends Area2D

@export var next_scene_path: String = "res://cenes/3d/test2/test2_3d_ccen.tscn"
var inside_bodies := []

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "player" and not body in inside_bodies:
		get_tree().change_scene_to_file(next_scene_path)

func _on_body_exited(body):
	if body in inside_bodies:
		inside_bodies.erase(body)
