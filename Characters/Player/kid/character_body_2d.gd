extends CharacterBody2D

const SPEED = 100.0
const JUMP_VELOCITY = -400.0
var direction : Vector2 = Vector2.ZERO
@onready var animation_tree : AnimationTree = $Animetree
@onready var sprite : AnimatedSprite2D = $Anime

func _ready():
	animation_tree.active = true

	

func _physics_process(delta: float) -> void:
	# Add the gravity
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("ui_left","ui_right","ui_down","ui_up")
	if direction:
		velocity.x = direction.x * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	update_direction()
	update_animation()
	
func update_direction():
	if direction.x > 0:
		sprite.flip_h = false
	if direction.x < 0:
		sprite.flip_h = true
func update_animation():
	animation_tree.set("parameters/move/blend_position",direction.x)
