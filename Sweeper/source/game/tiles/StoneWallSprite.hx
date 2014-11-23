package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class StoneWallSprite extends FlxSprite
{
	public function new (X:Float , Y:Float)
	{
		super(X,Y);
		loadGraphic( "assets/images/tiles/Stone_Block.png", true, 101, 171);
	}
}