class_name GuyDisplayPanel extends Panel

var res : Yyby = null

const ABILITY_LABEL = preload("uid://b5ipncdv1hpmo")

@onready var tail_spr: Sprite2D = $Panel/Control/FullSprite/TailSpr
@onready var base_spr: Sprite2D = $Panel/Control/FullSprite/BaseSpr
@onready var hat_spr: Sprite2D = $Panel/Control/FullSprite/HatSpr
@onready var x_spr: Sprite2D = $Panel/Control/FullSprite/Sprite2D
@onready var outline_spr: Sprite2D = $Panel/Control/FullSprite/OutlineSpr
@onready var name_label: Label = $NameLabel
@onready var title_label: Label = $TitleLabel
@onready var panel_container: AbilityVBox = $PanelContainer

func _ready() -> void:
	res = Yyby.new()
	res.generate_new()
	set_res(res)

func set_res(nr : Yyby):
	res = nr
	base_spr.visible = nr != null
	tail_spr.visible = nr != null
	outline_spr.visible = nr != null
	hat_spr.visible = nr != null
	name_label.visible = nr != null
	title_label.visible = nr != null
	panel_container.visible = nr != null
	x_spr.visible = nr == null
	if nr == null:
		return
	name_label.text = nr.y_name
	title_label.text = nr.title
	base_spr.frame = nr.base
	hat_spr.frame = nr.hat
	tail_spr.frame = nr.tail
	if nr.tail in Yyby.TAIL_USE_COL:
		tail_spr.modulate = nr.col
	if nr.hat in Yyby.HAT_USE_COL:
		hat_spr.modulate = nr.col
	base_spr.modulate = nr.col
	panel_container.set_mutations(nr.mutations)
