extends NodeState

@export var player:Player
@export var animated_sprite:AnimatedSprite2D

var animation_states = {
	GameInputEvents.Direction.UP: "watering_back",
	GameInputEvents.Direction.DOWN: "watering_front",
	GameInputEvents.Direction.LEFT: "watering_left",
	GameInputEvents.Direction.RIGHT: "watering_right"
}

func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if !animated_sprite.is_playing():
		transition.emit("Idle")

# all chopping animation has looping off by pressing button to the left of FPS
func _on_enter() -> void:
	if player.player_direction == Vector2.UP:
		animated_sprite.play(animation_states.get(GameInputEvents.Direction.UP))
	if player.player_direction == Vector2.DOWN:
		animated_sprite.play(animation_states.get(GameInputEvents.Direction.DOWN))
	if player.player_direction == Vector2.LEFT:
		animated_sprite.play(animation_states.get(GameInputEvents.Direction.LEFT))
	if player.player_direction == Vector2.RIGHT:
		animated_sprite.play(animation_states.get(GameInputEvents.Direction.RIGHT))
		

func _on_exit() -> void:
	animated_sprite.stop()
