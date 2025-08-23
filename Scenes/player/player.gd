extends CharacterBody2D

# define world constants
@export var speed = 200
@export var gravity = -800
@export var jump = 500

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

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
	
func eat(food_group: AbstractFood.FoodGroup, nutritional_value: float):
	print("Fed %s %s" % [food_group, nutritional_value])
