class_name Mutation extends Resource

@export var m_name : String = "Mutation"
@export var desc : String = "This mutation probably does something hahahaha loool"
@export var cat : String = "Stat"

var stacks : int = 0

var node : Entity = null
func on_get(n : Entity, _stack : bool = false):

	stacks += 1
	node = n
	print(n.name + " has: " + str(stacks) + " of " + m_name )

func on_remove() -> bool:
	stacks -= 1
	if node:
		print(node.name + " has: " + str(stacks) + " of " + m_name )
	if stacks <= 0:
		return true
	return false
