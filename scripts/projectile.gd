extends Area2D

@export var direction : String;
@export var speed = 400;
@export var damage = 10.0;

func _process(delta):
	var velocity = Vector2.ZERO;
	
	if direction == "right":
		velocity.x += 1;
	if direction == "left":
		velocity.x -= 1;
	if direction == "down":
		velocity.y += 1;
	if direction == "up":
		velocity.y -= 1;
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed;
	
	position += velocity * delta;
