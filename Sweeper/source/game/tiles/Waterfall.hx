package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class Waterfall extends Tile
{
	public function new (X:Float , Y:Float)
	{
		super(X,Y+5, "waterfall");
		loadGraphic( "assets/images/tiles/WaterfallAnim.png", true, 101, 171);
		animation.add("flow", [1, 2, 3, 4, 5 ,6], 8, true);
		animation.play("flow");
		this.blocking = true;
	}
}