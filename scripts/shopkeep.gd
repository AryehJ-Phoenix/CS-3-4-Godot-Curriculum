extends npc


func _physics_process(delta: float) -> void:
	pass



func _on_see_body_entered(body: Node2D) -> void:
	if body is Player:
		$AnimatedSprite2D.play("wave")

func _on_see_body_exited(body: Node2D) -> void:
	if body is Player:
		$AnimatedSprite2D.play("idle")



func _on_talk_body_entered(body: Node2D) -> void:
	if body is Player:
		$AnimatedSprite2D.play("idle")

func _on_talk_body_exited(body: Node2D) -> void:
	if body is Player:
		$AnimatedSprite2D.play("wave")
