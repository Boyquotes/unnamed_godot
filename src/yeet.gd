extends Sprite

var active = false;
export (PackedScene) var Projectile;

func _process(_delta):
	pass;

func _input(_event):
	if !active && Input.is_action_pressed("mouse_click"):
		active = true;
		var projectile = randi() % 5;
		match projectile:
			0: create_projectile('apple', 1);
			1: create_projectile('orange', 1);
			2: create_projectile('burger', 3);
			3: create_projectile('television', 5);
			4: create_projectile('chair', 5);
		yield(get_tree().create_timer(0.5),"timeout");
		active = false;

func create_projectile(resource, damage):
	var projectile = Projectile.instance();
	for child in projectile.get_children():
		if child is Sprite:
			var projectile_texture = load('resources/' + resource + '.png');
			child.texture = projectile_texture;
			if resource == 'chair':
				child.apply_scale(Vector2(3,3));
			else:
				child.apply_scale(Vector2(2,2));
	get_parent().add_child(projectile);
	var position_node : Position2D = get_child(1);
	projectile.global_position = position_node.global_position;
	var mouse = get_global_mouse_position();
	projectile.set_init_values(randi() % 8 + 2, mouse, damage);
	return projectile;
