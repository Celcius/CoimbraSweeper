package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class Tree extends Tile
{
	private var grassSprite:Grass;

	public function new (X:Float , Y:Float)
	{
		super(X,Y-30, "tree");
		loadGraphic( "assets/images/tiles/Tree_Tall.png", true, 101, 171);

		grassSprite = new Grass(X,Y);
	}

	override public function draw():Void
	{
		grassSprite.draw();
		super.draw();
	}
}