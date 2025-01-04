extends Node2D

@onready var character_body = $Character_Body
@onready var water_collision = $Water_Collision
@onready var animated_sprite = character_body.get_node("AnimatedSprite2D")  # Akses node animasi dari karakter

var initial_position = Vector2()  # Posisi awal karakter
var is_dying = false  # State untuk melacak apakah karakter sedang dalam animasi "die"

func _ready():
	# Simpan posisi awal karakter
	initial_position = character_body.position
	
	# Hubungkan sinyal Water_Collision
	water_collision.body_entered.connect(on_water_collision_body_entered)

# Ketika karakter bersentuhan dengan air
func on_water_collision_body_entered(body):
	if body == character_body and not is_dying:
		handle_character_death()

# Fungsi untuk menangani kematian karakter
func handle_character_death():
	is_dying = true
	play_animation("die")
	print("Animation 'die' is playing")
	
	# Tambahkan nama node ke dalam Global.character_died
	if self.name not in Global.character_died:
		Global.character_died.append(self.name)
		print("Global.character_died setelah ditemukan: ", Global.character_died)
	
	# Track the death in Global.gd
	if Global.track_character_death("Level1"):
		# If game over is triggered, we can do additional actions like stopping the game
		print("Game Over triggered!")

	await get_tree().create_timer(0.1).timeout
	print("Animation 'die' completed")
	
	character_body.position = initial_position
	play_animation("idle")
	is_dying = false  # Reset state ke "tidak mati"

# Fungsi pemutar animasi untuk menjaga konsistensi
func play_animation(animation_name):
	# Periksa jika animasi saat ini berbeda dari animasi yang ingin dimainkan
	if animated_sprite.animation != animation_name:
		animated_sprite.play(animation_name)
