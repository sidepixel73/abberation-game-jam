extends Node3D

# code for weapon movement by https://github.com/jungaboon/Tutorial_Scripts/blob/main/FPS%20Weapon%20Sway%20and%20Movement/player_controller.gd
@export var weapon_holder: Node3D
@export var body: GoldGdt_Body
var def_weapon_holder_pos: Vector3
var mouse_input : Vector2
var weapon_rotation_amount : float = 0.2

@onready var animTree = get_node("GunMeshAndAnimation/AnimationTree")
var gunState = 0


func _ready():
	# code for weapon movement
	def_weapon_holder_pos = weapon_holder.position
	animTree.set("parameters/Transition/transition_request", "state_0")

func _physics_process(delta):
	# code for weapon movement
	var input_dir = Input.get_vector("pm_moveleft","pm_moveright","pm_moveforward","pm_movebackward")
	weapon_bob(body.velocity.length(), delta)
	weapon_tilt(input_dir.x, delta)

func _input(event):
	if event.is_action_pressed("testing_button"):
		if gunState == 0:
			animTree.set("parameters/Transition/transition_request", "state_2")
			gunState = 1
		else:
			animTree.set("parameters/Transition/transition_request", "state_0")
			gunState = 0

func weapon_tilt(input_x, delta): # code for weapon movement
	if weapon_holder:
		weapon_holder.rotation.z = lerp(weapon_holder.rotation.z, input_x * weapon_rotation_amount, 10 * delta)

func weapon_bob(vel: float, delta): # code for weapon movement
	if vel > 0:
		var bob_amount : float
		var bob_freq : float = 0.01
		if vel >= 7:
			bob_amount = 0.007
		else:
			bob_amount = 0.001 * vel
			bob_freq = 0.005
		weapon_holder.position.y = lerp(weapon_holder.position.y, def_weapon_holder_pos.y + sin(Time.get_ticks_msec() * bob_freq) * bob_amount, 10 * delta)
		weapon_holder.position.x = lerp(weapon_holder.position.x, def_weapon_holder_pos.x + sin(Time.get_ticks_msec() * bob_freq * 0.5) * bob_amount, 10 * delta)
	
