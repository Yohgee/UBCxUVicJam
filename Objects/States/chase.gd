class_name ChaseState extends State

@export var chase_range : float = 64
@export var chase_speed : float = 80

@export var atk_state : State

var follow_dir : Vector2

var s : Enemy = null

var rand_t : float = 0
var rand_offset : float = 0

func enter(e : Entity, _os : State):
	if e is Enemy:
		s = e
	s.target = s.player

func main(delta : float):
	rand_t -= delta
	if rand_t <= 0:
		rand_t = randf_range(0.3, 1.3)
		rand_offset = randf_range(-PI/6, PI/6)
	if s.target == null:
		s.target = s.player
	var dir := s.global_position.direction_to(s.target.global_position).rotated(rand_offset)
	s.sprite_2d.flip_h = dir.x < 0
	s.global_position += dir * delta * chase_speed * s.agility
	if s.global_position.distance_to(s.target.global_position) <= chase_range:
		machine.change_state(atk_state)
	

func exit(_e : Entity):
	pass


func _on_retarget_area_entered(area: Area2D) -> void:
	if machine.cur_state != self: return
	if !s: return
	if area is YybyNode || area is Player:
		s.target = area
