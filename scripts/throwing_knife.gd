extends Area2D

var direction: Vector2
var speed: int = 50
var damage: int = -10

func _process(delta: float) -> void:
	position = speed * direction

func _on_body_entered(body: Node2D) -> void:
	print("knife hit")
	if body != Player:
		if body.has_method("change_health"):
			print("knife YOUCHIE")
			body.change_health(damage)
		queue_free()
