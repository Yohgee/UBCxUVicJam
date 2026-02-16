class_name World extends Node2D

const YYBY = preload("uid://bpwebcfrb068b")

var guys : Array[YybyNode] = []

func _ready() -> void:
	for i in 2:
		var ny : YybyNode = YYBY.instantiate()
		var nr = Yyby.new()
		nr.y_name = Yyby.generate_name()
		ny.yyby_res = nr
		add_child(ny)
		ny.position.x = randi_range(32, 900)
		ny.position.y = randi_range(32, 508)
		guys.append(ny)
