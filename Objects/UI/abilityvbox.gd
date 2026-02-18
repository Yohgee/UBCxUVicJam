class_name AbilityVBox extends PanelContainer

const ABILITY_LABEL = preload("uid://b5ipncdv1hpmo")

@onready var v_box_container: VBoxContainer = $VBoxContainer
@onready var hover_label: Label = $"VBoxContainer/Hover Label"

var muts : Array[Mutation] = []

var labels : Array[Label] = []

func set_mutations(arr : Array[Mutation]):
	muts = arr
	for l in labels:
		l.queue_free()
	labels.clear()
	
	for m in arr.size():
		var nl : Label = ABILITY_LABEL.instantiate()
		v_box_container.add_child(nl)
		nl.text = arr[m].m_name
		labels.append(nl)
		if m >= 2:
			nl.visible = false
	
	v_box_container.move_child(hover_label, -1)


func _on_mouse_entered() -> void:
	for i in muts.size():
		labels[i].show()
		labels[i].text = muts[i].m_name + ": " + muts[i].desc
	hover_label.hide()


func _on_mouse_exited() -> void:
	for i in muts.size():
		if i >= 2:
			labels[i].hide()
		labels[i].text = muts[i].m_name
	hover_label.show()
