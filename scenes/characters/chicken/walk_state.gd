extends NodeState

@export var character:NonPlayableCharacter
@export var animated_sprite:AnimatedSprite2D
@export var navigation_agent:NavigationAgent2D
@export var min_speed:float = 5.0
@export var max_speed:float = 10.0

var speed:float = min_speed

func _ready() -> void:
#	call deferred will call Idle time happens mainly at the end of process and physics frames.
	self.call_deferred("character_setup")
#	this will call the function after the current frame has finished processing
	
	navigation_agent.velocity_computed.connect(on_safe_velocoty_computed) # this signal is for if avoidance detection is on

#character_setup and set_movement_target func will allow smother  setup of our navigation agent before we move between
#different targers
func character_setup()->void:
	await  self.get_tree().physics_frame
#	when we use naviagation region 2d we need to wait for first frame of physics process to load navigation agent
#	else it may cause some error
	set_movement_target()

func set_movement_target()->void:
	var target_position:Vector2 = NavigationServer2D.map_get_random_point(
		navigation_agent.get_navigation_map(), navigation_agent.navigation_layers,false
	)
	navigation_agent.target_position = target_position
	speed = randf_range(min_speed,max_speed) 
	#speed is set random in here because each time charcter reaches end of navigation
#	#we can have different speed i.e. if we set speed in ready func character will have same speed in
# 	even if it changed direction and moving to that direction 
	
	
func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	if navigation_agent.is_navigation_finished():
#		to setup random walk cycles
		character.current_walk_cycle += 1 # walk cycle will start with 0 to walk_cycle of state
		
#		if navigation from one point to second is finished we want to look for new random point
		set_movement_target()
		return
	var target_pos:Vector2 = navigation_agent.get_next_path_position()
	var target_diraction:Vector2 = character.global_position.direction_to(target_pos)
	
	
	var velocity:Vector2 =  target_diraction * speed
	if navigation_agent.avoidance_enabled:
		animated_sprite.flip_h = velocity.x < 0
		navigation_agent.velocity = velocity # this will emit 'navigation_agent.velocity_computed' signal
	else:
		character.velocity = target_diraction * speed
		character.move_and_slide() # while using move and slide we dont need to multipy with delta it is managed internally

func _on_next_transitions() -> void:
#	the walk  cycles of character is finished
	if character.current_walk_cycle == character.walk_cycle:
		character.velocity = Vector2.ZERO
		transition.emit("Idle")


func _on_enter() -> void:
	animated_sprite.play("walk")
	character.current_walk_cycle= 0 # to rest when we want to enter walk state
	character.walk_cycle = randi_range(character.min_walk_cycles,character.max_walk_cycles)
func _on_exit() -> void:
	animated_sprite.stop()


func on_safe_velocoty_computed(safe_velocity:Vector2)->void:
	animated_sprite.flip_h = safe_velocity.x < 0
	character.velocity = safe_velocity # if collision avoidance is on then safe velocity is calculated
#	for use and we can safely use this to move character
	character.move_and_slide()
