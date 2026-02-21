extends Node2D

const YYBY = preload("uid://bpwebcfrb068b")

var guys : Array[YybyNode]
@onready var start: AudioStreamPlayer = $start

@export var all_muts : Array[Mutation]
var cat_muts : Dictionary

func _ready() -> void:
	if true:
		for m in all_muts:
			if cat_muts.has(m.cat):
				cat_muts.get(m.cat).append(m)
			else:
				cat_muts.set(m.cat, [])
				cat_muts.get(m.cat).append(m)
	for c in cat_muts.keys():
		var ny : YybyNode = YYBY.instantiate()
		var nr = Yyby.new()
		var m : Mutation = MutationLoader.get_random_mutation(c)
		nr.mutations.append(m)
		nr.y_name = Yyby.generate_name()
		ny.yyby_res = nr
		add_child(ny)
		ny.position = Vector2(randf_range(200,800), randf_range(100,440))
		guys.append(ny)

var it : float = 2
var t : float = 0

func _process(delta: float) -> void:
	t -= delta
	if it > 0:
		it -= delta
	if t <= 0:
		if it > 0:
			t = 0.2
		else:
			t = 1
		var ny : YybyNode = YYBY.instantiate()
		var nr = Yyby.make_baby(guys.pick_random().yyby_res, guys.pick_random().yyby_res)
		ny.yyby_res = nr
		add_child(ny)
		ny.position = Vector2(randf_range(200,800), randf_range(100,440))
		guys.append(ny)
		if guys.size() > 300:
			guys.pop_front().queue_free()


func _on_button_pressed() -> void:
	for g in guys:
		g.state_machine.change_state(g.state_machine.get_node("Alert"))
	$start.play()
	$AnimationPlayer.play("fade")
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://Scenes/world.tscn")


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
