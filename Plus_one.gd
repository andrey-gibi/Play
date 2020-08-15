extends Node2D

var que = false

func _ready():
	$Timer.start(1)

func _process(delta):
	if que:
		queue_free()

func _on_Timer_timeout():
	que = true
