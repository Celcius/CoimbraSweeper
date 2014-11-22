package game.tiles;
import game.Tile;
import flixel.FlxSprite;

/**
 * ...
 * @author Ivo Capelo
 */
class Bed extends Tile
{
	private var bedSprite:FlxSprite;
	public function new (X:Float , Y:Float)
	{
		super(X,Y, "bed");
		loadGraphic( "assets/images/tiles/Grass_Block.png", true, 101, 171);

		bedSprite = new FlxSprite(x+5,y - 50);
		bedSprite.loadGraphic("assets/images/bed_sheet.png", false, 89, 176);
		bedSprite.animation.add("iddle", [0], 5, true);
		bedSprite.animation.add("sleep", [1,2,3,4,5,6,7,8,9,10,11,12,13], 5, true);
		bedSprite.animation.play("iddle");
		
		Game.instance.playerLayer.add(bedSprite);
		
		this.blocking = false;
		
	}

	override public function draw():Void
	{
		super.draw();
	}
	
	public function sleep() : Void
	{
		bedSprite.animation.play("sleep");
	}
	
}