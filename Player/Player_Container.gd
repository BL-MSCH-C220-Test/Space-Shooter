extends Node2D

var Player = load("res://Player/player.tscn")

func _physics_process(_delta):
	if get_child_count() == 0:
		var player = Player.instantiate()
		player.position = Vector2(400,950)
		add_child(player)
