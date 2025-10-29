extends Node2D

@export var inventory: Array[inventory_item]

var selected_item: int = 0

func _process(_delta: float) -> void:
	pass

func print_inventory():
	if selected_item >= inventory.size():
		selected_item = 0
	if selected_item < 0:
		selected_item = inventory.size() - 1
	if inventory.size() != 0:
		print("ITEM: ", inventory.get(selected_item).item_name)
		print("DESCRIPTION: ", inventory.get(selected_item).description)
		print("VALUE: ", inventory.get(selected_item).value)
		print("AMOUNT: ", inventory.get(selected_item).amount)

func add_item():
	pass

func remove_item():
	pass
