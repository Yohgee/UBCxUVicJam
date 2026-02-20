class_name MNodeAdder extends Mutation

@export var spawn : PackedScene

@export var pe : bool = true

var c : Node

var old_source : Entity

func on_get(n : Entity, stack : bool = false):
	super.on_get(n, stack)
	if pe && n is not Player && n is not Enemy: return
	if !stack:
		c = spawn.instantiate()
		if c.has_method("set_source"):
			c.set_source(n)
		if c.has_method("set_mut"):
			c.set_mut(self)
		if c.has_method("set_old_source"):
			print("os: " + str(old_source))
			c.set_old_source(old_source)
		n.add_child(c)
	elif c.get("stack") != null:
		c.set("stack", c.get("stack") + 1)

func on_remove() -> bool:
	stacks -= 1
	if c.get("stack") != null:
		c.set("stack", c.get("stack") - 1)
	if stacks <= 0:
		c.queue_free()
		return true
	return false
