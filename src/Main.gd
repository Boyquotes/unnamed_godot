extends Node2D

var game_time;
var spawn_times = [10, 150, 300, 500];

func _ready():
	game_time = 0;

func _process(_delta):
	game_time += 1
	if spawn_times.has(game_time):
		spawn_book();

func spawn_book():
	var enemy = Area2D.new();
	var book = Sprite.new();
	enemy.set_script(load('src/Book.gd'));
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

	var collision = CollisionShape2D.new();
	var rect = RectangleShape2D.new();
	rect.extents = Vector2(40,50);
	collision.shape = rect;

	enemy.add_child(collision);
	enemy.add_child(book);

	enemy.add_to_group('enemies');

	add_child(enemy);
	
