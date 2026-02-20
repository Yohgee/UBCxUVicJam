extends Area2D

var source : Entity
var stack : int = 1

@export var dmg : float = 3

var stren : int = 0
var type : int = 0

func set_source(s : Entity):
	source = s
	if s == null: return
	stren = s.strength
	if s is Enemy:
		type = 2
	elif s is Player:
		type = 1

var t : float = 0.3

func _process(delta: float) -> void:
	scale += Vector2(1,1) * delta * max(3.0, 2 + stack/2.0)
	t -= delta
	if t <= 0:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if type == 0 && area is not Enemy: return
	if type == 2 && area is Enemy: return
	if area == source: return
	if area is Entity:
		area.take_damage(source, dmg * stack + stren)
