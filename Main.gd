extends Node2D

func _on_button_pressed():
	var sprite = Sprite.new();
	var y = randf() * 50 + 200;
	sprite.set_script(load('Sprite.gd'));
	var image = load("resources/monster.png");
	sprite.texture = image;
	sprite.translate(Vector2(1000,y));
	add_child(sprite);
	
