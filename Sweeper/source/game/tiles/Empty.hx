package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class Empty extends Tile
{
	public function new (X:Float , Y:Float)
	{
		super(X,Y, "empty");
		alpha = 0;
		explored = true;
		blocking = true;
		//makeGraphic( Width : Int , Height : Int , ?Color : Int , ?Unique : Bool , ?Key : String )
		//loadGraphic( "assets/images/tiles/Grass_Block.png", true, 101, 171);
	}
}