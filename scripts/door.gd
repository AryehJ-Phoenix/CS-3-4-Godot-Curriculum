extends AnimatableBody2D

@onready var player: Player = %Player
@export var condition: String = "key"
@export var open: String = "right"

func _ready() -> void:
	$AnimatedSprite2D.frame = 5
	
	if open == "left":
		$AnimatedSprite2D.flip_h = true
	else:
		$AnimatedSprite2D.flip_h = false
	
	if condition != "key" and condition != "lever":
		condition = "key"


func _on_open_body_entered(body: Node2D) -> void:
	if body == player:
		if condition == "key":
			if player.keys > 0:
				player.keys -= 1
				collision_layer = 100
				$Open.collision_mask = 1000
				$AnimatedSprite2D.frame = 1
			else:
				print("Door requires key")

func lever(value):
	if condition == "lever":
		if value == 1:
			collision_layer = 100
			$Open.collision_mask = 1000
			$AnimatedSprite2D.frame = 1
		if value == -1:
			collision_layer = 1
			$Open.collision_mask = 1
			$AnimatedSprite2D.frame = 5
