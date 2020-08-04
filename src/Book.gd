extends Area2D

var time = 0;

func _ready():
	monitorable = true;

func _process(_delta):
	self.translate(Vector2(-1,0));

	time += 1;
	var movement = Vector2(0, sin(time));
	for child in get_children()[1].get_children():
		child.translate(movement);
		movement = movement * -1
