extends Node

@onready var candle1 = get_node("candle1")
@onready var candle2 = get_node("candle2")
@onready var candle3 = get_node("candle3")
@onready var candle4 = get_node("candle4")
@onready var candle5 = get_node("candle5")
@onready var candle6 = get_node("candle6")

func _process(delta):
	candle1.play("candle")
	candle2.play("candle")
	candle3.play("candle")
	candle4.play("candle")
	candle5.play("candle")
	candle6.play("candle")
