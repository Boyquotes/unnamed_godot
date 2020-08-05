extends Sprite

var active = false;
export (PackedScene) var Projectile;

func _process(_delta):
	pass;

func _input(_event):
	if !active && Input.is_action_pressed("mouse_click"):
		active = true;
		var mouse = get_global_mouse_position();
		var projectile = randi() % 5;
		var object : Area2D;
		match projectile:
			0: object = create_projectile('apple');
			1: object = create_projectile('orange');
			2: object = create_projectile('burger');
			3: object = create_projectile('television');
			4: object = create_projectile('chair');
		var position_node : Position2D = get_child(1);
		object.global_position = position_node.global_position;
		object.set_init_values(randi() % 8 + 2, mouse);
		yield(get_tree().create_timer(0.5),"timeout");
		active = false;

func create_projectile(resource):
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
	return projectile;
