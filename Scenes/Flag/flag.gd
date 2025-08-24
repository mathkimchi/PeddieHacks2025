extends Node2D
@export var next = "Filler"


func _process(delta: float) -> void:
	for body in $Area2D.get_overlapping_bodies():#checks if contacting anything
		if body.is_in_group("player"):#checks if it is player
			Transition_Player.transition_level(next)#goes to whatever level you set for the variable
