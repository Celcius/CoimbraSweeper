package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class WaterDown extends Water
{
	public function new (X:Float , Y:Float)
	{
		super(X,Y, Water.DOWN);

		loadGraphic( "assets/images/tiles/WaterAnim_Vert.png", true, 101, 171);
		animation.add("flow", [1, 2, 3, 4, 5 ,6], 8, true);
		animation.play("flow");
	}
}