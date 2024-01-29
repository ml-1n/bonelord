extends Area2D

const MOVE_SPEED = 800.0

var direction

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += direction * MOVE_SPEED * delta
	
# Collision with mobs
func _on_body_entered(body):
	
	if body.name == "knight":
		body.queue_free()
		
	elif body.name == "grek":
		pass
	else:
		queue_free()
		
func shoot(origin, target):
	print(origin)
	print(target)
	position = origin
	direction = origin.direction_to(target)
