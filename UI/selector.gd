extends Control


func _on_ship_b_pressed():
	Global.Player = load("res://Player/shipB.tscn")
	get_tree().change_scene_to_file("res://game.tscn")


func _on_ship_g_pressed():
	Global.Player = load("res://Player/shipG.tscn")
	get_tree().change_scene_to_file("res://game.tscn")


func _on_ship_c_pressed():
	Global.Player = load("res://Player/shipC.tscn")
	get_tree().change_scene_to_file("res://game.tscn")
