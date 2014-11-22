package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class Bomb extends Tile
{
	private var terrainSprite:Terrain;

	public function new (X:Float , Y:Float)
	{
		super(X,Y-10, "bomb");
		loadGraphic( "assets/images/tiles/Key.png", true, 101, 171);

		terrainSprite = new Terrain(X,Y);
		terrainSprite.explored = true;
		explored = true;
	}

	override public function draw():Void
	{
		terrainSprite.draw();
		super.draw();
	}
}