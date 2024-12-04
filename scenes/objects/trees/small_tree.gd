extends Sprite2D

@onready var damage_component: DamageComponent = $DamageComponent
@onready var hurt_component: HurtComponent = $HurtComponent
const log = preload("res://scenes/objects/trees/log.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurt_component.hurt.connect(on_hurt)
	damage_component.max_damage_reached.connect(on_max_damage_reached)

func on_max_damage_reached()->void:
#	we have to call defred because queing free and adding new scene will give error
#	hence call_deferred will call given func name in next frame
	self.call_deferred("add_log_scene")
	self.queue_free()
	
func on_hurt(hit_damage:int)->void:
	damage_component.apply_damage(hit_damage)

func add_log_scene()->void:
	var log_scene = log.instantiate() as Node2D
	log_scene.global_position = self.global_position
	self.get_parent().add_child(log_scene)
