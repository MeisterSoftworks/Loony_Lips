extends Node2D

var player_words = [] # The number of words a player chooses
var prompt = ["a name", "a thing", "a feeling", "a place", "another name"]
var story = "Once upon a time a %s went to see %s and started feeling very %s. Afterwards they went to a %s to meet their friend %s."

func _ready():
	$Blackboard/StoryText.text = ("Welcome to Loony Lips!\nCan I have " + prompt[player_words.size()] + ", please?")
	$Blackboard/TextBox.clear()
	$Blackboard/TextBox.grab_focus() # Edit suggested by Keith/Udemy

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
	return player_words.size() == prompt.size() # Passes this information to whatever function called this

func prompt_player():
	$Blackboard/StoryText.text = ("Can I have " + prompt[player_words.size()] + ", please?")
	
func next_action():
	if is_story_done():
		tell_story()
	else:
		prompt_player()

func tell_story():
	$Blackboard/StoryText.text = story % player_words
	$Blackboard/TextureButton/ButtonLabel.text = "Again!"
	end_game()
	
func end_game():
	$Blackboard/TextBox.queue_free()
	