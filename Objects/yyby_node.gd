class_name YybyNode extends Area2D

var yyby_res : Yyby
@onready var tail_spr: Sprite2D = $TailSpr
@onready var base_spr: Sprite2D = $BaseSpr
@onready var hat_spr: Sprite2D = $HatSpr

func _ready() -> void:
	if !yyby_res: return
	base_spr.frame = yyby_res.base
	hat_spr.frame = yyby_res.hat
	tail_spr.frame = yyby_res.tail
	if yyby_res.tail in Yyby.TAIL_USE_COL:
		tail_spr.modulate =yyby_res.col
	if yyby_res.hat in Yyby.HAT_USE_COL:
		hat_spr.modulate = yyby_res.col
	base_spr.modulate = yyby_res.col
