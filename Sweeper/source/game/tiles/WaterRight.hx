package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class WaterRight extends Water
{
	public function new (X:Float , Y:Float)
	{
		super(X,Y, Water.RIGHT);
		loadGraphic( "assets/images/tiles/WaterAnimHor.png", true, 101, 171);
		animation.add("flow", [1, 2, 3, 4, 5 ,6], 8, true);
		animation.play("flow");
	}
}