extends NodeState

@export var character:CharacterBody2D
@export var animated_sprite:AnimatedSprite2D
@export var idle_timeout_sec:float = 5.5
var idle_timer:Timer = Timer.new()

var has_timer_timeout:bool = false

func _ready() -> void:
	idle_timer.wait_time =idle_timeout_sec
	idle_timer.one_shot = true
	idle_timer.timeout.connect(on_timer_timeout)
	self.add_child(idle_timer)
	
func _on_process(_delta : float) -> void:
	pass


func _on_physics_process(_delta : float) -> void:
	pass


func _on_next_transitions() -> void:
	if has_timer_timeout:
		transition.emit("Walk")


func _on_enter() -> void:
	animated_sprite.play("idle")
	idle_timer.start()



func _on_exit() -> void:
	animated_sprite.stop()
	has_timer_timeout = false
	idle_timer.stop()

func on_timer_timeout()->void:
	has_timer_timeout = true
	
