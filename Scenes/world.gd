class_name World extends Node2D

const YYBY = preload("uid://bpwebcfrb068b")

var guys : Array[YybyNode] = []
@onready var yyby_grid: GuyGridView = $CanvasLayer/YybyGrid
@onready var baby_makin_ui: BabyUI = $CanvasLayer/BabyMakinUI
@onready var player: Player = $Player

var makin_babies : bool = false

func _ready() -> void:
	baby_makin_ui.finished.connect(make_node)
	for i in 4:
		var ny : YybyNode = YYBY.instantiate()
		var nr = Yyby.new()
		nr.y_name = Yyby.generate_name()
		ny.yyby_res = nr
		add_child(ny)
		ny.position.x = randi_range(32, 900)
		ny.position.y = randi_range(32, 508)
		guys.append(ny)

func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("showmenu"):
		var arr : Array[Yyby] = []
		for i in guys:
			if i:
				arr.append(i.yyby_res)
		yyby_grid.set_guys(arr)
		yyby_grid.show()
	if Input.is_action_just_released("showmenu"):
		yyby_grid.hide()

func make_node(y : Yyby):
	var ny : YybyNode = YYBY.instantiate()
	ny.yyby_res = y
	add_child(ny)
	ny.global_position = player.global_position
	guys.append(ny)

func start_makin_babies():
	get_tree().paused = true
	var arr : Array[Yyby] = []
	for i in guys:
		if i:
			arr.append(i.yyby_res)
	baby_makin_ui.guys = arr
	yyby_grid.set_guys(arr)
	baby_makin_ui.start()
	baby_makin_ui.show()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("special"):
		start_makin_babies()
