extends RigidBody2D

var velocity
var base_scale
var starting_pos

const SCALE_RATE = 4.0 # how fast to scale (higher is faster scaling)
const SCALE_FACTOR = 0.01 # how much to adjust scale to velocity (higher is more scaling)
const SCALE_LEVEL_HI = 3.4 # how large to consider ball height as "high"
const SCALE_LEVEL_MED = 3.1 # how large to consider ball height as "medium"

# bit indexes (0-based) in collision layer/mask properties
#const COLLISION_LAYER_GROUND = 0
const COLLISION_LAYER_PLAYER = 1 
const COLLISION_LAYER_NET = 2
const COLLISION_LAYER_WALL = 3

# Called when the node enters the scene tree for the first time.
func _ready():
	base_scale = $BallSprite.scale
	starting_pos = position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var speed = velocity.length()
	var target_scale = base_scale * (1 + (speed * SCALE_FACTOR))
	var t = delta * SCALE_RATE

	$BallSprite.scale = $BallSprite.scale.linear_interpolate(target_scale, t)

	var current_scale = $BallSprite.scale.x
#	if speed > 250:
	if current_scale > SCALE_LEVEL_HI:
		# Ball height is HIGH - collide with walls but not player/net
		set_collision_layer_bit(COLLISION_LAYER_PLAYER, false)
		set_collision_layer_bit(COLLISION_LAYER_NET, false)
		set_collision_layer_bit(COLLISION_LAYER_WALL, true)

		set_collision_mask_bit(COLLISION_LAYER_PLAYER, false)
		set_collision_mask_bit(COLLISION_LAYER_NET, false)
	elif current_scale > SCALE_LEVEL_MED:
#	elif speed > 200:
		# Ball height is MEDIUM - collide with walls/net but not player
		set_collision_layer_bit(COLLISION_LAYER_PLAYER, false)
		set_collision_layer_bit(COLLISION_LAYER_NET, true)
		set_collision_layer_bit(COLLISION_LAYER_WALL, false)
				
		set_collision_mask_bit(COLLISION_LAYER_PLAYER, false)
		set_collision_mask_bit(COLLISION_LAYER_NET, true)
	else:
		# Ball height is LOW - collide with walls/net/player
		set_collision_layer_bit(COLLISION_LAYER_PLAYER, true)
		set_collision_layer_bit(COLLISION_LAYER_NET, false)
		set_collision_layer_bit(COLLISION_LAYER_WALL, false)		
		
		set_collision_mask_bit(COLLISION_LAYER_PLAYER, true)
		set_collision_mask_bit(COLLISION_LAYER_NET, true)


# Called every physics processing step. 'delta' is the elapsed time since the previous step.
func _physics_process(_delta):
	velocity = get_linear_velocity()


#func remove():
#	queue_free()


func get_starting_pos():
	return starting_pos
