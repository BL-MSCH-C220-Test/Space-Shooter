extends Node2D


var Bullet = load("res://Player/big_bullet.tscn")


func shoot(weapon_position,p,r):
	var bullet = Bullet.instantiate()
	bullet.global_position = p + weapon_position.rotated(r)
	bullet.rotation = r
	var Effects = get_node_or_null("/root/Game/Effects")
	if Effects != null:
		Effects.add_child(bullet)
	
