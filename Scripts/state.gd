@abstract class_name State extends Node

@export var state_name : String = "state"

@onready var machine : StateMachine = get_parent()

@abstract func enter(e : Entity, old_state : State)
@abstract func main(delta : float)
@abstract func exit(e : Entity)
