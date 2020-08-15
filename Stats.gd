extends Node2D

var coin

var coin_off = false

const ones = preload("res://Plus_one.tscn")

func _physics_process(delta):
	coin = $"/root/G".coin
	$CanvasLayer/Label2.text = str($"/root/G".lives)
	$CanvasLayer/Label3.text = str($"/root/G".Bullets)
	if $"/root/G".Bullets == 0:
		$CanvasLayer/Label4.show()
	if coin:
		if !coin_off:
			coin_off = true
			var one = ones.instance()
			$CanvasLayer.add_child(one)
			one.position = $Position2D.global_position
			$Timer.start(0.1)

func _ready():
	pass


func _on_Timer_timeout():
	coin_off = false
