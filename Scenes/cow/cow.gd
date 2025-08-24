extends CharacterBody2D

@export var active_radius = 400.0

@onready var player: Player = get_node("/root/World/Player")

# define world constants to be the same as the players'
@onready var gravity = player.gravity
@onready var speed = player.speed
@onready var jump = player.jump

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func apply_gravity(delta: float):
		if !is_on_floor():
			velocity.y -= delta*gravity
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if player.global_position.distance_to(self.global_position) > active_radius:
		# player is outside our active radius so we can be inactive
		
		## still apply gravity though, since it is weird to have the cow freeze mid-jump
		#apply_gravity(delta)

		return
	
	# >>> Enemy Movement AI >>>
	self.velocity.x = speed * sign(player.global_position.x - self.global_position.x)
	if player.global_position.y < self.global_position.y and self.is_on_floor():
		# NOTE: with the on floor check, this is a jumping enemy but without, it can be a flapping enemy
		# NOTE: up is -y, down is +y
		# player (target) is above, so jump/fly like flappy bird
		velocity.y -= jump
	# <<< Enemy Movement AI <<<
	
	# >>> Apply Movement Physics >>>
	apply_gravity(delta)
	move_and_slide()
	# <<< Apply Movement Physics <<<
