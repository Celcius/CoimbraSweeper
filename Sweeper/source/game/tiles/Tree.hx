package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class Tree extends Tile
{
	private var treeSprite:TreeSprite;

	private var collider:FlxSprite;

	public function new (X:Float , Y:Float)
	{
		super(X,Y, "tree");
		loadGraphic( "assets/images/tiles/Grass_Block.png", true, 101, 171);

		treeSprite = new TreeSprite(X,Y-30);
		Game.instance.playerLayer.add(treeSprite);

		this.blocking = true;
	}
}