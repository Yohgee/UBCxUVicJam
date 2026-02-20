extends StatusEffect

func tick():
	print(old_source)
	if source:
		print(source.max_health * (1/50.0 + (stack - 1)/100.0))
		source.take_damage(old_source, source.max_health * (1/50.0 + (stack - 1)/100.0))
