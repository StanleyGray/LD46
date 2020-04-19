extends KinematicBody2D

export (int) var speed = 250
export (int) var facing = 0 # 0 if facing right (Player 1), 1 if facing left (Player 2)
export (bool) var selected

var velocity = Vector2()
var mouse_over = false
#var elapsed = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	#selected = false
	input_pickable = true
	connect("mouse_entered", self, "_on_mouse_entered")
	connect("mouse_exited",  self, "_on_mouse_exited")
	match facing:
		0:
			$FanSprite0.visible = true
			$FanSprite1.visible = false
		1:
			$FanSprite0.visible = false
			$FanSprite1.visible = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
#	elapsed += delta
#	if elapsed >= 0.1:
	get_mouse_input()
	$Highlight.visible = selected
#		elapsed = 0


func _physics_process(_delta):
	get_key_input()
	velocity = move_and_slide(velocity)


func get_key_input():
	velocity = Vector2()
	if (selected):
		if Input.is_action_pressed('right'):
			velocity.x += 1
		if Input.is_action_pressed('left'):
			velocity.x -= 1
		if Input.is_action_pressed('down'):
			velocity.y += 1
		if Input.is_action_pressed('up'):
			velocity.y -= 1
	velocity = velocity.normalized() * speed
	


func get_mouse_input():
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		selected = mouse_over
		#print("blah")
		#get_tree().set_input_as_handled()


func _on_mouse_entered():
	mouse_over = true


func _on_mouse_exited():
	mouse_over = false


#func _input_event(viewport, event, shape_idx):
#	if mouse_over and event is InputEventMouseButton \
#	and event.button_index == BUTTON_LEFT \
#	and event.is_pressed():
#		print("Clicked")
