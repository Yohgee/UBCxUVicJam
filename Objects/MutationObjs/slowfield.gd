extends Area2D

var source : Entity
var stack : int = 1


var type : int = 0

func set_source(s : Entity):
	source = s
	if s == null: return
	if s is Enemy:
		type = 2
	elif s is Player:
		type = 1

var t : float = 3

func _process(delta: float) -> void:
	t -= delta
	if t <= 0:
		queue_free()

func _on_area_entered(area: Area2D) -> void:
	if type == 0 && area is not Enemy: return
	if type == 2 && area is Enemy: return
	if area == source: return
	if area is Entity:
		area.agility -= 0.3
		area.haste -= 0.3


func _on_area_exited(area: Area2D) -> void:
	if type == 0 && area is not Enemy: return
	if type == 2 && area is Enemy: return
	if area == source: return
	if area is Entity:
		area.agility += 0.3
		area.haste += 0.3
