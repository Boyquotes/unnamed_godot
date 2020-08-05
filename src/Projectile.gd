extends Area2D

var rotation_value = 0;
var movement = Vector2(0,0);
var damage = 0;

func _process(_delta):
	self.rotation_degrees = self.rotation_degrees + rotation_value;
	self.global_translate(movement);
	movement = Vector2(movement.x, movement.y + 0.1);
	if self.global_position.x > 50:
		self.z_index = 3;

func set_init_values(rotate_value, mouse_value, damage_value):
	rotation_value = rotate_value;
	movement = Vector2(mouse_value.x * 0.01, (720 - mouse_value.y) * -0.01);
	damage = damage_value;

func _on_Projectile_area_entered(area):
	if area.is_in_group('enemies'):
		area.take_damage(damage);
	self.queue_free();
