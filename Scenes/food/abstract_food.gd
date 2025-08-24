class_name AbstractFood
extends Area2D

enum FoodGroup { GRAIN, FRUIT, VEGETABLE, PROTEIN }

static var group_name = "food"

func _ready():
	add_to_group(group_name)

# NOTE: Godot doesn't support tuples, return an array [FoodGroup, float] where the float is nutrition
func get_nutrition():
	push_error("`AbstractFood`'s `get_nutrition` should be implemented by child class and return `[FoodGroup, float]`.")

# NOTE: need to connect implementing object's `body_entered` to this
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		var nutrition = self.get_nutrition()
		body.eat(nutrition[0], nutrition[1])
		
		self.queue_free() # self destruct
