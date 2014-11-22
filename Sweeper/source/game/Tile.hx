package game;

import flixel.FlxSprite;

class Tile extends FlxSprite
{

    private var className:String = "";

    private var _underSprite:Tile;

	public function new(X:Float, Y:Float, name:String)
	{
		super (X, Y);
		className = name;


		//loadGraphic( "assets/images/tiles/Stone_Block.png", true, 101, 171);
	}
}