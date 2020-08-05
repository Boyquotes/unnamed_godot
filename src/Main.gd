extends Node2D

var spawn_time = 10;
export (PackedScene) var Book;

func _process(_delta):
	spawn_time -= 1
	if spawn_time == 0:
		spawn_book();
		spawn_time = 80 + randi() % 30;

func spawn_book():
	var enemy = Book.instance();

	var window_size = get_viewport_rect().size;
	var y = randf() * (window_size.y / 15) + (window_size.y / 10);
	enemy.translate(window_size - Vector2(0, y));
	enemy.add_to_group('enemies');

	add_child(enemy);
	
