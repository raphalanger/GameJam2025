extends Node2D

@export var speed: Vector2 = Vector2(-50, 0) 

func _process(delta):

	motion_offset += speed * delta

	var cloud_sprite = get_child(0) 
	if cloud_sprite and cloud_sprite is Sprite2D:
		var tex_width = cloud_sprite.texture.get_width()
		if motion_offset.x <= -tex_width:
			motion_offset.x += tex_width
