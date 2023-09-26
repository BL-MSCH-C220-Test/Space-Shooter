extends Node2D

var Enemy1 = load("res://Enemy/enemy_1.tscn")
var Boss = load("res://Enemy/boss.tscn")
var count = 5

func _on_timer_timeout():
	if count >= 0:
		var enemy = Enemy1.instantiate()
		enemy.position = Vector2(100,-50)
		add_child(enemy)
		count -= 1
	elif count != -2:
		var boss = Boss.instantiate()
		boss.position = Vector2(500,-400)
		add_child(boss)
		count -= 1
