extends RayCast2D

@onready var detection_timer = get_parent().get_node("DetectionTimer")
var player_position 
var target

func _ready():
	pass 

func _process(delta):
	player_position = get_parent().get_parent().get_node("player").global_position
	target_position = to_local(player_position).normalized() * get_parent().ray_length
	if (is_colliding()):
		target = get_collider()
		if(target is Player):
			get_parent().detected = true
			detection_timer.start()

func _on_detection_timer_timeout():
	if !is_colliding():
		get_parent().detected = false 
