extends Node2D

@onready var tileMapLayer : TileMapLayer = $TileMapLayer;

var bounds : Rect2 = Rect2(Vector2.ZERO, Vector2(500, 500));

func _ready():
	generate_map();
	
func generate_map():
	var walker: Walker = Walker.new(bounds);
	var tiles = walker.walk();
	#tiles = tiles.reduce(func(accum, i):
		#var size = 5;
		#var arr = [];
		#var root = i * size;
		#for j in size:
			#for k in size:
				#arr.append(Vector2((root.x + j) - 1, (root.y + k) -1));
		#
		#accum.append_array(arr)
		#return accum;
	#,[]);
	tileMapLayer.set_cells_terrain_connect(tiles, 0, 0);
	
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("enter"):
		reset();
	
func reset():
	for x in bounds.size.x * 2:
		for y in bounds.size.y * 2:
			tileMapLayer.set_cell(Vector2(x,y));

	
	generate_map();
