class_name Enemy extends Character

var player
var player_position
var target_position
var range
@onready var cooldown_timer = get_node("CooldownTimer")
var on_cooldown = false
var detected
var SPEED

func executeAttack():
	if !on_cooldown:
		super.executeAttack()

func executeAttackAfter():
	continue_process = true
	on_cooldown = true
	playIdle()
	cooldown_timer.start()

func _on_cooldown_timer_timeout():
	on_cooldown = false

func getPlayerPosition():
	player_position = player.global_position
	if(player_position.x < global_position.x):
		flipLeft()
	else:
		flipRight()
		
func getClose():
	if player_position.distance_to(global_position) < range && player.health > 0:
		executeAttack()
	elif player_position.distance_to(global_position) > range && player.health > 0:
		target_position = (player_position - global_position).normalized()
		velocity = target_position * SPEED
		playRun()
		move_and_slide()
		
func _ready():
	super._ready() 
	player	= get_parent().get_node("player")

func _process(delta):
	super._process(delta)
	getPlayerPosition()
	if player.health <= 0:
		detected = false
	if continue_process:
		if detected:
			getClose()
		else:
			playIdle()
