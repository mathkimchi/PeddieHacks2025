class_name BasicFood
extends AbstractFood

# This class is for foods that will have a constant food group and nutrition

@export var food_group: FoodGroup
@export var nutrition: float

func get_nutrition():
	return [food_group, nutrition]
