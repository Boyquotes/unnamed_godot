extends KinematicBody2D

var time;

func _ready():
	time = 0;

func _process(_delta):
	time += 1;
	self.translate(Vector2(-1,0));
	
	var rotation_value = 0.03 * cos(0.1 * time);
	for child in get_child(0).get_children():
		if child is Sprite:
			child.rotate(rotation_value * -1);
			for child_child in child.get_children():
				if child_child is Sprite:
					child_child.rotate(rotation_value);

			rotation_value = rotation_value * -1;
