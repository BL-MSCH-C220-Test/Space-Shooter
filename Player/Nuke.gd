extends Area2D

var velocity = Vector2(0,-5)
var damage = 20
var Explosion = load("res://Effects/explosion.tscn")

func _ready():
	velocity = velocity.rotated(rotation)

func _physics_process(_delta):
	position += velocity


func _on_timer_timeout():
	var Asteroid_Container = get_node("/root/Game/Asteroid_Container")
	var Enemy_Container = get_node("/root/Game/Enemy_Container")
	for a in Asteroid_Container.get_children():
		if a.has_method("damage"):
			a.damage(damage)
	for e in Enemy_Container.get_children():
		if e.has_method("damage"):
			e.damage(damage)
	var Effects = get_node("/root/Game/Effects")
	var explosion = Explosion.instantiate()
	explosion.global_position = global_position
	explosion.scale = Vector2(100,100)
	Effects.add_child(explosion)
	queue_free()
