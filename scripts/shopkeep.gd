extends npc

class_name shopkeep


@export var open: bool = true
@export var buyer: bool = false
@export var return_amount: float = 0.8

var waving = false




func _physics_process(delta: float) -> void:
	if waving and player.coins > 10:
		$AnimatedSprite2D.play("wave")
	else:
		$AnimatedSprite2D.play("idle")



func _on_see_body_entered(body: Node2D) -> void:
	if body is Player:
		waving = true

func _on_see_body_exited(body: Node2D) -> void:
	if body is Player:
		waving = false



func _on_talk_body_entered(body: Node2D) -> void:
	if body is Player:
		waving = false

func _on_talk_body_exited(body: Node2D) -> void:
	if body is Player:
		waving = true
