class_name Enemy extends Entity

@onready var state_machine: StateMachine = $StateMachine

var wave : int = 0
var player : Player = null
var target : Entity
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	max_health += wave/1.5
	strength += floor(wave/2.0)
	agility += wave/20.0
	haste += wave/15.0

func _physics_process(delta: float) -> void:
	state_machine.main(delta)
