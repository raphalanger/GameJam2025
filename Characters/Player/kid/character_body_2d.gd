extends CharacterBody2D

const SPEED = 100.0
const RUN_SPEED = 200.0 
const JUMP_VELOCITY = -400.0

var direction : float = 0.0

@onready var animation_tree : AnimationTree = $Animetree
@onready var sprite : AnimatedSprite2D = $Anime

func _ready():
	animation_tree.active = true

func _physics_process(delta: float) -> void:
	# Adiciona Gravidade
	if not is_on_floor(): # se nao tiver no chao
		velocity.y += get_gravity().y * delta # incrementa o valor da gravidada na velocidade em y

	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	direction = Input.get_axis("move_left", "move_right")
	
	var current_speed = SPEED
	
	if Input.is_action_pressed("run") and is_on_floor():
		current_speed = RUN_SPEED
		
		
	if direction:
		velocity.x = direction * current_speed
	else:
		velocity.x = 0.0
		
	move_and_slide()
	
	update_direction()
	update_animation()
	speed_test(current_speed)
	
func update_direction():
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
func update_animation():
	animation_tree.set("parameters/move/blend_position",direction)
	animation_tree.set("parameters/run/blend_position",direction)
func speed_test(current_speed):
	if current_speed > 150:
		animation_tree.set("parameters/conditions/is_runnig",true)
		animation_tree.set("parameters/conditions/is_walk",false)
	else:
		animation_tree.set("parameters/conditions/is_walk",true)
		animation_tree.set("parameters/conditions/is_runnig",false)
