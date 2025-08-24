class_name Player
extends CharacterBody2D

# define world constants
@export var speed = 200
@export var gravity = -800
@export var jump = 500

@export var max_nutrient = 100
@export var low_threshold = 30 # when a nutrient is below the low_threshold, there will be a penalty
@export var nutrient_decay = 1 # how much each nutrient decreases per second

@export
var MAX_HEALTH = 100
var health = MAX_HEALTH

@export
var ENEMY_DPS = 10

var nutrients = [50, 50, 50, 50] # corresponds to grain, fruit, veggie, protein respectively

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	%HealthBar.max_value = MAX_HEALTH

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	# >>> Movement Logic >>>
	if !is_on_floor():
		velocity.y -= delta * gravity
	else:
		if Input.is_action_pressed("ui_up"):
			velocity.y = -jump

	var h_direction = Input.get_axis("ui_left", "ui_right")
	
	velocity.x = speed * h_direction

	move_and_slide()
	# <<< Movement Logic <<<
	
	# >>> Food Logic >>>
	for i in len(nutrients):
		nutrients[i] -= delta * nutrient_decay
	#print("Nutrients: %s" % [nutrients])
	# <<< Food Logic <<<
	
	# If player is touching an enemy, then damage player slowly
	for body in %DamageArea.get_overlapping_bodies():
		if body.is_in_group("cow"):
			self.take_damage(delta * ENEMY_DPS)
	
	# update health bar
	%HealthBar.value = health
	
func eat(food_group: AbstractFood.FoodGroup, nutritional_value: float):
	print("Ate %s %s" % [food_group, nutritional_value])
	nutrients[food_group] += nutritional_value
	
	# >>> Play eat sound >>>
	const SOUND_PLAYER = preload("res://Scenes/temp_audio.tscn")
	const SHOOT_SOUND = preload("res://Assets/SoundEffects/compressed/eat.wav")
	var sound_player_instance = SOUND_PLAYER.instantiate()
	sound_player_instance.global_position = self.global_position
	sound_player_instance.stream = SHOOT_SOUND
	get_tree().root.add_child(sound_player_instance)
	# <<< Play eat sound <<<

func take_damage(damage: float):
	self.health -= damage
	
	# >>> Play player damage sound >>>
	# Don't use TEMP_AUDIO player, because we want this to restart every time
	if !%DamageAudioSpeaker.playing:
		const SHOOT_SOUND = preload("res://Assets/SoundEffects/compressed/ouchies (player damaged).wav")
		%DamageAudioSpeaker.stream = SHOOT_SOUND
		%DamageAudioSpeaker.play()
	# <<< Play player damage sound <<<
	
	if self.health < 0:
		death_screen()

# called on player death
func death_screen():
	get_tree().change_scene_to_file.call_deferred("res://Scenes/death_screen.tscn")
	get_tree().current_scene.free()
