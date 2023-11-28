extends ShapeCast2D

@onready var detection_timer = get_node("DetectionTimer")

func _ready():
	pass 

func _process(delta):
	if is_colliding():
		get_parent().detected = true
		detection_timer.start()

func _on_detection_timer_timeout():
	if !is_colliding():
		get_parent().detected = false 
