extends Sprite2D

@onready var damage_component: DamageComponent = $DamageComponent
@onready var hurt_component: HurtComponent = $HurtComponent
const LOG = preload("res://scenes/objects/trees/log.tscn")
# Called when the node enters the scene tree for the first time.
#func _ready() -> void:
	#hurt_component.hurt.connect(on_hurt)
	#damage_component.max_damage_reached.connect(on_max_damage)
	
func on_max_damage()->void:
	self.call_deferred("load_log_scene")
	self.queue_free()
	
func load_log_scene()->void:
	var log_scene = LOG.instantiate() as Node2D
	log_scene.global_position = self.global_position
	self.get_parent().add_child(log_scene)
	
func on_hurt(damage_taken:int)->void:
	damage_component.apply_damage(damage_taken)
	material.set("shader_parameter/shake_intensity",1.0)
	await  self.get_tree().create_timer(1.0).timeout	
	self.material.set("shader_parameter/shake_intensity",0.0)
