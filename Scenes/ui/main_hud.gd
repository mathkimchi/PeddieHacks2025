extends CanvasLayer

# NOTE: can't call `get_node` statically so we must call it once everything is ready, thus the `@onready`
@onready
var player: Player = get_node("/root/World/Player")

func _ready() -> void:
	get_node("%GrainBar").max_value = player.max_nutrient

func _process(delta: float) -> void:
	get_node("%GrainBar").value = player.nutrients[AbstractFood.FoodGroup.GRAIN]
	get_node("%FruitBar").value = player.nutrients[AbstractFood.FoodGroup.FRUIT]
	get_node("%VegetableBar").value = player.nutrients[AbstractFood.FoodGroup.VEGETABLE]
	get_node("%ProteinBar").value = player.nutrients[AbstractFood.FoodGroup.PROTEIN]
