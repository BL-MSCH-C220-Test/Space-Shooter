extends CharacterBody2D


var speed = 5
var max_speed = 400
var rotate_speed = 0.08
var nose = Vector2(0,-60)
var health = 10
var weapon = 1
var Bullet = load("res://Player/bullet.tscn")
var Effects = null
var Explosion = load("res://Effects/explosion.tscn")

func get_input():
	var to_return = Vector2.ZERO
	$Exhaust.hide()
	if Input.is_action_pressed("Forward"):
		to_return += Vector2(0,-1)
		$Exhaust.show()
	if Input.is_action_pressed("Left"):
		rotation -= rotate_speed
	if Input.is_action_pressed("Right"):
		rotation += rotate_speed
	return to_return.rotated(rotation)

func _physics_process(_delta):
	if health > 10:
		$Sprite2D.modulate.h = 0.81
	elif health > 5:
		$Sprite2D.modulate.h = 0.33
	elif health > 1:
		$Sprite2D.modulate.h = 0.14
	else:
		$Sprite2D.modulate.h = 0.0
	velocity += get_input()*speed
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	
	position.x = wrapf(position.x, 0, Global.VP.x)
	position.y = wrapf(position.y, 0, Global.VP.y)
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	
	move_and_slide()
	
	if Input.is_action_just_pressed("Shoot"):
		for w in range(weapon):
			var weapon_position = nose
			if weapon > 1:
				if w == 1:
					weapon_position = nose + Vector2(-30,-4)
				elif w == 2:
					weapon_position = nose + Vector2(40,-4)
			var bullet = Bullet.instantiate()
			bullet.position = position + weapon_position.rotated(rotation)
			bullet.rotation = rotation
			var Effects = get_node_or_null("/root/Game/Effects")
			if Effects != null:
				Effects.add_child(bullet)
	
	if Input.is_action_just_pressed("Shoot2"):
		for w in $Weapons.get_children():
			w.shoot(nose, global_position, rotation)

func damage(d):
	health -= d
	if health <= 0:
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var explosion = Explosion.instantiate()
			Effects.add_child(explosion)
			explosion.global_position = global_position
			hide()
			await explosion.animation_finished
		Global.update_lives(-1)
		queue_free()

func add_weapon(w):
	w.position = Vector2.ZERO
	$Weapons.add_child(w)
	

func _on_area_2d_body_entered(body):
	if body.name != "Player":
		damage(100)
