extends Node2D

@export var min_speed := 20
@export var max_speed := 100
@export var screen_width := 1024
@export var screen_height := 600


var cloud_speeds := []

func _ready():
	randomize()
 
	for cloud in get_children():
		var speed = randf_range(min_speed, max_speed)
		cloud_speeds.append(speed)

func _process(delta):
	for i in range(get_child_count()):
		var cloud = get_child(i)
		cloud.position.x -= cloud_speeds[i] * delta
		if cloud.position.x < -cloud.texture.get_width():
			cloud.position.x = screen_width + randf() * 200 
			cloud.position.y = randf() * screen_height
