package game.tiles;

import flixel.FlxSprite;
import game.Tile;

class Terrain extends Tile
{
	public function new (X:Float , Y:Float)
	{
		super(X,Y, "terrain");
		loadGraphic( "assets/images/tiles/Dirt_Block.png", true, 101, 171);
	}

	override public function setExplored(explored:Bool):Void
	{
		var changed:Bool = this.explored!=explored;

		if (changed)
		{
			if (explored)
				loadGraphic( "assets/images/tiles/Brown_Block.png", true, 101, 171);
			else
				loadGraphic( "assets/images/tiles/Dirt_Block.png", true, 101, 171);
		}
		
		super.setExplored(explored);
	}
}