class_name Spore extends RigidBody2D

@onready var animated_sprite = get_node("AnimatedSprite2D")
const PROJECTILE_SPEED = 100
const damage = 20

func _on_animated_sprite_2d_animation_finished():
	queue_free()
	
func _on_area_2d_body_entered(body):
	if body is Player:
		body.takeDamage(damage)
		sleeping = true
		animated_sprite.play("explode")
		
func _ready():
	animated_sprite.play("idle")

func _process(delta):
	pass
