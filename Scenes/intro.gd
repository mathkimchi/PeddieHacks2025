extends Node2D

func _process(delta: float) -> void:
	if $VideoStreamPlayer.is_playing() == false: #when the intro ends it goes on 
		#Transition_Player.transition_level("res://Scenes/tutorial_World.tscn") #this is a test of transition players
		get_tree().change_scene_to_file("res://Scenes/tutorial_World.tscn") #moves to tutorial level
		
