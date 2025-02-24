extends Node
class_name Walker
var rng = RandomNumberGenerator.new()

const DIRECTIONS : Array[Vector2] = [Vector2.RIGHT, Vector2.UP, Vector2.LEFT, Vector2.DOWN];
var current_direction: Vector2 = DIRECTIONS[0];
var current_position : Vector2 = Vector2(0,0); # TODO: Randomize starting position?
var steps_since_turn: int = 0;
var step_path : Array[Vector2] = [current_position];

var borders: Rect2 = Rect2();

func _init(bounds) -> void:
	borders = bounds;

func step() -> void:
	if rng.randf() < 0.4 || steps_since_turn > 10: # adjustable
		set_new_direction();
		steps_since_turn = 0;
	elif step_path.size() % 50 == 0:
		generate_room(Rect2(Vector2.ZERO, Vector2(8,8)));
	else:
		var new_position = current_position + current_direction;
		if borders.has_point(new_position):
			current_position = new_position;
			step_path.append(new_position);
			steps_since_turn += 1;
	
func set_new_direction() -> void:
	var directions = DIRECTIONS.duplicate()
	directions.erase(current_direction)
	current_direction = directions[rng.randi_range(0,2)]
	
func generate_room(size: Rect2) -> void: 
	for x in size.size.x:
		for y in size.size.y:
			step_path.append(Vector2(current_position.x + x,current_position.y + y));
	
func walk() -> Array[Vector2]:
	for i in 4000:
		step();
	return step_path;
