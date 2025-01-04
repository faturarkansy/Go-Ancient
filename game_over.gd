extends Control

@onready var back_to_menu_button = $BackToMenuButton

func _ready():
	# Hubungkan sinyal tombol ke fungsi untuk kembali ke menu
	back_to_menu_button.connect("pressed", Callable(self, "go_to_main_menu"))

# Fungsi untuk kembali ke menu utama
func go_to_main_menu():
	get_tree().change_scene("res://main_menu/main_menu.tscn")
