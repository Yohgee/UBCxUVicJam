extends State

var t : float = 0

var yyby_node : YybyNode = null

@export var ret_state : State
var follow_dir : Vector2

var rand_fp : Vector2

func enter(e : Entity, _os : State):
	if e is YybyNode:
		yyby_node = e
	t = randf_range(3, 6)
	rand_fp = yyby_node.follow_point + (Vector2.RIGHT * randf() * yyby_node.fp_r).rotated(randf_range(0, 2* PI))
	follow_dir = rand_fp - e.global_position
	follow_dir = follow_dir.normalized()
	yyby_node.full_sprite.scale.x = -follow_dir.x/abs(follow_dir.x)
	yyby_node.animation_player.play("walk")

func main(delta : float):
	follow_dir = rand_fp - yyby_node.global_position
	follow_dir = follow_dir.normalized()
	yyby_node.position += follow_dir * Yyby.BASE_SPEED * delta * yyby_node.agility
	if yyby_node.global_position.distance_to(rand_fp) < 8: 
		machine.change_state(ret_state)
	t -= delta
	if t <= 0:
		machine.change_state(ret_state)

func exit(_e : Entity):
	pass
