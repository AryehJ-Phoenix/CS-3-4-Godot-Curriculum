extends Node2D
class_name GameWorld

# Player reference - our main character
@onready var player = $Player

# Test objects for character methods
@onready var spike = $Spike
@onready var health_potion = $HealthPotion

func _ready():
	pass


func respawn():
	player.velocity = Vector2(0,0)
	player.global_position = Vector2(0,0)
	player.health = player.maxHealth
	player.coins /= 2

# TODO: Add game management methods here (Future lessons)
# - spawn_enemy()
# - handle_combat()  
# - check_game_over()
