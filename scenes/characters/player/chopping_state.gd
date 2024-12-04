extends NodeState

@export var player:Player
@export var animated_sprite:AnimatedSprite2D
@export var hit_component_collision_shape:CollisionShape2D

var animation_states = {
	GameInputEvents.Direction.UP: "chopping_back",
	GameInputEvents.Direction.DOWN: "chopping_front",
	GameInputEvents.Direction.LEFT: "chopping_left",
	GameInputEvents.Direction.RIGHT: "chopping_right"
}

func _ready() -> void:
#	disable hit component collision when ready
	hit_component_collision_shape.disabled = true;
	hit_component_collision_shape.position = Vector2(0,0);

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if !animated_sprite.is_playing():
		transition.emit("Idle")

# all chopping animation has looping off by pressing button to the left of FPS
func _on_enter() -> void:
	hit_component_collision_shape.disabled = false;
	
	if player.player_direction == Vector2.UP:
#		set the position of hit component
		hit_component_collision_shape.position = Vector2(3,-20);
		animated_sprite.play(animation_states.get(GameInputEvents.Direction.UP))
		
	if player.player_direction == Vector2.DOWN:
#		set the position of hit component
		hit_component_collision_shape.position = Vector2(-3,2);
		animated_sprite.play(animation_states.get(GameInputEvents.Direction.DOWN))
		
	if player.player_direction == Vector2.LEFT:
#		set the position of hit component
		hit_component_collision_shape.position = Vector2(-9,-1);
		animated_sprite.play(animation_states.get(GameInputEvents.Direction.LEFT))
		
	if player.player_direction == Vector2.RIGHT:
#		set the position of hit component
		hit_component_collision_shape.position = Vector2(9,-1);
		
		animated_sprite.play(animation_states.get(GameInputEvents.Direction.RIGHT))
		
	

func _on_exit() -> void:
	animated_sprite.stop()
	hit_component_collision_shape.disabled = true
