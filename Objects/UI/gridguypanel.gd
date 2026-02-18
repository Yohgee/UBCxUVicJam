class_name GridGuyPanel extends Panel
@onready var base_spr: Sprite2D = $Control/FullSprite/BaseSpr
@onready var tail_spr: Sprite2D = $Control/FullSprite/TailSpr
@onready var outline_spr: Sprite2D = $Control/FullSprite/OutlineSpr
@onready var hat_spr: Sprite2D = $Control/FullSprite/HatSpr
@onready var x_spr : Sprite2D = $Control/FullSprite/Sprite2D
@onready var full_panel: GuyDisplayPanel = $Panel

var res : Resource

var index : int = 0

signal get_mouse(i : int)

func set_res(nr : Yyby):
	res = nr
	base_spr.visible = nr != null
	tail_spr.visible = nr != null
	outline_spr.visible = nr != null
	hat_spr.visible = nr != null
	x_spr.visible = nr == null
	if nr == null:
		return
	base_spr.frame = nr.base
	hat_spr.frame = nr.hat
	tail_spr.frame = nr.tail
	if nr.tail in Yyby.TAIL_USE_COL:
		tail_spr.modulate = nr.col
	if nr.hat in Yyby.HAT_USE_COL:
		hat_spr.modulate = nr.col
	base_spr.modulate = nr.col
	full_panel.set_res(nr)
	full_panel.hide()


func _on_mouse_entered() -> void:
	full_panel.show()
	get_mouse.emit(index)


func _on_mouse_exited() -> void:
	full_panel.hide()
	get_mouse.emit(index)
