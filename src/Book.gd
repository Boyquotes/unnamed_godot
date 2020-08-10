extends Monster

var time = 0;
var health = 10;

var sprite;
var hp;
var hp_damage;

func _ready():
	monitorable = true;
	sprite = get_child(0);
	hp = get_child(2);

func _process(_delta):
	self.translate(Vector2(-1,0));
	time += 1;
	var movement = Vector2(0, sin(0.5 * time));
	for child in get_child(0).get_children():
		child.translate(movement);
		movement = movement * -1

func take_damage(damage):
	health -= damage;
	if damage > 0:
		if !hp_damage:
			hp_damage = Line2D.new();
			hp_damage.width = 5;
			hp_damage.default_color = Color(1,0,0);
			hp_damage.points = [Vector2(100,10), Vector2(100,10)];
			hp.add_child(hp_damage);
		hp_damage.points[1] = Vector2(min(180, 100 + (8 * (10 - health))),10);
	if(health <= 0):
		self.die();

func die():
	set_process(false);
	while sprite.modulate.a > 0:
		var opacity = sprite.modulate.a - 0.1;
		sprite.modulate.a = opacity
		hp.modulate.a = opacity
		yield(get_tree(), "idle_frame");
	self.queue_free();
