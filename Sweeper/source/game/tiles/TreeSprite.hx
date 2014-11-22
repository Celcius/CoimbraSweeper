package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class TreeSprite extends FlxSprite
{
	private var bombSprite:FlxSprite;

	public function new (X:Float , Y:Float)
	{
		super(X,Y);
		loadGraphic( "assets/images/tiles/Tree_Tall.png", true, 101, 171);
	}
}