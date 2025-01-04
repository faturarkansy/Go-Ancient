extends Area2D

# Variabel untuk memeriksa apakah karakter berada dalam jangkauan Area2D
var character_in_range = false

# Referensi ke node Label interaksi
@onready var interact_label = $InteractLabel

func _ready():
	interact_label.hide()  # Sembunyikan label interaksi di awal

# Fungsi yang dipanggil setiap frame
@warning_ignore("unused_parameter")
func _process(delta):
	if character_in_range and Input.is_action_just_pressed("interact"):
		if self.name in Global.key_founded:  # Periksa apakah kunci sudah ditemukan
			load_next_level()  # Pindah ke level2.tscn
		else:
			show_key_message()  # Tampilkan pesan "Find the Key!" jika kunci belum ditemukan

# Fungsi yang dipanggil saat karakter masuk ke dalam Area2D
func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):  # Pastikan karakter berada dalam group "Player"
		character_in_range = true
		show_interaction_message()

# Fungsi yang dipanggil saat karakter keluar dari Area2D
func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):  # Pastikan karakter keluar dari group "Player"
		character_in_range = false
		hide_interaction_message()

# Menampilkan pesan interaksi di layar
func show_interaction_message():
	interact_label.text = "Press F to Interact"
	interact_label.show()

# Menampilkan pesan "Find the Key!" jika kunci belum ditemukan
func show_key_message():
	interact_label.text = "Find the Key!"
	interact_label.show()
	await get_tree().create_timer(2.0).timeout  # Tampilkan pesan selama 2 detik
	hide_interaction_message()  # Sembunyikan pesan setelah 2 detik

# Menghilangkan pesan interaksi di layar
func hide_interaction_message():
	interact_label.hide()

# Fungsi untuk memuat level berikutnya
func load_next_level():
	var next_level = "res://level2.tscn"  # Path ke scene level2.tscn
	Global.key_founded.clear()  # Mengosongkan array key_founded
	get_tree().change_scene_to_file(next_level)  # Mengganti scene saat ini dengan level2
