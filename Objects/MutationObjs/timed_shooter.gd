class_name TimedShooter extends Timer

var source : Entity
var stack : int = 1
var b : PackedScene
var b_speed
var base_time : float

func _ready() -> void:
	timeout.connect(spawn_bullet)

func set_source(s : Entity):
	source = s

func spawn_bullet():
	wait_time = base_time / source.haste
	var angle
	if source is Player:
		angle = source.get_angle_to(source.get_global_mouse_position())
	elif source is Enemy:
		angle = source.global_position.angle_to(source.player.global_position)
	var offset := Vector2(16, 0).rotated(angle)
	var bullet : Bullet = b.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.source = source
	bullet.pierce += source.pierce
	bullet.damage += source.strength + (stack - 1)
	bullet.global_position = source.global_position + offset
	bullet.velocity = Vector2(b_speed, 0).rotated(angle)
