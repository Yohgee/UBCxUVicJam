class_name Bullet extends Area2D

var source : Entity

@export var damage : float = 1
@export var lifetime : float = 10
@export var pierce : int = 1
@export var rotate_to_vel : bool = false

var velocity : Vector2 = Vector2.ZERO
var acceleration : Vector2 = Vector2.ZERO

func _ready() -> void:
	if !area_entered.is_connected(on_hit):
		area_entered.connect(on_hit)

func _process(delta: float) -> void:
	position += velocity * delta
	velocity += acceleration * delta
	if rotate_to_vel:
		rotation = velocity.angle()
	lifetime -= delta
	if lifetime <= 0:
		queue_free()

func on_hit(area : Area2D):
	if area is not Entity: return
	area = area as Entity
	if area == source: return
	
	area.take_damage(source, damage)
	pierce -= 1
	if pierce <= 0:
		queue_free()
