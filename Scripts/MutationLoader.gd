extends Node

var all_muts : Array[Mutation] = []
var cat_muts : Dictionary

func _ready() -> void:
	var path = "res://Resources/Mutations/"
	var d := DirAccess.open(path)
	d.list_dir_begin()
	var file_name : String = d.get_next()
	while file_name != "":
		var res_path = path.path_join(file_name)
		var r : Mutation = load(res_path)
		all_muts.append(r.duplicate())
		if cat_muts.has(r.cat):
			cat_muts.get(r.cat).append(r)
		else:
			cat_muts.set(r.cat, [])
			cat_muts.get(r.cat).append(r)
		file_name = d.get_next()
	d.list_dir_end()
	print(all_muts)

func get_random_mutation(cat : String = "rand") -> Mutation:
	#return preload("uid://cwclbj13kwqcv")
	if cat == "rand" || !cat_muts.has(cat):
		return all_muts.pick_random()
	print(cat)
	return cat_muts.get(cat).pick_random()
