class_name Player
extends CharacterBody2D

# define world constants
@export var speed = 200
@export var gravity = -800
@export var jump = 500

@export var max_nutrient = 100
@export var low_threshold = 30 # when a nutrient is below the low_threshold, there will be a penalty
@export var nutrient_decay = 1 # how much each nutrient decreases per second

var nutrients = [50, 50, 50, 50] # corresponds to grain, fruit, veggie, protein respectively

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
	
	# >>> Food Logic >>>
	for i in len(nutrients):
		nutrients[i] -= delta * nutrient_decay
	
	print("Nutrients: %s" % [nutrients])
	# <<< Food Logic <<<
	
func eat(food_group: AbstractFood.FoodGroup, nutritional_value: float):
	print("Ate %s %s" % [food_group, nutritional_value])
	nutrients[food_group] += nutritional_value
