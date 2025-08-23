extends Node2D
@onready var poopBullet = preload("res://Scenes/poopBullet/poopBullet.tscn") #@ symbol modifies onready to ensure it is loaded
var bullet #stores the temp bullet object

func shoot():
	if Input.is_action_just_pressed('shoot'):
		bullet = poopBullet.instantiate() # just assignment 
		add_child(bullet) #adds the bullet as a child  
		#THIS DOESNT WORK YET BC IT IS ATTACHED TO PLAYER AND NOT WORLD
	
func _physics_process(delta: float) -> void:
	shoot()
