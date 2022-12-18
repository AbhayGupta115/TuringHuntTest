extends Area2D

func _on_Entrance_body_entered(body):
	Global.from_level  = get_parent().name
	SceneTranition.changeScene("res://Levels/" + self.name + ".tscn")
