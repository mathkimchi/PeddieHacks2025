class_name TempAUdio
extends AudioStreamPlayer2D

# Temp Audio starts playing its audio the moment it is made and then deletes itself once the sound stops

func _ready() -> void:
	# start playing the moment it is made
	play()

func _on_finished():
	# remove after finishing
	queue_free()
