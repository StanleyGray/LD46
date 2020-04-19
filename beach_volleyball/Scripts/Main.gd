extends Node

#export (PackedScene) var Ball
var hits

# Called when the node enters the scene tree for the first time.
func _ready():
	hits = 0
	update_hit_counter()
	init_fans()
	$Music.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func init_fans():
	var Fan = preload("res://Scenes/Fan.tscn") # Will load when parsing the script.
	# Team 1 (left)
	add_fan(Fan, 340, 312, 0)
	add_fan(Fan, 340, 112, 0)
	add_fan(Fan, 340, 512, 0)
	add_fan(Fan, 140, 312, 0)
	add_fan(Fan, 140, 112, 0)
	add_fan(Fan, 140, 512, 0, true) # back-right player serves first
	# Team 2 (right)
	add_fan(Fan, 690, 312, 1)
	add_fan(Fan, 690, 112, 1)
	add_fan(Fan, 690, 512, 1)
	add_fan(Fan, 890, 312, 1)
	add_fan(Fan, 890, 112, 1)
	add_fan(Fan, 890, 512, 1)


func add_fan(scene, x, y, facing, selected=false):
	var fan = scene.instance()
	fan.position = Vector2(x,y)
	fan.facing = facing
	fan.selected = selected
	$Game.add_child(fan, true)


func _on_Ball_body_entered(body):
	$Game/Ball/HitSound.play()
	if (body.get_name().substr(0,3) == "Fan"):
		hits += 1
		update_hit_counter()


func update_hit_counter():
	$HUD/MarginContainer/HBoxContainer/HitCounter.text = "Hits: " + str(hits)


#func _on_BallVisibility_screen_exited():
#	print("Ball exited screen")
#	$Game/Ball.position = $Game/Ball.get_starting_pos()
