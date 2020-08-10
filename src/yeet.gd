extends Sprite

var active = false;
var door : Area2D;
var health = 20
var hp;
var hp_damage;
export (PackedScene) var Projectile;

func _ready():
	door = get_child(2);
	hp = get_child(3);

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

func _on_Door_area_entered(area):
	if area.is_in_group('enemies'):
		area.set_process(false);
		var time = 0;
		var sprite : Sprite = door.get_child(0);
		while door && door.get_overlapping_areas().size() > 0:
			time += 1;
			var movement = Vector2(0.6 * sin(time), 0.5 * sin(time));
			sprite.translate(movement);
			yield(get_tree(), "idle_frame");
			if time % 60 == 0:
				take_damage();
		
		if !door:
			get_parent().set_process(false);
			for enemy in get_tree().get_nodes_in_group('enemies'):
				enemy.die();

func take_damage():
	health -= 1;
	if !hp_damage:
		hp_damage = Line2D.new();
		hp_damage.width = 15;
		hp_damage.default_color = Color(1,0,0);
		hp_damage.points = [Vector2(70,-320), Vector2(70,-320)];
		hp.add_child(hp_damage);
	hp_damage.points[1] = Vector2(min(300, 70 + (11.5 * (20 - health))), -320);
	if health <= 0:
		while door.modulate.a > 0:
			var opacity = door.modulate.a - 0.1;
			door.modulate.a = opacity
			yield(get_tree(), "idle_frame");
		door.queue_free();
