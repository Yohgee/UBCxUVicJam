class_name MTimedShooter extends MNodeAdder

@export var time : float
@export var bullet_speed : float
@export var bullet : PackedScene

func on_get(n : Entity, stack : bool = false):
	super.on_get(n, stack)
	if c is TimedShooter:
		c.wait_time = time
		c.base_time = time
		c.b = bullet
		c.b_speed = bullet_speed
		c.start()
