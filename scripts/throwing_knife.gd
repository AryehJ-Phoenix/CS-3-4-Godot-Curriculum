extends Area2D

var direction: Vector2
var speed: int = 3
var damage: int = -10

func _ready() -> void:
	look_at(get_global_mouse_position())

func _process(delta: float) -> void:
	position += speed * direction

func _on_body_entered(body: Node2D) -> void:
	if body is not Player:
		if body.has_method("change_health"):
			print("knife YOUCHIE")
			body.change_health(damage)
		queue_free()
