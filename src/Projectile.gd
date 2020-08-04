extends Area2D

var rotation_value = 0;
var movement = Vector2(0,0);

func _ready():
	var collision = CollisionShape2D.new();
	var circle = CircleShape2D.new();
	circle.radius = 5;
	collision.shape = circle;
	add_child(collision);
	monitoring = true;
	print_debug(connect('body_entered', self, '_on_Projectile_body_entered'));

func _process(_delta):
	self.rotation_degrees = self.rotation_degrees + rotation_value;
	self.global_translate(movement);
	movement = Vector2(movement.x, movement.y + 0.1);
	print(get_overlapping_bodies().size());

func set_init_values(rotate_value, mouse_value):
	rotation_value = rotate_value;
	movement = Vector2(mouse_value.x * 0.01, (720 - mouse_value.y) * -0.01);

func _on_Projectile_body_entered(area):
	print('Yes');
