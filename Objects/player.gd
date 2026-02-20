class_name Player extends Entity

const BASE_SPEED = 200
@onready var cursor_spr: Sprite2D = $Cursor_Spr
@onready var close_call_coll: CollisionShape2D = $CloseCall/CloseCallColl
@onready var point_call: Area2D = $PointCall
@onready var point_call_coll: CollisionShape2D = $PointCall/CollisionShape2D
@onready var call_pos: Node2D = $Cursor_Spr/Call_Pos
@export var cramp : Gradient
# BULLET = preload("uid://dkk3qmm3u7nek")
@export var bullet_scene : PackedScene
@onready var main_spr: Sprite2D = $MainSpr
@onready var shoot_plr: AudioStreamPlayer = $Shoot
@onready var tweet_plr: AudioStreamPlayer = $tweet

var selected_yyby : Array[YybyNode] = []

var select_circle_t : float = 0
var saved_fp : Vector2 = Vector2.ZERO
var auto_command : bool = false
var bullet_speed : float = 350
var shoot_cd : float = 0.8:
	set(v):
		shoot_cd = max(0.05, v)
var cd : float = 0

func _draw() -> void:
	if Input.is_action_pressed("command"):
		draw_circle(get_viewport().get_mouse_position() - get_viewport_rect().size/2, 128, Color(0.7,0.5,0.5,0.5))
	if select_circle_t > 0:
		draw_circle(Vector2.ZERO, min(480, select_circle_t * 480*2), Color(1,1,1,0.25 - (max(select_circle_t - 0.25, 0))))
		draw_circle(Vector2.ZERO, min(480, max(select_circle_t * 480*4 - 240, 0)), Color(1,1,1,0.25- (max(select_circle_t - 0.25, 0))))
		draw_circle(Vector2.ZERO, min(480, max(select_circle_t * 480*8 - 480, 0)), Color(1,1,1,0.25- (max(select_circle_t - 0.25, 0))))

func die():
	hide()
	if dead: return
	dead = true
	get_tree().root.add_child(DEATH_SOUND.instantiate())
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/title_screen.tscn")

@onready var label: Label = $Label
var debug : bool = true

func _physics_process(delta: float) -> void:
	if dead: return
	label.visible = debug
	label.text = "agi: " + str(agility) + "\nhaste: " + str(haste) + "\nstr: " + str(strength) + "\nheart: " + str(heart)
	var dx = Input.get_action_strength("right") - Input.get_action_strength("left")
	var dy = Input.get_action_strength("dwn") - Input.get_action_strength("up")
	
	position += Vector2(dx, dy).normalized() * delta * BASE_SPEED * agility
	
	position.x = clamp(position.x, -1820, 1820)
	position.y = clamp(position.y, -1080, 1080)
	
	cursor_spr.look_at(get_global_mouse_position())
	
	if select_circle_t > 0:
		select_circle_t += delta
	if select_circle_t >= 0.5:
		select_circle_t = 0
		if auto_command:
			for s in selected_yyby:
				if s:
					s.get_command(saved_fp, 64)
			selected_yyby.clear()
	
	if Input.is_action_just_pressed("follow") || Input.is_action_just_pressed("near_select"):
		auto_command = false
		tweet_plr.play()
		saved_fp = call_pos.global_position
		selected_yyby.clear()
		pulse_collision_shape(close_call_coll)
		select_circle_t = 0.1
		if Input.is_action_just_pressed("follow"):
			auto_command = true
	
	if cd > 0:
		cd -= delta
	
	if Input.is_action_pressed("shoot") && cd <=0:
		cd = shoot_cd/haste
		spawn_bullet(bullet_scene)
	
	if Input.is_action_pressed("command"):
		point_call.position = get_viewport().get_mouse_position() - get_viewport_rect().size/2
	
	if Input.is_action_just_released("command"):
		select_circle_t = 0
		if selected_yyby.is_empty():
			selected_yyby.clear()
			tweet_plr.play()
			pulse_collision_shape(point_call_coll)
		else:
			for s in selected_yyby:
				if s:
					s.get_command(get_global_mouse_position(), 64)
			selected_yyby.clear()
	
	queue_redraw()

func _process(delta: float) -> void:
	if invunl >= 0:
		invunl -= delta
	main_spr.modulate = cramp.sample(health / max_health)

func spawn_bullet(b : PackedScene):
	shoot_plr.play()
	var angle := get_angle_to(get_global_mouse_position())
	var offset := Vector2(16, 0).rotated(angle)
	var bullet : Bullet = b.instantiate()
	get_tree().current_scene.add_child(bullet)
	bullet.source = self
	bullet.pierce += pierce
	bullet.damage += strength
	bullet.global_position = global_position + offset
	bullet.velocity = Vector2(bullet_speed, 0).rotated(angle)

func pulse_collision_shape(c : CollisionShape2D):
	c.set_deferred("disabled", false)
	await get_tree().create_timer(0.1).timeout
	c.set_deferred("disabled", true)

func _on_close_call_area_entered(area: Area2D) -> void:
	if area is not YybyNode: return
	area = area as YybyNode
	selected_yyby.append(area)
	area.get_selected(self)
	


func _on_timer_timeout() -> void:
	health += 1 * heart
	$Timer.start()


func _on_tweet_finished() -> void:
	tweet_plr.pitch_scale = randf_range(0.85, 1.15)
