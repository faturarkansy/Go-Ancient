extends Area2D
@onready var char = $Character_Body

func _ready():
	_on_body_entered(char)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		reload_scene()

func reload_scene():
	get_tree().reload_current_scene()
