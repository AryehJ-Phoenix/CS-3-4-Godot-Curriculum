extends npc

class_name shopkeep

@onready var q_ui: AnimatedSprite2D = $"q ui"
@onready var e_ui: AnimatedSprite2D = $"u ui"

@export var open: bool = true
@export var buyer: bool = false
@export var return_amount: float = 0.8

var waving = false
var talking: bool = false



func _physics_process(delta: float) -> void:
	if waving and player.coins > 10:
		$AnimatedSprite2D.play("wave")
	else:
		$AnimatedSprite2D.play("idle")
	
	if talking:
		if Input.is_action_just_pressed("ui_q") and player.coins >= 10:
			player.coins -= 10
			player.change_health(20)
		if Input.is_action_just_pressed("ui_e") and player.coins >= 15:
			player.coins -= 15
			player.throwing_knives += 5



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
		var number = 0
		for x in inventory:
			print(inventory.get(number).item_name)
			number += 1
		
		q_ui.visible = true
		e_ui.visible = true

func _on_talk_body_exited(body: Node2D) -> void:
	if body is Player:
		talking = false
		waving = true
		q_ui.visible = false
		e_ui.visible = false
