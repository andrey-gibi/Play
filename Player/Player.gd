extends KinematicBody2D

const SPEED = 200
const FLOOR = Vector2(0, -1)
const GRAVITY = 500
const JUMP = 500
const PULYA = preload("res://Pulya.dg")

var velocity = Vector2()

func _physics_process(delta):
	if position.y > 3000:
		position.y = 0
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false
		if is_on_floor():
			$AnimatedSprite.play("run")
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		if is_on_floor():
			$AnimatedSprite.play("run")
	else:
		velocity.x = 0
		if is_on_floor():
			$AnimatedSprite.play("idle")
	
	if Input.is_action_pressed("ui_up") && is_on_floor():
		velocity.y = -JUMP
		$AnimatedSprite.play("jump")
		
	if Input.is_action_just_pressed("ui_accept"):
		var pulya = PULYA.instanse()
		pulya.position = $Position2D.global_position
		get_parent().add_child(pulya)
#		$AnimatedSprite.play("fire")
	
	velocity.y += (GRAVITY * delta)
	velocity = move_and_slide(velocity, FLOOR)
