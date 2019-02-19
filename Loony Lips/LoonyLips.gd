extends Node2D

func _ready():
	var prompt = ["Jim", "UP", "excited", "Diner", "Susan"]
	var story = "Once upon a time a %s went to see %s and started feeling very %s. Afterwards they went to a %s to meet their friend %s."
	#get_node("Blackboard/StoryText").text = story % prompt
	$Blackboard/StoryText.bbcode_text = story % prompt