extends Node2D
@onready var poopBullet = preload("res://Scenes/poopBullet/poopBullet.tscn") #@ symbol modifies onready to ensure it is loaded
var bullet #stores the temp bullet object

func shoot():
	if Input.is_action_just_pressed('shoot'):
		bullet = poopBullet.instantiate() # just assignment
		# add the bullet under the world instead of player to not be relative to player position
		get_node("/root/World").add_child(bullet)
		bullet.global_position = self.global_position

func _physics_process(delta: float) -> void:
	shoot()
