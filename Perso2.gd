extends KinematicBody2D

export (int) var run_speed = 400
export (int) var dash_speed = 10000
export (int) var jump_speed = 1100
export (int) var gravity = 50
export (int) var wall_friction = 100
export (int) var nombre_jump = 2
export (int) var nombre_wall_jump = 20
export (int) var nombre_dash = 1

export (String) var input_right = 'ui_right'
export (String) var input_left = 'ui_left'
export (String) var input_up = 'ui_up'
export (String) var input_dash = "dash"

var velocity = Vector2()
var jump_done = 0
var wall_jump_done = 0
var dash_done = 0
var in_wall_jump = false
var facing_right = true
var dash = false
var in_wall_slide = false
var wall_on_right
var current_collision

	
func _physics_process(delta):
	
	var jump = false
	var right = false
	var left = false
	
	if (get_slide_count() > 1):
		#Ignore it for now
		print("More than one collision")
		
	var collision = get_slide_collision(0)

	#Find out state
	slide_state(collision)
	
	if(is_on_floor()):
		jump_done = 0
		wall_jump_done = 0
		dash_done = 0
	if(Input.is_action_just_pressed(input_up)):
		jump = true

	#Gravity
	velocity.y += gravity
	
	#Slide friction
	if in_wall_slide and velocity.y > 0:
		velocity.y = wall_friction
		
	#Jump
	if(jump and in_wall_slide and wall_jump_done < nombre_wall_jump):
		wall_jump()
	elif (jump and jump_done < nombre_jump):
		velocity.y = -jump_speed
		jump_done += 1
	
	#Reduce x speed
	if dash:
		#Slow down after dash
		reduce_x_speed(dash_speed) 
		dash = false
		
	if in_wall_jump:
		#To have a nice wall jump curve
		if (reduce_x_speed(run_speed/4)):
			in_wall_jump = false
	else:
		#Could be greater to slow down player faster
		reduce_x_speed(run_speed)
		
	#Condition force player to follow jump wall curve until stop 
	get_input(0 if in_wall_jump else run_speed)
	
	#Dash
	if( Input.is_action_just_pressed(input_dash) and dash_done < nombre_dash):
		dash()
	
	#Jump cut
	if Input.is_action_just_released(input_up):
		jump_cut()
		
	velocity = move_and_slide(velocity, Vector2(0,-1))

func dash():
	dash_done += 1
	dash = true
	velocity.y = 0
	if facing_right:
		velocity.x = dash_speed
	else:
		velocity.x = -dash_speed
			
func wall_jump():
	if current_collision.normal[0] < 0:
		velocity.x -= 1000
	else:
		velocity.x += 1000
	velocity.y = -jump_speed
	wall_jump_done += 1
	in_wall_jump = true
	
#Set in_wall_slide accordingly
func slide_state(collision):
	
	if(is_on_wall() and collision and collision.collider.is_in_group("plateforme")):
		in_wall_slide = true
		current_collision = collision
		if collision.normal[0] == 1:
			wall_on_right = false
		else:
			wall_on_right = true
	elif(in_wall_slide):
		if (current_collision.collider.is_in_group("plateforme")):
			
			var collision_x = current_collision.position[0]
			var bord_x = global_position[0] 
			var extent = get_node("Body").shape.get_extents()
			var collider = current_collision.collider.get_node("CollisionShape2D")
			var bas_collider = collider.global_position[1] + collider.shape.get_extents()[1]*current_collision.collider.scale[1]
			var haut_self = global_position[1] - extent[1]*scale[1]

			if wall_on_right and (abs(collision_x - (bord_x+extent[0]*scale[0])) > 1 or bas_collider < haut_self):
				in_wall_slide = false
			if not wall_on_right and (abs(collision_x - (bord_x-extent[0]*scale[0])) > 1 or bas_collider < haut_self):
				in_wall_slide = false
		else:
			in_wall_slide = false
	
#Stop jump		
func jump_cut():
	if (velocity.y < 0):
		velocity.y *= 0.3
	
#Right or left by offset
func get_input(offset):
	var right = Input.is_action_pressed(input_right)
	var left = Input.is_action_pressed(input_left)
	if right:
		facing_right = true
		velocity.x += offset
	if left:
		facing_right = false
		velocity.x -= offset

#Reduce x speed by offset toward 0, if it comes to 0 return true
func reduce_x_speed(offset):
	var x = velocity.x
	if (x > 0):
		if(x > offset):
			velocity.x = x - offset
			return false
		else:
			velocity.x = 0
			return true
	else:
		if(-x > offset):
			velocity.x = x + offset
			return false
		else:
			velocity.x = 0
			return true
