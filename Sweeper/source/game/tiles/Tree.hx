package game.tiles;

import flixel.FlxSprite;
import game.Tile;
import game.Game;

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

		collider = new FlxSprite(X+5,Y+51+5);
		collider.makeGraphic(Math.floor(width)-10, 81-70, 0x99FF0000);
		Game.instance.playerColliderGroup.add(collider);
		collider.immovable = true;

		this.blocking = true;
	}
}