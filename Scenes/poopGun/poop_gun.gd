extends Node2D
@onready var poopBullet = preload("res://Scenes/poopBullet/poopBullet.tscn") # @ symbol modifies onready to ensure it is loaded
var bullet # stores the temp bullet object

func shoot(event):
	bullet = poopBullet.instantiate() # just assignment
	# add the bullet under the world instead of player to not be relative to player position
	get_node("/root/World").add_child(bullet) #NOTE only works if node for the level is called "World"
	
	# make bullet shoot from the gun location and in the direction of mouse point from player
	bullet.global_position = self.global_position
	bullet.global_rotation = self.get_global_transform_with_canvas().get_origin().direction_to(event.position).angle()
	
	# >>> Play shoot sound >>>
	const SOUND_PLAYER = preload("res://Scenes/temp_audio.tscn")
	const SHOOT_SOUND = preload("res://Assets/SoundEffects/compressed/shoot poop.wav")
	var sound_player_instance = SOUND_PLAYER.instantiate()
	sound_player_instance.global_position = self.global_position
	sound_player_instance.stream = SHOOT_SOUND
	get_tree().root.add_child(sound_player_instance)
	# <<< Play shoot sound <<<

func _input(event) -> void:
	if event.is_action_pressed("shoot"):
		shoot(event)
