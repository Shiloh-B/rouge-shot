extends CharacterBody2D

var projectile = preload("res://scenes/projectile.tscn");

@onready var healthBar = %HealthBar;

@export var speed = 400;
@export var projectileSpeed = 400;
@export var attackSpeed = 1.0;
@export var damageCooldown = 0.5;
@export var health = 100;

var projectileActive = true;
var canTakeDamage = true;
var isTakingDamage = false;
var damageTaken = 0;
var projectileCooldown = attackSpeed;

var screenSize;

func _ready():
	screenSize = get_viewport_rect().size;
	
func _process(delta):
	var velocity = Vector2.ZERO;
	if Input.is_action_pressed("move_right"):
		velocity.x += 1;
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1;
	if Input.is_action_pressed("move_down"):
		velocity.y += 1;
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1;
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed;
		
	position += velocity * delta;
	position = position.clamp(Vector2.ZERO, screenSize);
	
	projectileCooldown -= delta;
	damageCooldown -= delta;
	
	if(projectileCooldown <= 0):
		projectileActive = true;
		projectileCooldown = attackSpeed;
		
	if(damageCooldown <= 0):
		canTakeDamage = true;
		damageCooldown = 0.5;
	shoot();
	takeDamage();
	
func shoot():
	if(projectileActive):
		if Input.is_action_pressed("shoot_right"):
			var proj = generateProjectile("right");
		if Input.is_action_pressed("shoot_left"):
			var proj = generateProjectile("left");
		if Input.is_action_pressed("shoot_down"):
			var proj = generateProjectile("down");
		if Input.is_action_pressed("shoot_up"):
			var proj = generateProjectile("up");


func generateProjectile(direction):
	var projectileToShoot = projectile.instantiate();
	projectileToShoot.position = self.position;
	projectileToShoot.direction = direction;
	
	var offset = 40;
	if direction == "right":
		projectileToShoot.position.x += offset;
	if direction == "left":
		projectileToShoot.position.x -= offset;
	if direction == "down":
		projectileToShoot.position.y += offset;
	if direction == "up":
		projectileToShoot.position.y -= offset;
	get_parent().add_child(projectileToShoot);
	projectileActive = false;
	return projectileToShoot;

func takeDamage():
	if(isTakingDamage && canTakeDamage && self.health != 0):
		self.health -= damageTaken;
		canTakeDamage = false;
		healthBar.value -= damageTaken;


func _on_area_2d_body_entered(body):
	if(body.is_in_group("Mob")):
		isTakingDamage = true;
		damageTaken = body.damage;


func _on_area_2d_body_exited(body):
	if(body.is_in_group("Mob")):
		isTakingDamage = false;
		damageTaken = 0;


func _on_area_2d_area_entered(area):
	if(area.is_in_group("Upgrade")):
		match(area.upgradeType):
			"attack_speed":
				self.attackSpeed -= area.upgradeValue;
				area.queue_free();
