extends CharacterBody2D

const MOVE_SPEED = 200.0
const DASH_MULTIPLIER = 10

var move_direction
var move_amount

var sprite

func _ready():
	sprite = $AnimatedSprite2D

func _physics_process(delta):

	# Get movement vector if any
	move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	if move_direction && Input.is_action_just_pressed("action_dash"):
		velocity.x = move_direction.x * (DASH_MULTIPLIER * MOVE_SPEED)
		velocity.y = move_direction.y * (DASH_MULTIPLIER * MOVE_SPEED)
		sprite.play("dash")
		
	elif move_direction:
		velocity.x = move_direction.x * MOVE_SPEED
		velocity.y = move_direction.y * MOVE_SPEED
		sprite.play("move")
		
	else:
		velocity.x = 0
		velocity.y = 0
		sprite.play("idle")

	move_and_slide()
