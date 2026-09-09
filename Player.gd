extends Area2D
signal hit


var speed = 300 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var velocity = Vector2.ZERO # The player's movement vector.
var last_direction = "idle_s"


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Movement Input
	velocity.x = int(Input.is_action_pressed("run_e")) - int(Input.is_action_pressed("run_w"))
	velocity.y = int(Input.is_action_pressed("run_s")) - int(Input.is_action_pressed("run_n"))
	
	# Animation logic based on velocity
	if velocity.x > 0 and velocity.y > 0:
		$AnimatedSprite.animation = "run_se"
		last_direction = "idle_se"
	elif velocity.x > 0 and velocity.y < 0:
		$AnimatedSprite.animation = "run_ne"
		last_direction = "idle_ne"
	elif velocity.x < 0 and velocity.y > 0:
		$AnimatedSprite.animation = "run_sw"
		last_direction = "idle_sw"
	elif velocity.x < 0 and velocity.y < 0:
		$AnimatedSprite.animation = "run_nw"
		last_direction = "idle_nw"
	elif velocity.x > 0:
		$AnimatedSprite.animation = "run_e"
		last_direction = "idle_e"
	elif velocity.x < 0:
		$AnimatedSprite.animation = "run_w"
		last_direction = "idle_w"
	elif velocity.y > 0:
		$AnimatedSprite.animation = "run_s"
		last_direction = "idle_s"
	elif velocity.y < 0:
		$AnimatedSprite.animation = "run_n"
		last_direction = "idle_n"

	if velocity.length() > 0: # on movement
	 velocity = velocity.normalized() * speed # apply consistent movement speed
	else:
	 $AnimatedSprite.animation = last_direction
	
	# apply movement
	position += velocity * delta
	
	# Contain in screen
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	# Always play an animation
	$AnimatedSprite.play()


func _on_Player_body_entered(_body):
	hide() # Player disappears after being hit.
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false
