#extends Control
#
#@onready var texture_rect: TextureRect = $TextureRect
#@onready var next_button: Button = $Button
#@onready var start_level = preload("res://level1.tscn") as PackedScene
#
## Daftar gambar yang akan ditampilkan
#var images = [
	#preload("res://game assets/1.jpg"),
	#preload("res://game assets/2.jpg"),
	#preload("res://game assets/3.jpg"),
	#preload("res://game assets/4.jpg"),
	#preload("res://game assets/5.jpg")
#]
#
#var current_image_index = 0
#
#func _ready():
	## Tampilkan gambar pertama
	#texture_rect.texture = images[current_image_index]
	#
	## Hubungkan tombol Next/Ready ke fungsi _on_next_button_pressed
	#next_button.connect("pressed", self, "_on_next_button_pressed")
#
#func _on_next_button_pressed():
	#if current_image_index < images.size() - 1:
		## Pindah ke gambar berikutnya
		#current_image_index += 1
		#texture_rect.texture = images[current_image_index]
		#
		## Jika mencapai gambar terakhir, ubah tombol menjadi "Ready"
		#if current_image_index == images.size() - 1:
			#next_button.text = "Ready"
	#else:
		## Jika tombol Ready ditekan, pindah ke level1.tscn
		#get_tree().change_scene_to_packed(start_level)
