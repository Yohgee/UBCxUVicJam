class_name Player extends Entity

const BASE_SPEED = 200
@onready var cursor_spr: Sprite2D = $Cursor_Spr
@onready var close_call_coll: CollisionShape2D = $CloseCall/CloseCallColl
@onready var point_call: Area2D = $PointCall
@onready var point_call_coll: CollisionShape2D = $PointCall/CollisionShape2D
@onready var call_pos: Node2D = $Cursor_Spr/Call_Pos

var selected_yyby : Array[YybyNode] = []

var select_circle_t : float = 0
var saved_fp : Vector2 = Vector2.ZERO
var auto_command : bool = false

func _draw() -> void:
	if Input.is_action_pressed("command"):
		draw_circle(get_viewport().get_mouse_position() - get_viewport_rect().size/2, 128, Color(0.7,0.5,0.5,0.5))
	if select_circle_t > 0:
		draw_circle(Vector2.ZERO, min(480, select_circle_t * 480*2), Color(1,1,1,0.25 - (max(select_circle_t - 0.25, 0))))
		draw_circle(Vector2.ZERO, min(480, max(select_circle_t * 480*4 - 240, 0)), Color(1,1,1,0.25- (max(select_circle_t - 0.25, 0))))
		draw_circle(Vector2.ZERO, min(480, max(select_circle_t * 480*8 - 480, 0)), Color(1,1,1,0.25- (max(select_circle_t - 0.25, 0))))


func _physics_process(delta: float) -> void:
	var dx = Input.get_action_strength("right") - Input.get_action_strength("left")
	var dy = Input.get_action_strength("dwn") - Input.get_action_strength("up")
	
	position += Vector2(dx, dy).normalized() * delta * BASE_SPEED
	
	cursor_spr.look_at(get_global_mouse_position())
	
	if select_circle_t > 0:
		select_circle_t += delta
	if select_circle_t >= 0.5:
		select_circle_t = 0
		if auto_command:
			for s in selected_yyby:
				s.get_command(saved_fp, 64)
			selected_yyby.clear()
	
	if Input.is_action_just_pressed("follow") || Input.is_action_just_pressed("near_select"):
		auto_command = false
		saved_fp = call_pos.global_position
		selected_yyby.clear()
		pulse_collision_shape(close_call_coll)
		select_circle_t = 0.1
		if Input.is_action_just_pressed("follow"):
			auto_command = true
	
	if Input.is_action_pressed("command"):
		point_call.position = get_viewport().get_mouse_position() - get_viewport_rect().size/2
	
	if Input.is_action_just_released("command"):
		select_circle_t = 0
		if selected_yyby.is_empty():
			selected_yyby.clear()
			pulse_collision_shape(point_call_coll)
		else:
			for s in selected_yyby:
				s.get_command(get_global_mouse_position(), 64)
			selected_yyby.clear()
	
	queue_redraw()

func pulse_collision_shape(c : CollisionShape2D):
	c.set_deferred("disabled", false)
	await get_tree().create_timer(0.1).timeout
	c.set_deferred("disabled", true)

func _on_close_call_area_entered(area: Area2D) -> void:
	if area is not YybyNode: return
	area = area as YybyNode
	selected_yyby.append(area)
	area.get_selected(self)
	
