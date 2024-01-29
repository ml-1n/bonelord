extends CharacterBody2D

const MOVE_SPEED = 1000.0
const DASH_MULTIPLIER = 100

var move_direction
var move_amount

var sprite
var projectile_type
var projectile_origin


func _ready():
	sprite = $AnimatedSprite2D
	projectile_origin = $Marker2D
	projectile_type = load("res://entities/projectile_skull.tscn")
	
	#if Input.mouse_mode != Input.MOUSE_MODE_CAPTURED:
	#	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	

func _input(event):
	
	#if event is InputEventMouseButton:
		#if Input.mouse_mode == Input.MOUSE_MODE_VISIBLE:
			#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			#
		if event.is_action_pressed("action_shoot"):
			print("Shooting")
			shoot()
				
	#elif event.is_action_pressed("ui_cancel"):
		#Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		

		
func _physics_process(delta):

	# Get movement vector if any
	move_direction = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	
	
	if move_direction && Input.is_action_just_pressed("action_dash"):
		velocity.x = move_direction.x * (DASH_MULTIPLIER * MOVE_SPEED) * delta
		velocity.y = move_direction.y * (DASH_MULTIPLIER * MOVE_SPEED) * delta
		sprite.play("dash")
		
	elif move_direction:
		velocity.x = move_direction.x * MOVE_SPEED * delta
		velocity.y = move_direction.y * MOVE_SPEED * delta
		sprite.play("move")
		
	else:
		velocity.x = 0
		velocity.y = 0
		sprite.play("idle")

	move_and_slide()

func shoot():
	var projectile = projectile_type.instantiate()
	call_deferred("add_child", projectile)
	
	print("Shooting projectile")
	projectile.shoot(projectile_origin.global_position, get_global_mouse_position())
	
		
		
		
	
