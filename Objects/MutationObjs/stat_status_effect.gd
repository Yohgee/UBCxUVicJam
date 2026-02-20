class_name StatSE extends StatusEffect

@export var stat : String = "agility"
@export var amnt : Variant

func tick():
	pass

func on_get():
	if source && source.get(stat) != null:
		source.set(stat, source.get(stat) + amnt)

func on_remove():
	if source && source.get(stat) != null:
		source.set(stat, source.get(stat) - amnt)
