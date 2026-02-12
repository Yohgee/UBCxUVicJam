class_name World extends Node2D

const YYBY = preload("uid://bpwebcfrb068b")

var guys : Array[YybyNode] = []

func _ready() -> void:
	for i in 2:
		var ny : YybyNode = YYBY.instantiate()
		var nr = Yyby.new()
		ny.yyby_res = nr
		add_child(ny)
		ny.position.x = randi_range(32, 900)
		ny.position.y = randi_range(32, 508)
		guys.append(ny)

var t = 0.1

func _process(delta: float) -> void:
	t += delta
	if t > 0.1:
		t = 0
		var ny : YybyNode = YYBY.instantiate()
		var nr = Yyby.make_baby(guys.pick_random().yyby_res, guys.pick_random().yyby_res)
		ny.yyby_res = nr
		add_child(ny)
		ny.position.x = randi_range(32, 900)
		ny.position.y = randi_range(32, 508)
		guys.append(ny)
		if guys.size() > 10:
			guys.pop_front().queue_free()
