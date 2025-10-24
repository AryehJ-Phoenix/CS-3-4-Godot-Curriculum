extends npc

@onready var sprite: Sprite2D = $Sprite2D


var knockback_direction: Vector2
var damage_cooldown: float = 0.2
var can_damage: bool = true
var stuck_check: bool = false
var stuck_timer: float = 0.5


func _ready() -> void:
	super._ready()



func _physics_process(delta: float) -> void:
	if stuck_check:
		stuck_timer -= delta
	if !stuck_check:
		stuck_timer = 0.5
	
	if knockback_cooldown > 0.0:
		velocity = knockback
		knockback_cooldown -= delta
		if knockback_cooldown <= 0.0:
			knockback = Vector2.ZERO
	else:
		super.movement(delta)
	
	if stuck_timer > 0 and can_damage:
		move_and_slide()
	


func _on_detection_radius_body_entered(body: Node2D) -> void:
	super._on_detection_radius_body_entered(body)
	if body is Player:
		is_hostile = true


func _on_detection_radius_body_exited(body: Node2D) -> void:
	super._on_detection_radius_body_exited(body)
	if body is Player:
		is_hostile = false


func _on_hurt_box_body_entered(body: Node2D) -> void:
	if body == player:
		stuck_check = true
		if can_damage:
			if body.has_method("change_health"):
				body.change_health(damage)
			
			knockback_direction = (body.global_position - global_position).normalized()
			body.apply_knockback(knockback_direction, 500.0, 0.12)
			
			can_damage = false
			get_tree().create_timer(damage_cooldown).timeout.connect(_reset_damage_cooldown)

func _on_hurt_box_body_exited(body: Node2D) -> void:
	if body == player:
		stuck_check = false


func _reset_damage_cooldown():
	can_damage = true


func die():
	print("enemy killed")
	queue_free()


func apply_knockback(direction: Vector2, strength: float, duration: float) -> void:
	knockback = direction * strength
	knockback_cooldown = duration
