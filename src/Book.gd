extends Sprite

var time = 0;

# Called when the node enters the scene tree for the first time.
func _ready():
	pass;


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	self.translate(Vector2(-1,0));

	time += 1;
	var movement = Vector2(0, sin(time));
	for child in get_children():
		child.translate(movement);
		movement = movement * -1