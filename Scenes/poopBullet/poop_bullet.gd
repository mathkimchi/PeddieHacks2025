extends Area2D

@export
var SPEED = 300
@export
var RANGE = 2000

var traveled_distance = 0

func _physics_process(delta: float) -> void:
	var direction = Vector2.RIGHT.rotated(self.global_rotation)
	position += delta * SPEED * direction
	
	traveled_distance += delta * SPEED
	if traveled_distance > RANGE:
		queue_free() # self destruct


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("cow"):
		#body.take_damage(25)
		body.hit_with_bullet()
		
		# >>> Play cow's damaged sound >>>
		const SOUND_PLAYER = preload("res://Scenes/temp_audio.tscn")
		const SHOOT_SOUND = preload("res://Assets/SoundEffects/compressed/moo (cow damaged).wav")
		var sound_player_instance = SOUND_PLAYER.instantiate()
		sound_player_instance.global_position = self.global_position
		sound_player_instance.stream = SHOOT_SOUND
		get_tree().root.add_child(sound_player_instance)
		# <<< Play cow's damaged sound <<<
		
		self.queue_free() # self destruct the bullet
	pass
