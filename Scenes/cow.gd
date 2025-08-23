extends CharacterBody2D

# define world constants
@export var gravity = -800

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_on_floor():
		velocity.y -= delta*gravity


	move_and_slide()
