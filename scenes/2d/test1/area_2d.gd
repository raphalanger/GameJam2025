extends Area2D

@export var next_scene_path: String = "res://scenes/3d/vila/vila.tscn"
@export var fade_time: float = 1.0

@onready var fade_rect := get_viewport().get_node("FadeLayer/ColorRect")
var inside_bodies := []

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	connect("body_exited", Callable(self, "_on_body_exited"))

func _on_body_entered(body):
	if body.name == "player" and not body in inside_bodies:
		inside_bodies.append(body)
		await fade_out()
		get_tree().change_scene_to_file(next_scene_path)

func _on_body_exited(body):
	if body in inside_bodies:
		inside_bodies.erase(body)

func fade_out():
	if not fade_rect:
		push_warning("ColorRect de fade não encontrado dentro do Viewport.")
		return
	fade_rect.visible = true
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, fade_time)
	await tween.finished
