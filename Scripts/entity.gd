class_name Entity extends Area2D

@export var max_health : float = 10:
	set(v):
		var temp = max_health
		max_health = v
		health += v - temp
@onready var health : float = max_health:
	set(v):
		health = min(v, max_health)

signal gave_damage(t : Entity, d : float)
signal took_damage(s : Entity, d : float)
signal on_death(pos : Vector2)
@onready var damage_plr: AudioStreamPlayer = $Damage
const DEATH_SOUND = preload("uid://c8fc8larsr36y")

var mutations : Array[Mutation] = []

var invunl : float = 0

var haste : float = 1.0:
	set(v):
		haste = max(v, 0.1)
var agility : float = 1.0:
	set(v):
		agility = max(v, 0.1)
var heart : float = 1.0:
	set(v):
		heart = max(v, 0.1)

var strength : int = 0
var pierce : int = 0

var dead : bool = false

func die():
	if dead: return
	dead = true
	get_tree().root.add_child(DEATH_SOUND.instantiate())
	on_death.emit(global_position)
	queue_free()

func _process(delta: float) -> void:
	if invunl >= 0:
		invunl -= delta

func get_mutation(m : Mutation):
	m = m.duplicate()
	for cm in mutations:
		if cm.m_name == m.m_name:
			cm.on_get(self, true)
			return
	mutations.append(m)
	m.on_get(self, false)

func remove_mutation(m : Mutation):
	for cm in mutations:
		if cm.m_name == m.m_name:
			if cm.on_remove():
				mutations.erase(cm)
			return

func take_damage(source : Entity, damage : float):
	if invunl >= 0 && self is not Enemy: return
	invunl = 0.2
	damage_plr.play()
	health -= damage
	took_damage.emit(source, damage)
	if health <= 0:
		if source:
			source.get_kill(global_position)
		die()

func get_kill(target_pos : Vector2):
	print("i killed something at " + str(target_pos))

func give_damage(target : Entity, damage : float):
	gave_damage.emit(target, damage)
