class_name Yyby extends Resource

const BASE_NUM = 20
const TAIL_USE_COL = [1,5,8,9,11,12]
const HAT_USE_COL = [9,12,13]
const BASE_SPEED = 100

@export var mutations : Array[Mutation] = []
@export var base : int = 0
@export var hat : int = 0
@export var tail : int = 0
@export var col : Color = Color.WHITE
@export var y_name : String = "eegee"
@export var title : String = ""

var n_haste : float = 1.0
var n_agi : float = 1.0
var max_hp_buff : int = 0

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
	baby.n_agi = randf_range(min(p1.n_agi, p2.n_agi), max(p1.n_agi, p2.n_agi) + 0.2)
	baby.n_haste = randf_range(min(p1.n_haste, p2.n_haste), max(p1.n_haste, p2.n_haste) + 0.2)
	baby.max_hp_buff = randi_range(min(p1.max_hp_buff, p2.max_hp_buff), max(p1.max_hp_buff, p2.max_hp_buff) + 2)
	
	r = randf()
	var nm : int = 1
	if r > 0.98:
		nm = 3
	elif  r > 0.95:
		nm = 2
	elif r > 0.9:
		return baby
	elif r > 0.5:
		nm = randi_range(min(p1.mutations.size(), p2.mutations.size()), max(p1.mutations.size(), p2.mutations.size()) + randi_range(0, 2))
	else:
		nm = randi_range(min(p1.mutations.size(), p2.mutations.size()), max(p1.mutations.size(), p2.mutations.size()))
	
	r = randf()
	if r > 0.9:
		#best line of code ever?
		baby.title = ["the Conqueror", "the Slayer", "the Oracle", "the Pig", "the Python", "the Ghost", "the Hunteress", "the Enchantress", "the Mutated", "the Champion", "the Forgotten"].pick_random()
		nm += 1
	
	baby.mutations.clear()
	var cats := []
	for m in p1.mutations:
		cats.append(m.cat)
	for m in p2.mutations:
		cats.append(m.cat)
	for i in max(nm, 1):
		r = randf()
		if r > 0.9:
			baby.mutations.append(MutationLoader.get_random_mutation().duplicate())
		else:
			baby.mutations.append(MutationLoader.get_random_mutation(cats.pick_random()).duplicate())
	return baby

static func generate_name() -> String:
	var res = ""
	for i in randi_range(3,10):
		res += char(randi_range(32, 591))
	return res

func generate_new():
	y_name = generate_name()
	n_agi = randf_range(0.9, 1.1)
	n_haste = randf_range(0.9, 1.1)
	max_hp_buff = randi_range(-1, 1)
	base = randi_range(0, BASE_NUM - 1)
	hat = randi_range(0, BASE_NUM - 1)
	tail = randi_range(0, BASE_NUM - 1)
	col = Color(randf(),randf(),randf())
	mutations.append(MutationLoader.get_random_mutation().duplicate())
