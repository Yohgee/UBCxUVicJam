class_name Yyby extends Resource

const BASE_NUM = 20
const TAIL_USE_COL = [1,5,8,9,11,12]
const HAT_USE_COL = [9,12,13]
const BASE_SPEED = 100

const TEST = preload("uid://mh5s2y4hso1m")

@export var mutations : Array[Mutation] = []
@export var base : int = 0
@export var hat : int = 0
@export var tail : int = 0
@export var col : Color = Color.WHITE
@export var y_name : String = "eegee"
@export var title : String = ""

static func make_baby(p1 : Yyby, p2 : Yyby) -> Yyby:
	var r = randf()
	var baby = Yyby.new()
	baby.generate_new()
	if r < 0.9:
		print("wha")
		if r < 0.4:
			baby.col = Color(p1.col.r + randf_range(-0.2, 0.2), p1.col.g + randf_range(-0.2, 0.2), p1.col.b + randf_range(-0.2, 0.2))
		else:
			baby.col = Color(p2.col.r + randf_range(-0.2, 0.2), p2.col.g + randf_range(-0.2, 0.2), p2.col.b + randf_range(-0.2, 0.2))
	for prop in ["hat", "tail", "base"]:
		r = randf()
		if r < 0.8:
			if r < 0.4:
				baby.set(prop, p1.get(prop))
			else:
				baby.set(prop, p2.get(prop))
	
	return baby

static func generate_name() -> String:
	var res = ""
	for i in randi_range(3,10):
		res += char(randi_range(32, 591))
	return res

func generate_new():
	y_name = generate_name()
	base = randi_range(0, BASE_NUM - 1)
	hat = randi_range(0, BASE_NUM - 1)
	tail = randi_range(0, BASE_NUM - 1)
	col = Color(randf(),randf(),randf())
	mutations.append(TEST)
	mutations.append(TEST)
	mutations.append(TEST)
