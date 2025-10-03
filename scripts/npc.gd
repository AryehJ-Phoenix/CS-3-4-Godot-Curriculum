extends CharacterBody2D
class_name npc

@onready var player: Player = %Player

@export var health : int = 10
@export var speed : int = 100
@export var is_hostile : bool = false
@export var move_points : Array[Vector2] = []
@export var move_point : int = 0
@export var dialogue : Array[String] = []
@export var inventory : Array[String] = []
@export var inventory_drop : int = 0
#@export var state
@export var type : String = ""
@export var target : Vector2
@export var damage: int = -20

var damage_cooldown: float = 0.5
var can_damage: bool = true
var direction = null

func _ready() -> void:
	
	pass

func _physics_process(delta: float) -> void:
	movement(delta)
	move_and_slide()
	pass
	

func _on_detection_radius_body_entered(_body: Node2D) -> void:
	if _body == player:
		is_hostile = true


func _on_detection_radius_body_exited(_body: Node2D) -> void:
	if _body == player:
		is_hostile = false



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


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body == player and can_damage:
		if player.has_method("change_health"):
			player.change_health(damage)
		
		can_damage = false
		get_tree().create_timer(damage_cooldown).timeout.connect(_reset_damage_cooldown)

func _reset_damage_cooldown():
	can_damage = true
