extends Camera2D

@onready var key_logo = $CanvasLayer/KeyLogo
@onready var love = $CanvasLayer/Love
@onready var love2 = $CanvasLayer/Love2
@onready var love3 = $CanvasLayer/Love3
@onready var love4 = $CanvasLayer/Love4
@onready var love5 = $CanvasLayer/Love5
@onready var game_over_scene = preload("res://game_over.tscn")  # Preload scene Game Over

func _ready():
	# Atur posisi gambar kunci di kanan atas
	key_logo.position = Vector2(get_viewport_rect().size.x - key_logo.texture.get_size().x - -700, 30)

	# Atur posisi sprite Love secara berurutan
	arrange_love_sprites()

	# Cek status segera setelah scene dimulai
	check_key_status()
	check_love_opacity()

	# Buat timer untuk mengecek status secara berkala
	var timer = Timer.new()
	timer.wait_time = 0.5  # Cek setiap 0.5 detik
	timer.one_shot = false
	timer.autostart = true
	timer.connect("timeout", Callable(self, "_on_timer_timeout"))
	add_child(timer)

# Fungsi untuk mengecek status kunci dari Global.key_founded
func check_key_status():
	print("Global.key_founded:", Global.key_founded)  # Debugging
	if "Area2D" in Global.key_founded:
		key_logo.modulate = Color(1, 1, 1, 1)  # Opacity 100%
	else:
		key_logo.modulate = Color(1, 1, 1, 0.5)  # Opacity 50%

# Fungsi untuk mengecek dan mengatur opacity dari sprite Love
func check_love_opacity():
	var level1_count = Global.character_died.count("Level1")
	match level1_count:
		1:
			love.modulate = Color(1, 1, 1, 0.5)
		2:
			love2.modulate = Color(1, 1, 1, 0.5)
		3:
			love3.modulate = Color(1, 1, 1, 0.5)
		4:
			love4.modulate = Color(1, 1, 1, 0.5)
		5:
			love5.modulate = Color(1, 1, 1, 0.5)
			show_game_over_screen()

# Fungsi untuk menampilkan halaman Game Over
func show_game_over_screen():
	var game_over_instance = game_over_scene.instance()
	get_tree().get_root().add_child(game_over_instance)

# Fungsi untuk mengatur posisi sprite Love secara berurutan
func arrange_love_sprites():
	var y_offset = 10
	for i in range(5):
		# Akses node dengan aman
		var love_sprite = $CanvasLayer.get_node_or_null("Love" + str(i + 1))
		if love_sprite:
			# Pastikan texture bukan null sebelum mengakses propertinya
			if love_sprite.has_method("get_texture") and love_sprite.texture:
				# Sesuaikan posisi sprite Love di layar dengan jarak yang benar
				love_sprite.position = Vector2(
					get_viewport_rect().size.x - love_sprite.texture.get_size().x - (120 + (i * 160)),  # 120 untuk margin, 160 untuk jarak antar sprite
					y_offset
				)
				y_offset += 40  # Jarak vertikal antar sprite
			else:
				print("Love" + str(i + 1) + " does not have a texture.")
		else:
			print("Node Love" + str(i + 1) + " not found.")

# Fungsi untuk dipanggil secara berkala oleh Timer
func _on_timer_timeout():
	check_key_status()
	check_love_opacity()
