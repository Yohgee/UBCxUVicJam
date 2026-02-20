class_name StatPickup extends Area2D

@export var stat : String = "agility"
@export var amnt : Variant
@export var tick_time :float = 1
@export var life_time : float = 2

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

func _on_area_entered(area: Area2D) -> void:
	if type == 2 && area is not Enemy: return
	if type <= 1 && area is not Player: return
	if area is Entity:
		var m = MStatStatusAdder.new()
		m.amnt = amnt
		m.life_time = life_time
		m.stat = stat
		m.m_name = stat + "SE"
		m.tick_time = tick_time
		for i in stack:
			area.get_mutation(m)
	queue_free()
