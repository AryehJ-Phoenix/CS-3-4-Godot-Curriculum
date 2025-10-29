extends npc

class_name shopkeep
@onready var my_inventory: Node2D = $"my inventory"

@onready var q_ui: AnimatedSprite2D = $"q ui"
@onready var e_ui: AnimatedSprite2D = $"u ui"

@export var open: bool = true
@export var buyer: bool = false
@export var return_amount: float = 0.8

var waving = false
var talking: bool = false
var selected_item: int = 0


func _physics_process(delta: float) -> void:
	if waving:
		$AnimatedSprite2D.play("wave")
	else:
		$AnimatedSprite2D.play("idle")
	
	selected_item = my_inventory.selected_item
	
	if talking:
		if Input.is_action_just_pressed("ui_up"):
			my_inventory.selected_item += 1
			my_inventory.print_inventory()
		if Input.is_action_just_pressed("ui_down"):
			my_inventory.selected_item -= 1
			my_inventory.print_inventory()
		if Input.is_action_just_pressed("ui_accept") and player.coins >= my_inventory.inventory.get(selected_item).value:
			if my_inventory.get(my_inventory.selected_item).amount > 0:
				player.coins -= my_inventory.get(my_inventory.selected_item).value
				if my_inventory.get(my_inventory.selected_item).item_name == "throwing_knives":
					player.throwing_knives += 5
					print("BOUGHT KNIVES")
				if my_inventory.get(my_inventory.selected_item).item_name == "potion":
					player.change_health(10)
					print("BOUGHT POTION")
			else:
				print("OUT OF STOCK")
		#if Input.is_action_just_pressed("ui_q") and player.coins >= 10 and my_inventory.get(my_inventory.selected_item).amount > 0:
			#player.coins -= 10
			#player.change_health(20)
		#if Input.is_action_just_pressed("ui_e") and player.coins >= 15 and my_inventory.get(my_inventory.selected_item).amount > 0:
			#player.coins -= 15
			#player.throwing_knives += 5



func _on_see_body_entered(body: Node2D) -> void:
	if body is Player:
		waving = true

func _on_see_body_exited(body: Node2D) -> void:
	if body is Player:
		waving = false



func _on_talk_body_entered(body: Node2D) -> void:
	if body is Player:
		waving = false
		talking = true
		#var number = 0
		#for x in my_inventory:
			#print(my_inventory.get(number).item_name)
			#number += 1
		#
		#q_ui.visible = true
		#e_ui.visible = true

func _on_talk_body_exited(body: Node2D) -> void:
	if body is Player:
		talking = false
		waving = true
		
		#q_ui.visible = false
		#e_ui.visible = false
