extends Node2D

@onready var tileMapLayer : TileMapLayer = $TileMapLayer;

var bounds : Rect2 = Rect2(Vector2.ZERO, Vector2(50,50));

func _ready():
	var walker: Walker = Walker.new(bounds);
	var tiles = walker.walk();
	tileMapLayer.set_cells_terrain_connect(tiles, 0, 0);
