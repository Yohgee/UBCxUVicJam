class_name MOnHit extends Mutation

@export var n_adder_mut : MNodeAdder
@export var chance : float = 0.1
@export var c_per_stack : float = 0.02

func on_get(n : Entity, stack : bool = false):
	super.on_get(n, stack)
	if !stack:
		n_adder_mut = n_adder_mut.duplicate()
		n_adder_mut.old_source = n
		n.gave_damage.connect(on_hit)

func on_hit(t : Entity, _d : float):
	if randf() <= chance + c_per_stack * (stacks - 1): 
		t.get_mutation(n_adder_mut)

func on_remove() -> bool:
	stacks -= 1
	if stacks <= 0:
		if node:
			node.gave_damage.disconnect(on_hit)
		return true
	return false
