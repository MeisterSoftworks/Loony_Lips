extends Node2D

func _ready():
	var prompt = ["Jim", "UP", "excited", "Diner", "Susan"]
	var story = "Once upon a time a %s went to see %s and started feeling very %s. Afterwards they went to a %s to meet their friend %s."
	#get_node("Blackboard/StoryText").text = story % prompt
	$Blackboard/StoryText.text = story % prompt
	$Blackboard/TextBox.text = ""

func _on_TextureButton_pressed():
	var new_text = get_node("Blackboard/TextBox").text
	_on_TextBox_text_entered(new_text)
	
	
func _on_TextBox_text_entered(new_text):
	$Blackboard/StoryText.text = new_text
	$Blackboard/TextBox.text = ""
