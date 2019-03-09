extends Node2D

var player_words = [] # The number of words a player chooses
var current_story
var strings # All text shown to player

func _ready():
	set_random_story()
	strings = get_from_json("other_strings.json")
	
	$Blackboard/StoryText.text = strings["intro_text"]
	prompt_player()
	
	$Blackboard/TextBox.clear()
	$Blackboard/TextBox.grab_focus() # Edit suggested by Keith/Udemy

func set_random_story():
	var stories = get_from_json("stories.json")
	
	randomize()
	current_story = stories [randi() % stories.size()]

func get_from_json(filename):
	var file = File.new() # The file object
	file.open(filename, File.READ) # Assumes the file exists
	
	var text = file.get_as_text()
	var data = parse_json(text)
	file.close()
	return data

func _on_TextureButton_pressed():
	if is_story_done():
		get_tree().reload_current_scene()
	else:
		var new_text = $Blackboard/TextBox.text
		_on_TextBox_text_entered(new_text)
		$Blackboard/TextBox.grab_focus()
	
func _on_TextBox_text_entered(new_text):
	player_words.append(new_text)
	$Blackboard/TextBox.clear()
	next_action()

func is_story_done():
	return player_words.size() == current_story.prompt.size() # Passes this information to whichever function just called this

func prompt_player():
	var next_prompt = current_story["prompt"][player_words.size()]
	$Blackboard/StoryText.text += (strings["prompt"] % next_prompt)
	
func next_action():
	if is_story_done():
		tell_story()
	else:
		prompt_player()

func tell_story():
	$Blackboard/StoryText.text = current_story.story % player_words
	$Blackboard/TextureButton/ButtonLabel.text = strings["again"]
	end_game()
	
func end_game():
	$Blackboard/TextBox.queue_free()
	