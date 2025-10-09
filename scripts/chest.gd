extends Area2D

@onready var player: Player = %Player
@export var spread: int = 50
@export var silver_chance: int = 20
@export var gold_chance: int = 10
@export var particles: Node2D
@export var min_amount: int = 5
@export var max_amount: int = 10
var coin = preload("res://scenes/coin.tscn")
var rng = RandomNumberGenerator.new()

func _ready() -> void:
	silver_chance += gold_chance
	if silver_chance > 100:
		silver_chance = 100 - gold_chance
	print(silver_chance)

func _on_body_entered(body: Node2D) -> void:
	if body == player:
		if player.keys > 0:
			player.keys -= 1
			$AnimatedSprite2D.play()
			collision_mask = 100
			summon_coins(rng.randi_range(min_amount,max_amount))
			particles.global_position = global_position
			particles.explode()
		else:
			print("chest requires key")

func summon_coins(amount):
	amount -= 1
	
	var new_coin = coin.instantiate()
	new_coin.position = Vector2(randf_range(position.x - spread,position.x + spread),randf_range(position.y - spread,position.y + spread))
	
	
	var coin_type = rng.randi_range(0,100)
	
	if coin_type <= gold_chance:
		new_coin.label = "gold"
	elif coin_type > gold_chance and coin_type <= silver_chance:
		new_coin.label = "silver"
	else:
		new_coin.label = "copper"
	
	get_parent().add_child(new_coin)
	
	if amount > 0:
		summon_coins(amount)
