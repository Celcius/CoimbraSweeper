package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class FlagSprite extends FlxSprite
{

	public function new (X:Float , Y:Float)
	{
		super(X,Y);
		loadGraphic("assets/images/flag.png");
	}
}