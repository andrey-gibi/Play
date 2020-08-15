extends KinematicBody2D

const SPEED = 200
const FLOOR = Vector2(0, -1)
const GRAVITY = 500
const JUMP = 450
const PULYA = preload("res://Pulya.tscn")

var coin = false

var SPEED_fast
var fire_touch = false

var is_firing = false
var is_dead = false
var velocity = Vector2()

var touch_left = false
var touch_right = false
var touch_jump = false

var lives = 3
var coins = 0
var Bullets = 10

func add_coin():
	coin = true
	$Timer.start(0.1)
	coins += 1

func die():
	$AnimatedSprite.play("die")
	$CollisionShape2D.set_deferred("disabled", true)
	is_dead = true

func _physics_process(delta):
	if lives <= 0:
		die()
	$"/root/G".coin = coin
	$"/root/G".Bullets = Bullets
	$"/root/G".lives = lives
	if is_dead:
		return
	if position.y > 3000:
		position.y = 0
	if is_firing == true:
		return
	if Input.is_action_pressed("ui_right") or touch_right:
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false
		$Position2D.position.x = abs($Position2D.position.x)
		if Input.is_action_pressed("shift") or SPEED_fast:
			velocity.x = SPEED*2.4
			
		if is_on_floor():
			$AnimatedSprite.play("run")
	elif Input.is_action_pressed("ui_left") or touch_left:
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		$Position2D.position.x = abs($Position2D.position.x) * -1
		if Input.is_action_pressed("shift") or SPEED_fast:
			velocity.x = -SPEED * 2.4
		if is_on_floor():
			$AnimatedSprite.play("run")

	
	elif Input.is_action_pressed("ui_up") && is_on_floor() or touch_jump:
		if is_on_floor():
			velocity.y = -JUMP
			$AnimatedSprite.play("jump")
	
	elif (Input.is_action_just_pressed("ui_accept")or fire_touch) && is_firing == false && is_on_floor():
		if Bullets > 0:
			is_firing = true
			$AnimatedSprite.play("fire")
			Bullets -= 1
	else:
		if is_on_floor():
			velocity.x = 0
			$AnimatedSprite.play("idle")
	
	velocity.y += (GRAVITY * delta)
	velocity = move_and_slide(velocity, FLOOR)


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation == "fire":
		var pulya = PULYA.instance()
		pulya.direction = sign($Position2D.position.x)
		pulya.position = $Position2D.global_position
		get_parent().add_child(pulya)
		is_firing = false


func _on_Left_pressed():
	touch_left = true


func _on_Right_pressed():
	touch_right = true


func _on_Jump_pressed():
	touch_jump = true



func _on_Left_released():
	touch_left = false


func _on_Right_released():
	touch_right = false


func _on_Jump_released():
	touch_jump = false


func _on_Fire_pressed():
	fire_touch = true


func _on_Fire_released():
	fire_touch = false


func _on_Speeding_pressed():
	SPEED_fast = true


func _on_Speeding_released():
	SPEED_fast = false


func _on_Timer_timeout():
	coin = false
