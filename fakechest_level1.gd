extends Area2D

# Variabel untuk memeriksa apakah karakter berada dalam jangkauan
var character_in_range = false

# Variabel untuk memeriksa apakah chest sudah terbuka
var chest_opened = false

# Referensi ke node OpenChest, OpenChestZonk, CloseChest, dan Label interaksi
@onready var open_chest = $OpenChest
@onready var open_chest_zonk = $OpenChestZonk
@onready var close_chest = $CloseChest
@onready var interact_label = $InteractLabel

# Fungsi yang dipanggil saat node siap
func _ready():
	# Sembunyikan sprite OpenChest dan OpenChestZonk di awal
	open_chest.hide()
	open_chest_zonk.hide()
	# Sembunyikan label interaksi di awal
	interact_label.hide()

# Fungsi untuk memproses input
@warning_ignore("unused_parameter")
func _process(delta):
	# Jika karakter dalam jangkauan dan tombol F ditekan dan chest belum terbuka
	if character_in_range and Input.is_action_just_pressed("open_chest") and not chest_opened:
		open_chest_chest()

# Fungsi untuk membuka chest
func open_chest_chest():
	# Tampilkan sprite OpenChestZonk dan sembunyikan CloseChest
	open_chest_zonk.show()
	close_chest.hide()
	# Tandai chest sebagai sudah terbuka
	chest_opened = true
	# Menghilangkan pesan interaksi setelah chest terbuka
	hide_interaction_message()
	
	# Tunggu 2 detik sebelum menampilkan OpenChest
	await get_tree().create_timer(2.0).timeout
	open_chest_zonk.hide()
	open_chest.show()

# Fungsi yang dipanggil saat karakter masuk ke dalam Area2D
func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):  # Pastikan karakter berada dalam group "Player"
		character_in_range = true
		# Hanya tampilkan pesan jika chest belum terbuka
		if not chest_opened:
			show_interaction_message()

# Fungsi yang dipanggil saat karakter keluar dari Area2D
func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):  # Pastikan karakter keluar dari group "Player"
		character_in_range = false
		# Menghilangkan pesan interaksi saat keluar dari area
		hide_interaction_message()

# Menampilkan pesan interaksi di layar
func show_interaction_message():
	interact_label.text = "Press F to Open"
	interact_label.show()

# Menghilangkan pesan interaksi di layar
func hide_interaction_message():
	interact_label.hide()  # Kosongkan pesan atau sembunyikan dari UI jika menggunakan Label
