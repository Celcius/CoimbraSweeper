package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class Terrain extends Tile
{
	public function new (X:Float , Y:Float)
	{
		super(X,Y, "terrain");
		loadGraphic( "assets/images/tiles/Brown_Block.png", true, 101, 171);
	}
}