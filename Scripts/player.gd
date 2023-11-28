class_name Player extends Character

const SPEED = 100

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
	if continue_process: 		
		if Input.is_action_pressed("right"):
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
			
		move_and_slide()
