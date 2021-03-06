package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class WaterLeft extends Water
{
	public function new (X:Float , Y:Float)
	{
		super(X,Y, Water.LEFT);
		loadGraphic( "assets/images/tiles/WaterAnimHor.png", true, 101, 171);
		animation.add("flow", [6, 5, 4, 3, 2 ,1], 8, true);
		animation.play("flow");
	}
}