class_name BabyUI extends Control

@onready var parent_1: GuyDisplayPanel = $Panel/Parent1
@onready var parent_2: GuyDisplayPanel = $Panel/Parent2
@onready var result: GuyDisplayPanel = $Panel/Result
@onready var confirm_btn: Button = $Button

@export var grid : GuyGridView

signal finished(y : Yyby)

var edit_p1 : bool = true

var guys : Array[Yyby] = []

var active : bool = false

var p1_i : int = 0:
	set(v):
		p1_i = wrapi(v, 0, guys.size())
var p2_i : int = 1:
	set(v):
		p2_i = wrapi(v, 0, guys.size())

func start():
	result.hide()
	active = true
	p1_i = 0
	p2_i = 1
	if guys.is_empty():
		parent_1.set_res(null)
	else:
		parent_1.set_res(guys[0])
	if guys.size() <= 1:
		parent_2.set_res(null)
	else:
		parent_2.set_res(guys[1])
	grid.clicked_guy.connect(set_parent)

func set_parent(p : Yyby):
	if !active: return
	if !visible: return
	grid.hide()
	#this shit is so fucking stupid why did i do this
	if edit_p1:
		parent_1.set_res(p)
	else:
		parent_2.set_res(p)
	confirm_btn.disabled = (parent_1.res == parent_2.res && not (parent_1.res == null && parent_2.res == null)) || (parent_1.res != parent_2.res && (parent_1.res == null || parent_2.res == null))

func end():
	hide()
	grid.clicked_guy.disconnect(set_parent)
	get_tree().paused = false
	finished.emit(result.res)

func _on_button_pressed() -> void:
	if !active: 
		end()
		return
	active = false
	var r : Yyby = Yyby.new()
	if parent_1.res == null:
		r.generate_new()
	else:
		r = Yyby.make_baby(parent_1.res, parent_2.res)
	result.set_res(r)
	result.show()

func _on_p_1x_pressed() -> void:
	if !active: return
	edit_p1 = true
	set_parent(null)

func _on_p_2x_pressed() -> void:
	if !active: return
	edit_p1 = false
	set_parent(null)


func _on_p_2r_pressed() -> void:
	p2_i += 1
	edit_p1 = false
	set_parent(guys[p2_i])


func _on_p_1r_pressed() -> void:
	p1_i += 1
	edit_p1 = true
	set_parent(guys[p1_i])


func _on_p_1l_pressed() -> void:
	p1_i -= 1
	edit_p1 = true
	set_parent(guys[p1_i])


func _on_p_2l_pressed() -> void:
	p2_i -= 1
	edit_p1 = false
	set_parent(guys[p2_i])


func _on_p_1c_pressed() -> void:
	edit_p1 = true
	grid.show()


func _on_p_2c_pressed() -> void:
	edit_p1 = false
	grid.show()
