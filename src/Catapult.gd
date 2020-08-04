extends Sprite

var active = false;

func _process(_delta):
	var mouse = get_global_mouse_position();
	if(mouse.x > self.global_position.x):
		active = false;
		var new_rotation = (mouse.x - mouse.y) * -0.03;
		if(new_rotation < -20):
			new_rotation = -20
		self.rotation_degrees = new_rotation;

func _input(_event):
	if !active && Input.is_action_pressed("mouse_click"):
		active = true;
		var mouse = get_global_mouse_position();
		var projectile = randi() % 3;
		var object : Area2D;
		if(projectile == 0):
			object = create_projectile('apple');
		elif(projectile == 1):
			object = create_projectile('orange');
		elif(projectile == 2):
			object = create_projectile('burger');
		set_process(false);
		var power = 0
		var position_node : Position2D = get_child(0);
		while self.rotation_degrees < 60:
			power += 1;
			self.rotation_degrees = self.rotation_degrees + min(10,power);
			object.global_position = position_node.global_position;
			object.global_rotation_degrees = position_node.global_rotation_degrees;
			yield(get_tree(),"idle_frame");
		object.set_init_values(power, mouse);
		yield(get_tree().create_timer(0.5),"timeout");
		set_process(true);

func create_projectile(resource):
	var area = Area2D.new();
	var projectile = Sprite.new();
	var projectile_texture = load('resources/' + resource + '.png');
	projectile.texture = projectile_texture;
	projectile.apply_scale(Vector2(2,2));
	area.set_script(load('src/Projectile.gd'));
	area.add_child(projectile);
	get_parent().get_parent().add_child(area);
	return area;
