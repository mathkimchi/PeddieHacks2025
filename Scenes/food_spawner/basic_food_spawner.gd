class_name BasicFoodSpawner
extends Area2D

# Go to Food -> Load and then choose the food scene, like "apple_tree.tscn"
@export var food: Resource = preload("res://Scenes/food/apple.tscn")

@export var spawn_offset: Vector2 = Vector2(0, 0)

@export var spawn_cooldown: float = 10

var can_spawn = true

func _on_area_entered(body: Node2D) -> void:
	# NOTE: bullet is an area, not a body so _on_body_entered doesn't work
	if !can_spawn:
		# all the code is for spawning, so if we can't spawn, there is no more logic to do
		return

	if body.is_in_group("bullet"): # a bullet hit the spawner, drop a food item
		var food_instance: AbstractFood = food.instantiate()
		food_instance.global_position = self.global_position + spawn_offset
		add_sibling(food_instance)
		
		# >>> Spawn Cooldown >>>
		self.can_spawn = false
		# allow spawn again once cooldown is over
		get_tree().create_timer(spawn_cooldown).timeout.connect(func (): self.can_spawn=true)
		# <<< Spawn Cooldown <<<
		
		print("Hi")
