class_name Mushroom extends Enemy

func _ready():
	super._ready() 
	health = 100
	damage = 60
	range  = 45
	SPEED  = 20

func _process(delta):
	super._process(delta)
