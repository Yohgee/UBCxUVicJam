class_name HelperAura extends Helper

@export var t : float = 1.5

func _process(delta: float) -> void:
	t -= delta
	if t <= 0:
		queue_free()
