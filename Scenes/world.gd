class_name World extends Node2D

const YYBY = preload("uid://bpwebcfrb068b")

const PER_WAVE : int = 2
const WAVE_TIME : float = 6

var guys : Array[YybyNode] = []
@onready var yyby_grid: GuyGridView = $CanvasLayer/YybyGrid
@onready var baby_makin_ui: BabyUI = $CanvasLayer/BabyMakinUI
@onready var player: Player = $Player
@onready var time_label: Label = $CanvasLayer/TimeLabel
const BG = preload("uid://dwdh2kl1vmbab")
@onready var bg_spr: Sprite2D = $bg
const DECAL = preload("uid://cepud3oyh5kow")
@onready var death_panel: GuyDisplayPanel = $CanvasLayer/DeathScreen/DeathPanel
@onready var death_screen: Control = $CanvasLayer/DeathScreen

@export var enemies : Array[PackedScene]

var makin_babies : bool = false

var wave : int = 1
var wt : float = WAVE_TIME * 2
var enemy_muts : Array[Mutation] = []

var dead_queue : Array[Yyby] = []

func _ready() -> void:
	for i in randi_range(64,128):
		var decal : Sprite2D = DECAL.instantiate()
		bg_spr.add_child(decal)
		decal.global_position = Vector2(randf_range(-1820, 1820), randf_range(-1080, 1080))
	baby_makin_ui.finished.connect(make_node)
	for i in 2:
		var ny : YybyNode = YYBY.instantiate()
		var nr = Yyby.new()
		var m : Mutation = MutationLoader.all_muts.pick_random()
		nr.mutations.append(m)
		player.get_mutation(m)
		nr.y_name = Yyby.generate_name()
		ny.yyby_res = nr
		add_child(ny)
		ny.position = player.position + Vector2(randf_range(-64,64), randf_range(-64,64))
		guys.append(ny)
		ny.guy_death.connect(on_guy_die)
	spawn_wave()

func _process(delta: float) -> void:
	if !dead_queue.is_empty():
		death_panel.set_res(dead_queue.pop_front())
		death_screen.show()
		get_tree().paused = true
	wt -= delta
	time_label.text = "WAVE #%d\nWAVE TIME: %.1f" % [wave, abs(wt)]
	if wt <= 0:
		start_makin_babies()
	if Input.is_action_just_pressed("showmenu"):
		var arr : Array[Yyby] = []
		for i in guys:
			if i:
				arr.append(i.yyby_res)
		yyby_grid.set_guys(arr)
		yyby_grid.show()
	if Input.is_action_just_released("showmenu"):
		yyby_grid.hide()

func make_node(y : Yyby):
	var ny : YybyNode = YYBY.instantiate()
	ny.yyby_res = y
	add_child(ny)
	ny.global_position = player.call_pos.global_position
	ny.guy_death.connect(on_guy_die)
	guys.append(ny)
	for m in ny.yyby_res.mutations:
		player.get_mutation(m)

func on_guy_die(guy : YybyNode):
	for m in guy.yyby_res.mutations:
		player.remove_mutation(m)
	dead_queue.append(guy.yyby_res)
	guy.queue_free()

func spawn_wave():
	var enemy_i : int = min(floor((wave - 1)/3.0), enemies.size() - 1)
	for i in wave * PER_WAVE:
		spawn_enemy(enemies[randi_range(0, enemy_i)])

func spawn_enemy(e : PackedScene):
	var n : Enemy = e.instantiate() as Enemy
	n.player = player
	n.wave = wave
	add_child(n)
	n.global_position = player.global_position + Vector2(0, get_viewport_rect().size.x + 100).rotated(randf_range(0, 2 * PI))
	for m in enemy_muts:
		n.get_mutation(m)

func start_makin_babies():
	get_tree().paused = true
	var arr : Array[Yyby] = []
	for i in guys:
		if i:
			arr.append(i.yyby_res)
	baby_makin_ui.guys = arr
	yyby_grid.set_guys(arr)
	baby_makin_ui.start()
	baby_makin_ui.show()
	end_wave()

func end_wave():
	wave += 1
	if wave % 12 == 0:
		enemy_muts.append(MutationLoader.get_random_mutation())
	wt = min((wave+1) * WAVE_TIME, WAVE_TIME * 12)
	spawn_wave()


func _on_death_cont_pressed() -> void:
	if dead_queue.is_empty():
		get_tree().paused = false
		death_screen.hide()
	else:
		death_panel.set_res(dead_queue.pop_front())


func _on_audio_stream_player_finished() -> void:
	$AudioStreamPlayer.play()
