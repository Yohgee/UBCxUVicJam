extends State

var t : float = 0

var yyby_node : YybyNode = null

@export var ret_state : State

func enter(e : Entity, _os : State):
	if e is YybyNode:
		yyby_node = e
	t = randf_range(4, 7)
	yyby_node.animation_player.play("alert")

func main(delta : float):
	t -= delta
	if t <= 0:
		machine.change_state(ret_state)

func exit(_e : Entity):
	pass
