package game;

import flixel.FlxSprite;

class Tile extends FlxSprite
{
	public function new(X:Float, Y:Float, tilename:String)
	{
		super (X, Y);
		loadGraphic( "assets/images/tiles/"+tilename+".png", true, 101, 171);
	}
}