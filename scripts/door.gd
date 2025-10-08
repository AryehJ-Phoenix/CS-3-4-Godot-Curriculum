extends AnimatableBody2D

@onready var player: Player = %Player


func _ready() -> void:
	$AnimatedSprite2D.frame = 0


func _on_open_body_entered(body: Node2D) -> void:
	if body == player:
		if player.keys > 0:
			player.keys -= 1
			collision_layer = 100
			$Open.collision_mask = 1000
			$AnimatedSprite2D.frame = 2
		else:
			print("Door requires key")
