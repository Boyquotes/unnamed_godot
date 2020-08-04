extends Node2D

func _on_button_pressed():
	var book = Sprite.new();
	book.set_script(load('src/Book.gd'));
	var image = load("resources/book.png");
	book.texture = image;
	book.offset = Vector2(-21,-26);

	var window_size = get_viewport_rect().size;
	book.apply_scale(Vector2(2,2));
	var y = randf() * (window_size.y / 15) + (window_size.y / 10);
	book.translate(window_size - Vector2(0, y));

	var legs_image = load("resources/book_legs.png");
	var leg1 = Sprite.new();
	var leg2 = Sprite.new();
	leg1.texture = legs_image;
	leg2.texture = legs_image;
	leg1.offset = Vector2(-31,-3);
	leg2.offset = Vector2(-14,2);
	leg1.show_behind_parent = true;
	leg2.show_behind_parent = true;

	book.add_child(leg1);
	book.add_child(leg2);

	add_child(book);
	
