package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class WaterUp extends Water
{
	public function new (X:Float , Y:Float)
	{
		super(X,Y, Water.UP);
	}
}