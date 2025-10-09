extends Area2D

@export var child: AnimatableBody2D = null
var speed: int
var flipped: bool = false


func _on_body_entered(body: Node2D) -> void:
	if flipped == true:
		speed = -1
		flipped = false
	elif flipped == false:
		speed = 1
		flipped = trueaaaaaaaaaaaaa
	print(speed)
	if body is Player:
		$AnimatedSprite2D.play("default",speed)
		child.lever(speed)
