extends Node2D

var animation_player : AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	animation_player = get_node('AnimationPlayer')
	animation_player.play('Walking')

func _process(_delta):
	self.translate(Vector2(-0.4,0))