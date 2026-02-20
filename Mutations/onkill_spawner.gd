class_name MOnKill extends Mutation

@export var chance : float = 0.1
@export var c_per_stack : float = 0.02
@export var spawn : PackedScene

func on_get(n : Entity, stack : bool = false):
	super.on_get(n, stack)
	if !stack:
		n.on_get_kill.connect(on_kill)

func on_kill(pos : Vector2):
	if randf() <= chance + c_per_stack * (stacks - 1) && node: 
		var n : Node2D = spawn.instantiate()
		if n.has_method("set_source"):
			n.set_source(node)
		if n.get("stack") != null:
			n.set("stack", stacks)
		node.get_tree().root.call_deferred("add_child", n)
		n.global_position = pos

func on_remove() -> bool:
	stacks -= 1
	if stacks <= 0:
		if node:
			node.on_get_kill.disconnect(on_kill)
		return true
	return false
