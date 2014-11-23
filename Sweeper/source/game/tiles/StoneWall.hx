package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class StoneWall extends Tile
{
	public function new (X:Float , Y:Float)
	{
		super(X,Y, "stonewall");
		loadGraphic( "assets/images/tiles/Stone_Block_Tall.png", true, 101, 171);
		setExplored(false);
		this.blocking = true;
	}
}