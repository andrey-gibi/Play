extends Area2D


export(String, FILE, "*	.tscn") var Target_stage

func _on_Pila_body_entered(body):
	if "Player" in body.name:
		body.lives -= 1
