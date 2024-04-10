class_name Mushroom extends Enemy

func _ready():
	super._ready() 
	health = 100
	damage = 60
	range  = 45
	ray_length = 60
	SPEED  = 20
	dialogue = ["growls","spore noises"]
	# adds timers as child nodes
	self.add_child(dialogue_timer)
	self.add_child(dialogue_wait_timer)

func _process(delta):
	super._process(delta)
