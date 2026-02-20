class_name MStatStatusAdder extends Mutation

@export var pe : bool = false

var c : StatSE

@export var stat : String = "agility"
@export var amnt : Variant
@export var tick_time :float = 1
@export var life_time : float = 2

var old_source : Entity
const STAT_STATUS_EFFECT = preload("uid://bjpkxcdwsyc5l")

func on_get(n : Entity, stack : bool = false):
	super.on_get(n, stack)
	if pe && n is not Player && n is not Enemy: return
	if !stack:
		c = STAT_STATUS_EFFECT.instantiate()
		c.amnt = amnt
		c.tick_time = tick_time
		c.life_time = life_time
		c.stat = stat
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
