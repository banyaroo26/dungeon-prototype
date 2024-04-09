class_name Player extends Character

@onready var slide_sprite = get_node("SlideSprite")
@onready var slide_timer = get_node("SlideTimer")

const SPEED = 100
const SLIDE_SPEED = 200
var sliding = false

func takeDamage(damage):
	super.reduceHealth(damage)
	if health <= 0:
		goDie()
	else:
		super.getHurt()
		
func goDieAfter():
	print("Player is DeaD")

func _ready():
	super._ready()
	health = 100
	damage = 45	
	run_sprite.flip_h = false

func _process(delta):
	super._process(delta)
	
	# this executes after sliding = true in executeSlide()
	if sliding:
		if(right_flipped):
			velocity = Vector2(1,0).normalized() * SLIDE_SPEED
			move_and_slide()
		else:
			velocity = Vector2(-1,0).normalized() * SLIDE_SPEED
			move_and_slide()
	
	if continue_process: 	
		if Input.is_action_pressed("right") && Input.is_action_pressed("up"):
			enableRun()
			velocity = Vector2(1,-1).normalized() * SPEED
			flipRight()
			animation.play("run")
		elif Input.is_action_pressed("right") && Input.is_action_pressed("down"):
			enableRun()
			velocity = Vector2(1,1).normalized() * SPEED
			flipRight()
			animation.play("run")
		elif Input.is_action_pressed("left") && Input.is_action_pressed("up"):
			enableRun()
			velocity = Vector2(-1,-1).normalized() * SPEED
			flipLeft()
			animation.play("run")
		elif Input.is_action_pressed("left") && Input.is_action_pressed("down"):
			enableRun()
			velocity = Vector2(-1,1).normalized() * SPEED
			flipLeft()
			animation.play("run")
		elif Input.is_action_pressed("right"):
			enableRun()
			velocity = Vector2(1,0).normalized() * SPEED
			flipRight()
			animation.play("run")
		elif Input.is_action_pressed("left"):
			enableRun()
			velocity = Vector2(-1,0).normalized() * SPEED
			flipLeft()
			animation.play("run")
		elif Input.is_action_pressed("up"):
			enableRun()
			velocity = Vector2(0,-1).normalized() * SPEED
			animation.play("run")
		elif Input.is_action_pressed("down"):
			enableRun()
			velocity = Vector2(0,1).normalized() * SPEED
			animation.play("run")
		else:
			enableIdle()
			velocity = Vector2(0,0).normalized() * SPEED
			animation.play("idle")
			
		if Input.is_action_just_pressed("attack"):
			executeAttack()
			
		if Input.is_action_just_pressed("slide"):
			executeSlide()
			
		move_and_slide()
		
func enableAttack():
	super.enableAttack()
	slide_sprite.visible = false
	
func enableHurt():
	super.enableHurt()
	slide_sprite.visible = false
	
func enableDie():
	super.enableDie()
	slide_sprite.visible = false

func enableIdle():
	super.enableIdle()
	slide_sprite.visible = false
	
func enableRun():
	super.enableRun()
	slide_sprite.visible = false
	
func enableSlide():
	die_sprite.visible = false
	hurt_sprite.visible = false
	attack_sprite.visible = false
	idle_sprite.visible = false
	run_sprite.visible = false
	slide_sprite.visible = true
	
func playSlide():
	enableSlide()
	animation.play("slide")

func executeSlide():
	continue_process = false
	sliding = true
	playSlide()
	slide_timer.start()

# while slide_timer is running
func _on_animation_player_animation_finished(x):
	# after slide animation is done, 2 frames will be looped until
	# slide_timer ends
	if(x == "slide"):
		animation.play("slideloop")		

# when slide_timer ends
func _on_slide_timer_timeout():
	sliding = false 
	animation.play("slideend")

# after slideends animation is done
func executeSlideAfter():
	continue_process = true
	pass

func flipRight():
	super.flipRight();
	slide_sprite.flip_h = false
	
func flipLeft():
	super.flipLeft()
	slide_sprite.flip_h = true
