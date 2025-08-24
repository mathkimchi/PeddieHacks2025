extends Node2D

func _process(delta: float) -> void:
	if $VideoStreamPlayer.is_playing() == false:
		get_tree().change_scene_to_file("res://Scenes/tutorial_World.tscn")
