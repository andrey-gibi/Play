extends Area2D

export(String, FILE, "*	.tscn") var Target_stage

func _on_Finsh_body_entered(body):
	if "Player" in body.name:
		get_tree().change_scene("res://Level4.tscn")
