extends CharacterBody2D

const SPEED = 100.0
const RUN_SPEED = 300.0 
const JUMP_VELOCITY = -400.0
const GRAVITY: float = 980.0 # Exemplo de gravidade para CharacterBody2D

var direction : float = 0.0
var can_move: bool = true 
var cutscene_move_speed: float = 100.0 

@onready var animation_tree : AnimationTree = $Animetree
@onready var sprite : AnimatedSprite2D = $Anime
@onready var actinables_finder: Area2D = $Area2D

func _ready():
	animation_tree.active = true

func _get_gravity() -> Vector2:
	return Vector2(0, GRAVITY)

func _physics_process(delta: float) -> void:
	if can_move:
		# Adiciona Gravidade
		if not is_on_floor(): 
			velocity.y += _get_gravity().y * delta

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
	else:
		# Aplica gravidade mesmo se estiver bloqueado (e não se movendo na cutscene)
		if not is_on_floor():
			velocity.y += _get_gravity().y * delta
		
		if velocity.x == 0.0:
			move_and_slide()
		
		# Para a animação
		animation_tree.set("parameters/conditions/is_runnig", false)
		animation_tree.set("parameters/conditions/is_walk", false)
		
func update_direction():
	if direction > 0:
		sprite.flip_h = false
	elif direction < 0:
		sprite.flip_h = true
		
func update_animation():
	animation_tree.set("parameters/move/blend_position", direction)
	animation_tree.set("parameters/run/blend_position", direction)
	
func speed_test(current_speed):
	if current_speed > 150:
		animation_tree.set("parameters/conditions/is_runnig", true)
		animation_tree.set("parameters/conditions/is_walk", false)
	else:
		animation_tree.set("parameters/conditions/is_walk", true)
		animation_tree.set("parameters/conditions/is_runnig", false)

func _unhandled_input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("confirm"):
		var actinables = actinables_finder.get_overlapping_areas()
		if actinables.size() > 0:
			actinables[0].action()
			return
func _process(delta: float) -> void:
	# 1. Se um diálogo já está ativo, NÃO FAÇA NADA.
	#    Isso impede que o Player chame a ação de novo.
	if Global.dialog_on == true:
		return

	# 2. Se não há diálogo, verifique o input
	if Input.is_action_just_pressed("confirm"):
		var actinables = actinables_finder.get_overlapping_areas()
		if actinables.size() > 0:
			actinables[0].action()
