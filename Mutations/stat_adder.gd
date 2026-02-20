class_name MStatAdder extends Mutation

@export var stat : String = "n_haste"
@export var amount : Variant

func on_get(n : Entity, stack : bool = false):
	super.on_get(n, stack)
	if n.get(stat) != null:
		n.set(stat, n.get(stat) + amount)

func on_remove() -> bool:
	stacks -= 1
	if node && node.get(stat) != null:
		node.set(stat, node.get(stat) - amount)
	if stacks <= 0:
		return true
	return false
