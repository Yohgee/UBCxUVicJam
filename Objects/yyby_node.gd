class_name YybyNode extends Entity

var yyby_res : Yyby
@onready var tail_spr: Sprite2D = $FullSprite/TailSpr
@onready var base_spr: Sprite2D = $FullSprite/BaseSpr
@onready var hat_spr: Sprite2D = $FullSprite/HatSpr
@onready var state_machine: StateMachine = $StateMachine
@onready var full_sprite: Node2D = $FullSprite
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var follow_point : Vector2 = Vector2.ZERO
var fp_r : float = 128

func _ready() -> void:
	if !yyby_res: return
	base_spr.frame = yyby_res.base
	hat_spr.frame = yyby_res.hat
	tail_spr.frame = yyby_res.tail
	if yyby_res.tail in Yyby.TAIL_USE_COL:
		tail_spr.modulate = yyby_res.col
	if yyby_res.hat in Yyby.HAT_USE_COL:
		hat_spr.modulate = yyby_res.col
	base_spr.modulate = yyby_res.col

func _physics_process(delta: float) -> void:
	state_machine.main(delta)

func get_command(p : Vector2, r : float = 128):
	follow_point = p
	fp_r = r
	state_machine.change_state($StateMachine/Follow)

func get_selected(_selector : Entity):
	state_machine.change_state($StateMachine/Alert)
