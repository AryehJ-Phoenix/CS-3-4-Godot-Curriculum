extends Node2D


@onready var player: Player = $".."
@onready var label: Label = $Label


func _process(delta: float) -> void:
	if player != null:
		label.text = str(player.coins)
