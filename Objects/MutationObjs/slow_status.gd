extends StatusEffect

func tick():
	pass

func on_get():
	if source:
		source.agility -= 0.1
		source.haste -= 0.2

func on_remove():
	if source:
		source.agility += 0.1
		source.haste += 0.2
