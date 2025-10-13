extends CharacterBody2D
class_name Player


@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var attack_box: Area2D = $"Attack Box"

@export var move_speed: float = 200.0
@export var maxHealth : int = 100
@export var health : int = maxHealth
@export var coins : int = 0

var attack_direction: Vector2
var knockback_direction: Vector2
var knockback: Vector2 = Vector2.ZERO
var knockback_cooldown: float = 0.0
var facing: Vector2 = Vector2.ZERO
var keys: int = 0
var attacking: bool = false
var attack_timer: float = 0.5
var damage: int = -10

func _ready():
	print("Player is ready!")
	# TODO: Add detailed character info display (Lesson 1)

func _physics_process(delta):
	if knockback_cooldown > 0.0:
		velocity = knockback
		knockback_cooldown -= delta
		if knockback_cooldown <= 0.0:
			knockback = Vector2.ZERO
	else:
		handle_movement()
	
	if Input.is_action_just_pressed("ui_accept") and !attacking:
		attack()
	if attacking:
		attack_timer -= delta
		attack_box.collision_mask = 1
	if !attacking:
		attack_box.collision_mask = 100
		attack_timer = 0.5
	if attack_timer <= 0.4:
		attack_box.collision_mask = 100
	if attack_timer <= 0:
		attacking = false
	
	
	if !attacking:
		move_and_slide()

func handle_movement():
	# Get input direction from arrow keys
	var direction = Vector2.ZERO
	direction.x = Input.get_axis("ui_left", "ui_right")
	direction.y = Input.get_axis("ui_up", "ui_down")
	handle_sprite(direction)
	
	# Normalize diagonal movement to prevent speed boost
	if direction.length() > 0:
		direction = direction.normalized()
	
	# Apply movement using Godot's built-in physics
	velocity = direction * move_speed

# BAD QUICK CODE MAYBE CHANGE
func handle_sprite(direction: Vector2) -> void:
	var prefix: String = "walk"
	if direction == Vector2.ZERO:
		prefix = "idle"
	else:
		facing = direction
	if attacking:
		prefix = "swing"
	
	if facing.y > 0:
		animated_sprite.play(prefix + "_forward")
	elif facing.y < 0:
		animated_sprite.play(prefix + "_backward")
	elif facing.x < 0:
		animated_sprite.play(prefix + "_side")
		animated_sprite.flip_h = true
	elif facing.x > 0:
		animated_sprite.play(prefix + "_side")
		animated_sprite.flip_h = false

func collect_pickup(_type : String, _amount : int):
	if _type == "coin":
		coins += _amount
		print("Coins: " + str(coins))
	elif _type == "health_potion":
		change_health(_amount)
		

# TODO: Add character methods here (Lesson 2)

# - level_up()
# - attack()

func change_health(_amount): 
	health += _amount
	if health > maxHealth:
		health = maxHealth
		
	elif health < 1:
		die()
		
	print("Health: " + str(health))

func die():
	Global.game_world.respawn()
	print("You died!")

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit(0)

func apply_knockback(direction: Vector2, strength: float, duration: float) -> void:
	knockback = direction * strength
	knockback_cooldown = duration

func attack():
	attacking = true
	
	attack_direction = (get_global_mouse_position() - global_position).normalized()
	if attack_direction.x > 0.5:
		attack_direction.x = 1
	
	print(attack_direction)
	
	match facing:
		Vector2(0,1):
			attack_box.rotation_degrees = 90
			attack_box.position = Vector2(0,40)
		Vector2(0,-1):
			attack_box.rotation_degrees = 90
			attack_box.position = Vector2(0,-30)
		Vector2(-1,0):
			attack_box.rotation_degrees = 0
			attack_box.position = Vector2(-30,0)
		Vector2(1,0):
			attack_box.rotation_degrees = 0
			attack_box.position = Vector2(30,0)
		
		Vector2(1,1):
			attack_box.rotation_degrees = 45
			attack_box.position = Vector2(20,30)
		Vector2(1,-1):
			attack_box.rotation_degrees = 135
			attack_box.position = Vector2(20,-20)
		Vector2(-1,1):
			attack_box.rotation_degrees = 135
			attack_box.position = Vector2(-20,30)
		Vector2(-1,-1):
			attack_box.rotation_degrees = 45
			attack_box.position = Vector2(-20,-20)


func _on_attack_box_body_entered(body: Node2D) -> void:
	if body is npc:
		body.change_health(damage)
		knockback_direction = (body.global_position - global_position).normalized()
		body.apply_knockback(knockback_direction, 300.0, 0.12)
