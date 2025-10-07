extends Node

var gotten = false



func _on_body_entered(body: Node2D) -> void:
	if body is Player:
		body.gotten = true
		queue_free()
