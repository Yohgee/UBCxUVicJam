extends Area2D

const BLOODADDER = preload("uid://b7w6rstpgpmkd")

var effect : Mutation

var source : Entity
var stack : int = 1:
	set(v):
		stack = v + 3


var type : int = 0

func set_source(s : Entity):
	source = s
	effect = BLOODADDER.duplicate()
	effect.set("old_source", s)
	if s == null: return
	if s is Enemy:
		type = 2
	elif s is Player:
		type = 1

var t : float = 2

func _process(delta: float) -> void:
	t -= delta
	if t <= 0:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if type == 0 && area is not Enemy: return
	if type == 2 && area is Enemy: return
	if area == source: return
	if area is Entity:
		for i in stack:
			print(effect.old_source)
			area.get_mutation(effect)
