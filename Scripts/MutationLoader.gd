extends Node

var all_muts : Array[Mutation] = []
var cat_muts : Dictionary

var debug : bool = false

func _ready() -> void:
	if !debug: return
	var path = "res://Resources/Mutations/"
	var d := DirAccess.open(path)
	d.list_dir_begin()
	var file_name : String = d.get_next()
	while file_name != "":
		var res_path = path.path_join(file_name)
		var r : Mutation = ResourceLoader.load(res_path)
		all_muts.append(r.duplicate())
		if cat_muts.has(r.cat):
			cat_muts.get(r.cat).append(r)
		else:
			cat_muts.set(r.cat, [])
			cat_muts.get(r.cat).append(r)
		file_name = d.get_next()
	d.list_dir_end()
	
	#var ns : SavedMuts = SavedMuts.new()
	#ns.all_muts = all_muts
	#ns.cat_muts = cat_muts
	#ResourceSaver.save(ns, "res://Resources/Save2.tres")

func get_random_mutation(cat : String = "rand") -> Mutation:
	var w = get_tree().get_first_node_in_group("world")
	if cat == "rand" || !w.cat_muts.has(cat):
		return w.all_muts.pick_random()
	return w.cat_muts.get(cat).pick_random()
