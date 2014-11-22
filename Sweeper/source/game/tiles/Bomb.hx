package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class Bomb extends Tile
{
	private var bombSprite:FlxSprite;

	public function new (X:Float , Y:Float)
	{
		super(X,Y, "bomb");
		loadGraphic( "assets/images/tiles/Brown_Block.png", true, 101, 171);

		bombSprite = new FlxSprite(X,Y-15);
		bombSprite.loadGraphic( "assets/images/tiles/Key.png", true, 101, 171);
		Game.instance.playerLayer.add(bombSprite);
	}

	override public function draw():Void
	{
		super.draw();
	}
}