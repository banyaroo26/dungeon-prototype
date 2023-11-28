class_name Character extends CharacterBody2D

@onready var animation     = get_node("AnimationPlayer")
@onready var idle_sprite   = get_node("IdleSprite")
@onready var run_sprite    = get_node("RunSprite")
@onready var attack_sprite = get_node("AttackSprite")
@onready var hurt_sprite   = get_node("HurtSprite")
@onready var die_sprite    = get_node("DieSprite")

@onready var damage_coll  = get_node("CollisionShape2D")
@onready var attack_area  = get_node("Area2D")
@onready var attack_coll  = attack_area.get_node("CollisionShape2D")

var health
var damage
var continue_process = true

func _on_area_2d_body_entered(body):
	body.takeDamage(damage)

func reduceHealth(damage):
	health = health - damage
	
func getHurt():
	continue_process = false
	playHurt()	
	
func takeDamage(damage):
	reduceHealth(damage)
	getHurt()
	
func getHurtAfter():
	continue_process = true
	playIdle()
	
func goDie():
	continue_process = false
	damage_coll.disabled = true
	playDie()

func goDieAfter():
	queue_free()

func executeAttack():
	continue_process = false
	playAttack()
	
func executeAttackAfter():
	continue_process = true
	playIdle()

func _ready():
	playIdle()
	attack_coll.disabled = true
	attack_sprite.visible = false

func _process(delta):
	if continue_process: 
		if health <= 0:
			goDie()

func enableAttack():
	attack_sprite.visible = !attack_sprite.visible
	idle_sprite.visible = false
	run_sprite.visible = false
	hurt_sprite.visible = false
	die_sprite.visible = false
	
func enableHurt():
	hurt_sprite.visible = true
	attack_sprite.visible = false
	idle_sprite.visible = false
	run_sprite.visible = false
	die_sprite.visible = false
	
func enableDie():
	die_sprite.visible = true
	hurt_sprite.visible = false
	attack_sprite.visible = false
	idle_sprite.visible = false
	run_sprite.visible = false

func enableIdle():
	idle_sprite.visible = true
	die_sprite.visible = false
	hurt_sprite.visible = false
	attack_sprite.visible = false
	run_sprite.visible = false
	
func enableRun():
	run_sprite.visible = true
	idle_sprite.visible = false
	die_sprite.visible = false
	hurt_sprite.visible = false
	attack_sprite.visible = false

func playIdle():
	enableIdle()
	animation.play("idle")
	
func playAttack():
	enableAttack()
	animation.play("attack")
	
func playRun():
	enableRun()
	animation.play("run")
	
func playHurt():
	enableHurt()
	animation.play("hurt")
	
func playDie():
	enableDie()
	animation.play("die")

func flipRight():
	run_sprite.flip_h = false
	idle_sprite.flip_h = false
	attack_sprite.flip_h = false
	hurt_sprite.flip_h = false
	die_sprite.flip_h = false
	attack_area.scale.x = 1
	
func flipLeft():
	run_sprite.flip_h = true
	idle_sprite.flip_h = true
	attack_sprite.flip_h = true
	hurt_sprite.flip_h = true
	die_sprite.flip_h = true
	attack_area.scale.x = -1
