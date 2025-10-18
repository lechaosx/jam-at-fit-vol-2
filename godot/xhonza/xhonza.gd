extends Node2D

@onready var allFans = $fan
@onready var switchTest1 = %switch2test
@onready var switchTest2 = %switch3test

func _ready() -> void:
	for child in allFans.get_children():
		child.connector.set_source(switchTest2.connector)
