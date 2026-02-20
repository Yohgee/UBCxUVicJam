class_name Helper extends Area2D

@export var stat : String = "agility"
@export var amount : Variant

var source : Entity

func set_source(s : Entity):
	source = s

func _on_area_entered(area: Area2D) -> void:
	print(area.name + " gets " + stat)
	if area == source: return
	if area is Entity && (area is not Enemy && source is not Enemy) || (area is Enemy && source is Enemy):
		if area.get(stat) != null:
			area.set(stat, area.get(stat) + amount)

func _on_area_exited(area: Area2D) -> void:
	if area == source: return
	if area is Entity && area is not Enemy:
		if area.get(stat) != null:
			area.set(stat, area.get(stat) - amount)
