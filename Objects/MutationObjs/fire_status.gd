@abstract class_name StatusEffect extends Node

@export var tick_time : float = 0.5
@export var life_time : float = 2

var source : Entity
#ignore the name its 8am
var s_mut : Mutation
var stack : int = 1:
	set(v):
		if v > stack:
			on_get()
		stack = v
		l_t = life_time
var t : float = 0
var l_t : float = 2

func _ready() -> void:
	l_t = life_time
	on_get()

func set_mut(m : Mutation):
	s_mut = m

func set_source(s : Entity):
	source = s

var old_source: Entity

func set_old_source(s : Entity):
	old_source = s

func _process(delta: float) -> void:
	t -= delta
	l_t -= delta
	if t <= 0:
		t = tick_time
		tick()
	if l_t <= 0:
		if s_mut && source:
			on_remove()
			source.remove_mutation(s_mut)

func on_get():
	pass

func on_remove():
	pass

@abstract func tick()
