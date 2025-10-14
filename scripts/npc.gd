extends CharacterBody2D
class_name npc

@onready var player: Player = %Player

@export var maxHealth : int = 50
@export var speed : int = 100
@export var is_hostile : bool = false
@export var move_points : Array[Vector2] = []
@export var move_point : int = 0
@export var dialogue : Array[String] = []
@export var inventory : Array[String] = []
@export var inventory_drop : int = 0
@export var type : String = ""
@export var target : Vector2
@export var damage: int = -20

var knockback: Vector2 = Vector2.ZERO
var knockback_cooldown: float = 0
var health: int
var direction = null

func _ready() -> void:
	health = maxHealth

func _physics_process(delta: float) -> void:
	if knockback_cooldown > 0.0:
		velocity = knockback
		knockback_cooldown -= delta
		if knockback_cooldown <= 0.0:
			knockback = Vector2.ZERO
	else:
		movement(delta)
	move_and_slide()
	

func _on_detection_radius_body_entered(_body: Node2D) -> void:
	pass


func _on_detection_radius_body_exited(_body: Node2D) -> void:
	pass



func movement(_delta):
	if is_hostile:
		target = player.position
	else:
		target = move_points[move_point]
		if position.distance_to(target)<10:
			move_point+=1
			if move_point > move_points.size()-1:
				move_point = 0
	direction = position.direction_to(target)
	velocity = speed * direction
	
	pass


func change_health(_amount):
	health += _amount
	if health > maxHealth:
		health = maxHealth
		
	elif health < 1:
		die()
		
	print("NPC Health: " + str(health))

func die():
	pass


func apply_knockback(direction: Vector2, strength: float, duration: float) -> void:
	knockback = direction * strength
	knockback_cooldown = duration
