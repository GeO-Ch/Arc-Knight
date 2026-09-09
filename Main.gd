extends Node


export(PackedScene) var mob_scene
var score
# var high_score
# var save_path = "user://savegame.save"


# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()


func game_over():
	
	$ScoreTimer.stop()
	# save_high_score(score)
	$MobTimer.stop()
	$HUD.show_game_over()


func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$HUD.update_score(score)
	get_tree().call_group("spells", "queue_free")
	
func _on_ScoreTimer_timeout():
	score += 10
	$HUD.update_score(score)
	
func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()


func _on_MobTimer_timeout():
	# Create a new instance of the Mob scene.
	var mob = mob_scene.instance()

	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2

	# Set the mob's position to a random location.
	mob.position = mob_spawn_location.position

	# Add some randomness to the direction.
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)
	

# Save new high score
#func save_high_score(score):
#	var save_game = File.new()
#	
#	if save_game.file_exists(save_path):
#		save_game.open(save_path, File.READ)
#		high_score = save_game.get_var()
#		save_game.close()
#		
#		if score > high_score:
#			high_score = score
#			save_game.open(save_path, File.WRITE)
#			save_game.store_var(high_score)
#			save_game.close()
#	else:
#		save_game.open(save_path, File.WRITE)
#		save_game.store_var(score)
#		save_game.close()
