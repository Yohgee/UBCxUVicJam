class_name GuyGridView extends Control

@onready var grid_container: GridContainer = $GridContainer
const GRIDGUYPANEL = preload("uid://d0aeqmn0jq3m4")
const PAGE_SIZE = 17*8

var guys : Array[Yyby] = []
var page : int = 0:
	set(v):
		page = clamp(v, 0, floor(guys.size() - 1)/PAGE_SIZE)
var panels : Array[GridGuyPanel]

var cur_p : int = -1
signal clicked_guy(g : Yyby)

func _ready() -> void:
	for i in PAGE_SIZE:
		var nn : GridGuyPanel = GRIDGUYPANEL.instantiate()
		grid_container.add_child(nn)
		nn.hide()
		nn.index = i
		panels.append(nn)
		nn.get_mouse.connect(hovered_panel)
	#best line of code ever?
	#if 1 == 1: return
	for i in PAGE_SIZE + 10:
		var r = Yyby.new()
		r.generate_new()
		guys.append(r)
	set_guys(guys)

func hovered_panel(i : int):
	if i == cur_p:
		cur_p = -1
		return
	cur_p = i

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("shoot") and cur_p >= 0:
		clicked_guy.emit(guys[cur_p])

func set_guys(arr : Array[Yyby]):
	page = 0
	guys = arr
	open_page()

func open_page():
	var page_offset = page * PAGE_SIZE
	for j in PAGE_SIZE:
		var i = j + page_offset
		if i >= guys.size():
			panels[j].hide()
		else:
			panels[j].set_res(guys[i])
			panels[j].show()

func next_page():
	page += 1
	open_page()


func _on_texture_button_2_pressed() -> void:
	page -= 1
	open_page()
