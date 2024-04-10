class_name Enemy extends Character

@onready var ray_cast = get_node("RayCast2D")
var player
var player_position
var target_position
# enemy will execute attack when player is in range from them
var range
# length of raycast of enemy
var ray_length

@onready var dialogue_label = get_node("Dialogue")
@onready var dialogue_timer = Timer.new()
@onready var dialogue_wait_timer = Timer.new()
@onready var rnd = RandomNumberGenerator.new()

var dialogue = []
var dialogue_select
var dialogue_show

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
	if(player_position.x < global_position.x && detected):
		flipLeft()
	elif(player_position.x > global_position.x && detected):
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
	# dialogue label 
	dialogue_label.visible = false
	dialogue_label.modulate = Color(0.811, 0, 0.059)  
	# whether to show dialogue or not
	dialogue_show = 0
	# setup dialogue timer
	dialogue_timer.autostart = false
	dialogue_timer.wait_time = 2.0
	dialogue_timer.timeout.connect(_on_dialogue_timer_timeout)
	dialogue_timer.ready.connect(_on_dialogue_timer_ready)
	dialogue_wait_timer.autostart = false
	dialogue_wait_timer.wait_time = 5.0
	dialogue_wait_timer.timeout.connect(_on_dialogue_wait_timer_timeout)
	# randomize whether enemy will facing left or right on spawn
	flipLeft()

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
	
# called once when the timer is ready
func _on_dialogue_timer_ready():
	if(!detected && len(dialogue)>0):
		callDialogueTimer()
	
func callDialogueTimer():
	dialogue_show = rnd.randi_range(0,1)
	if(dialogue_show == 1):
		dialogue_select = rnd.randi_range(0, len(dialogue) - 1)
		dialogue_label.text = "* " + dialogue[dialogue_select] + " *";
		dialogue_label.visible = true
	dialogue_timer.start()

func _on_dialogue_timer_timeout():
	dialogue_label.visible = false
	dialogue_timer.stop()
	dialogue_wait_timer.start()

func _on_dialogue_wait_timer_timeout():
	if(!detected):
		callDialogueTimer()
