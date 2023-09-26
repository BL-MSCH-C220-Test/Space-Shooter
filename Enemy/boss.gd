extends CharacterBody2D

var Bullet = load("res://Enemy/enemy_bullet.tscn")
var Bullet2 = load("res://Enemy/enemy_bullet2.tscn")
var weapon1_rotation = 0
var weapon2_rotation = 0

var health = 200
var shooting = false


func _ready():
	damage(0)
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(500,200), 10.0)
	tween.tween_callback(move)
	$Label.text = "You fool! Did you think you could beat me?"

func move():
	shooting = true
	$Label.text = ""
	var tween = create_tween()
	tween.tween_property(self, "position", Vector2(700, position.y), 3.0)
	tween.tween_property(self, "position", Vector2(100, position.y), 3.0)
	tween.tween_callback(move)


func _on_weapon_1_timeout():
	var Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null and shooting:
		var bullet = Bullet.instantiate()
		bullet.position = position + Vector2(0,-100).rotated(weapon1_rotation)
		bullet.rotation = weapon1_rotation
		Effects.add_child(bullet)
		weapon1_rotation += 0.2


func _on_weapon_2_timeout():
	var Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null and shooting:
		var bullet = Bullet2.instantiate()
		bullet.position = position + Vector2(0,-100).rotated(weapon2_rotation)
		bullet.rotation = weapon2_rotation
		Effects.add_child(bullet)
		weapon2_rotation -= 0.5

func damage(d):
	health -= d
	$HealthBar.value = health
	if health <= 0:
		Global.update_score(1000)
		queue_free()
