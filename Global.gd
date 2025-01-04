extends Node

var key_founded = []
var character_died = []
var love_opacity = [false, false, false, false, false]  # Keeps track of which "Love" sprites are set to 50%

func is_key_found(chest_name):
	return chest_name in key_founded

# Function to track death count and update opacity
func track_character_death(death_level):
	var level1_count = character_died.count("Level1")
	
	if level1_count < 5:
		character_died.append("Level1")
		
		# Update the opacity state
		if level1_count == 0:
			love_opacity[0] = true  # Love1 opacity set to 50%
		elif level1_count == 1:
			love_opacity[1] = true  # Love2 opacity set to 50%
		elif level1_count == 2:
			love_opacity[2] = true  # Love3 opacity set to 50%
		elif level1_count == 3:
			love_opacity[3] = true  # Love4 opacity set to 50%
		elif level1_count == 4:
			love_opacity[4] = true  # Love5 opacity set to 50%
			
	if level1_count >= 5:
		# Trigger game over after 5 deaths
		return true
	return false

# Function to reset death count but retain opacity values
func reset_deaths():
	character_died.clear()
