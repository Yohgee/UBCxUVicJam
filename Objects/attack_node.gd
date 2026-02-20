class_name AttackNode extends Node2D
@onready var collision_shape_2d: CollisionShape2D = $Area2D/CollisionShape2D
@onready var time_spr: Sprite2D = $Area2D/TimeSpr

@export var max_t : float = 1.5
var t : float = 0.001
var done : bool = false
@export var dmg : float = 1.0
var source : Entity

func _ready() -> void:
	t = max_t

func _process(delta: float) -> void:
	if done: return
	t -= delta
	time_spr.scale = Vector2(1,1) * (1 - t/max_t)
	if t <= 0:
		done = true
		pulse_col()

func pulse_col():
	collision_shape_2d.set_deferred("disabled", false)
	await get_tree().create_timer(0.1).timeout
	collision_shape_2d.set_deferred("disabled", true)
	if done:
		queue_free()


func _on_area_2d_area_entered(area: Area2D) -> void:
	if area is Entity:
		area.take_damage(source, dmg)
