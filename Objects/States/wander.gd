extends State

var t : float = 0

var yyby_node : YybyNode = null

var ret_state : State
var wander_dir : Vector2

func enter(e : Entity, os : State):
	ret_state = os
	if e is YybyNode:
		yyby_node = e
	t = randf_range(0.5, 3)
	wander_dir = Vector2(randf() - 0.5, randf() - 0.5)
	wander_dir = wander_dir.normalized()
	yyby_node.full_sprite.scale.x = -wander_dir.x/abs(wander_dir.x)
	yyby_node.animation_player.play("walk")

func main(delta : float):
	yyby_node.position += wander_dir * Yyby.BASE_SPEED/2 * delta
	t -= delta
	if t <= 0:
		machine.change_state(ret_state)

func exit(_e : Entity):
	pass
