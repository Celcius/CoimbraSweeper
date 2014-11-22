package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class Grass extends Tile
{
	public function new (X:Float , Y:Float)
	{
		super(X,Y, "grass");
		loadGraphic( "assets/images/tiles/Grass_Block.png", true, 101, 171);
	}
}