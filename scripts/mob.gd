extends CharacterBody2D

@export var speed = 200;
@export var damage = 10;
@export var health = 100;

var isChasing = false;
var player = null;
var isTakingDamage = false;
var canTakeDamage = true;
var damageCooldown = 0.5;

func _process(delta):
	if(isChasing):
		var direction = (player.position - position).normalized();
		velocity = direction * speed;
		move_and_slide();



func _on_agro_area_body_entered(body):
	if(body.name == "Player"):
		player = body;
		isChasing = true;


func _on_agro_area_body_exited(body):
	isChasing = false;


func _on_damage_range_area_entered(area):
	if(area.is_in_group("Projectile")):
		self.health -= area.damage;
		%HealthBar.value -= area.damage;
		area.queue_free();
		if(self.health <= 0):
			self.queue_free();
