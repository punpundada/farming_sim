class_name Player
extends CharacterBody2D

@export var current_tool = DataTypes.Tools.None
@onready var hit_component: HitComponent = $HitComponent

@onready var player_direction:Vector2 =Vector2.DOWN
 	

func _ready() -> void:
	ToolManager.tool_selected.connect(on_tool_selected)
	
	
func on_tool_selected(tool:DataTypes.Tools)->void:
	current_tool=tool
	hit_component.current_tool=tool
