class_name StateMachine extends Node

@onready var parent : Entity = get_parent()
var states : Array[State] = []

@export var cur_state : State = null

func _ready() -> void:
	for c in get_children():
		if c is State:
			states.append(c)
	if cur_state == null: cur_state = states[0]
	await parent.ready
	cur_state.enter(parent, null)

func main(delta : float):
	if !cur_state: return
	cur_state.main(delta)

func change_state(ns : State):
	cur_state.exit(parent)
	var temp = cur_state
	cur_state = ns
	ns.enter(parent, temp)
