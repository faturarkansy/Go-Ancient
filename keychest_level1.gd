extends Area2D

var character_in_range = false
var chest_opened = false  # Variabel untuk memeriksa apakah chest sudah terbuka

# Referensi ke node OpenChestKey, OpenChest, CloseChest, dan Label interaksi
@onready var open_chest_key = $OpenChestKey
@onready var open_chest = $OpenChest
@onready var close_chest = $CloseChest
@onready var interact_label = $InteractLabel

func _ready():
	open_chest_key.hide()  # Sembunyikan chest terbuka sementara (OpenChestKey)
	open_chest.hide()  # Sembunyikan chest terbuka akhir (OpenChest)
	interact_label.hide()  # Sembunyikan label interaksi

	# Periksa apakah chest ini sudah pernah dibuka sebelumnya dari Global.key_founded
	if self.name in Global.key_founded:
		chest_opened = true  # Tandai chest sudah terbuka
		open_chest.show()  # Tampilkan chest dalam keadaan terbuka jika sebelumnya sudah dibuka
		close_chest.hide()  # Sembunyikan chest yang tertutup
		
# Fungsi untuk memproses input
func _process(delta):
	if character_in_range and Input.is_action_just_pressed("open_chest") and not chest_opened:
		open_chest_chest()

# Fungsi untuk membuka chest dan memberi kunci
func open_chest_chest():
	open_chest_key.show()  # Tampilkan sprite OpenChestKey
	close_chest.hide()  # Sembunyikan sprite CloseChest
	chest_opened = true  # Tandai chest sudah terbuka

	# Tambahkan nama chest ke dalam Global.key_founded
	if self.name not in Global.key_founded:
		Global.key_founded.append(self.name)
		print("Global.key_founded setelah ditemukan: ", Global.key_founded)  # Debugging

	# Dapatkan referensi ke karakter (Player) yang ada dalam jangkauan dan beri kunci
	var player = get_parent().get_node("Player")  # Pastikan path ke node Player benar
	if player:
		player.set_key_status(true)  # Ubah status kunci menjadi true
		hide_interaction_message()  # Sembunyikan pesan interaksi

	# Tunggu 2 detik sebelum menampilkan sprite OpenChest
	await get_tree().create_timer(2.0).timeout
	open_chest_key.hide()  # Sembunyikan sprite OpenChestKey
	open_chest.show()  # Tampilkan sprite OpenChest sebagai kondisi akhir

# Fungsi yang dipanggil saat karakter masuk ke dalam Area2D
func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):  # Pastikan karakter berada dalam group "Player"
		character_in_range = true
		if not chest_opened:
			show_interaction_message()

# Fungsi yang dipanggil saat karakter keluar dari Area2D
func _on_Area2D_body_exited(body):
	if body.is_in_group("Player"):  # Pastikan karakter keluar dari group "Player"
		character_in_range = false
		hide_interaction_message()

# Menampilkan pesan interaksi di layar
func show_interaction_message():
	interact_label.text = "Press F to Open"
	interact_label.show()

# Menghilangkan pesan interaksi di layar
func hide_interaction_message():
	interact_label.hide()
