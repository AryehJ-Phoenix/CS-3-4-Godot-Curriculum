extends Node2D

@export var my_inventory: Array[inventory_item]

var selected_item: int = 0

func _process(delta: float) -> void:
	pass

func print_inventory():
	if selected_item >= my_inventory.size():
		selected_item = 0
	if selected_item < 0:
		selected_item = my_inventory.size() - 1
	if my_inventory.size() != 0:
		print("ITEM: ", my_inventory.get(selected_item).item_name)
		print("DESCRIPTION: ", my_inventory.get(selected_item).description)
		print("VALUE: ", my_inventory.get(selected_item).value)
		print("AMOUNT: ", my_inventory.get(selected_item).amount)

func add_item():
	pass

func remove_item():
	pass
