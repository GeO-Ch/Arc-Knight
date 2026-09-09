extends CanvasLayer

signal start_game


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()

func show_game_over():
	show_message("YOU DIED")
	
	# Wait until the MessageTimer has counted down.
	yield($MessageTimer, "timeout")

	$Message.text = "Try again"
	$Message.show()
	
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.text = "Restart"
	$StartButton.show()

func update_score(score):
	$ScoreLabel.text = str(score)
	
	
func _on_StartButton_pressed():
	$StartButton.hide()
	$Message.hide()
	emit_signal("start_game")

func _on_MessageTimer_timeout():
	$Message.hide()
