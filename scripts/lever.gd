extends Area2D

@export var child: AnimatableBody2D = null
var speed: int = 1
var flipped: bool = false


func _on_body_entered(body: Node2D) -> void:
	print(speed)
	if body is Player:
		$AnimatedSprite2D.play("default",speed,flipped)
		child.lever(speed)
		if flipped == false:
			speed = 1
			flipped = true
		elif flipped == true:
			speed = -1
			flipped = false
