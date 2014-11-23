package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class StoneWall extends Tile
{

	private var stoneWall:StoneWallSprite;

	public function new (X:Float , Y:Float)
	{
		super(X,Y, "stonewall");
		loadGraphic( "assets/images/tiles/Stone_Block.png", true, 101, 171);
		setExplored(false);
		this.blocking = true;

		stoneWall = new StoneWallSprite(X,Y-40);
		Game.instance.playerLayer.add(stoneWall);

		this.blocking = true;
	}
}