extends StatusEffect

func tick():
	if source:
		source.take_damage(old_source, stack)
