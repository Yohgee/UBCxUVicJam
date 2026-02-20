class_name AttackState extends State

@export var attack_time : float = 1.5
@export var attack_node : PackedScene

@export var chase_state : State

var follow_dir : Vector2

var s : Enemy = null

var t : float = 0
var rand_offset : float = 0

func enter(e : Entity, _os : State):
	if e is Enemy:
		s = e
	if s.target == null:
		s.target = s.player
	t = attack_time/ s.haste + 0.1
	var an : AttackNode = attack_node.instantiate()
	an.max_t = attack_time/ s.haste
	an.source = s
	an.dmg += s.strength
	s.add_child(an)
	an.look_at(s.target.global_position)

func main(delta : float):
	t -= delta
	if t <= 0:
		machine.change_state(chase_state)

func exit(_e : Entity):
	pass
