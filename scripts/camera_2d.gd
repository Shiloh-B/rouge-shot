extends Camera2D

const CAMERA_SPEED = 4500;

func _process(delta):
	if Input.is_key_pressed(KEY_W):
		position += Vector2.UP * delta * CAMERA_SPEED;
	if Input.is_key_pressed(KEY_A):
		position += Vector2.LEFT * delta * CAMERA_SPEED;
	if Input.is_key_pressed(KEY_D):
		position += Vector2.RIGHT * delta * CAMERA_SPEED;
	if Input.is_key_pressed(KEY_S):
		position += Vector2.DOWN * delta * CAMERA_SPEED;
	if Input.is_action_just_released("scroll_out"):
		zoom.x -= 0.1;
		zoom.y -= 0.1;
	if Input.is_action_just_released("scroll_in"):
		zoom.x += 0.1;
		zoom.y += 0.1;
