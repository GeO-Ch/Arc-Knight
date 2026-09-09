extends RigidBody2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
