extends State

var t : float = 0

var yyby_node : YybyNode = null

@export var wander : State

func enter(e : Entity, _os : State):
	if e is YybyNode:
		yyby_node = e
	t = randf_range(2, 6)
	yyby_node.animation_player.play("idle")

func main(delta : float):
	t -= delta
	if t <= 0:
		machine.change_state(wander)

func exit(_e : Entity):
	pass
