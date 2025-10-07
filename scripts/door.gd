extends AnimatableBody2D

@onready var player: Player = %Player

func _ready() -> void:
	$AnimatedSprite2D.frame = 0



#func set_is_open(is_open: bool) -> void:
	#if is_open:
		#$AnimatedSprite2D.frame = 0
		#collision_layer = 1
		#$LightOccluder2D.visible = false
	#else:
		#$AnimatedSprite2D.frame = 1
		#collision_layer = 0
		#$LightOccluder2D.visible = true


func _on_open_body_entered(body: Node2D) -> void:
	open()

func open():
	if player.gotten == true:
		collision_layer = 2000000
		$AnimatedSprite2D.frame = 2
	else:
		print("HAHA U DONT HAVE A KEY!!!!!!!")
