#THIS IS A GLOBAL SCRIPT
extends Node2D


func transition_level(file_path: String): #Global function to play transition then swap to next level
	get_tree().change_scene_to_file("res://Scenes/Transition_Player.tscn") #plays this scene and the cutscene for 3 seconds
	$cutSceneCam.make_current() #makes the camera for the cutscene the main camera
	$Transition_Stream.play()
	
	await get_tree().create_timer(3).timeout
	
	get_tree().change_scene_to_file(file_path) #moves you to the level
	
