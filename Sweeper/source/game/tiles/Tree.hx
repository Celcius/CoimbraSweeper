package game.tiles;

import flixel.FlxSprite;
import game.Tile;
import game.Game;

class Tree extends Tile
{
	private var grassSprite:Grass;

	private var collider:FlxSprite;

	public function new (X:Float , Y:Float)
	{
		super(X,Y-30, "tree");
		loadGraphic( "assets/images/tiles/Tree_Tall.png", true, 101, 171);

		grassSprite = new Grass(X,Y);
		grassSprite.explored = true;
		explored = true;

		collider = new FlxSprite(X,Y+51);
		collider.makeGraphic(Math.floor(width), 81, 0x55FF0000);
		Game.instance.playerColliderGroup.add(collider);
		collider.immovable = true;
	}

	override public function draw():Void
	{
		grassSprite.draw();
		super.draw();
		collider.draw();
	}
}