class_name Shooshroom extends Enemy

@onready var spore_blueprint = preload("res://spore.tscn")
@onready var marker = get_node("Marker2D")
var spore

func executeAttackAfter():
	super.executeAttackAfter()
	spore = spore_blueprint.instantiate()
	get_parent().add_child(spore)
	spore.global_position = marker.global_position
	target_position = (player_position - global_position).normalized()
	spore.apply_impulse(target_position * spore.PROJECTILE_SPEED)

func _ready():
	super._ready() 
	health = 100
	damage = 60
	range  = 100
	ray_length = 80
	SPEED  = 25
	dialogue = ["growls","sheeeee","hissing"]
	# adds timers as child nodes
	self.add_child(dialogue_timer)
	self.add_child(dialogue_wait_timer)

func _process(delta):
	super._process(delta)
