package game.tiles;
import game.Tile;

/**
 * ...
 * @author Ivo Capelo
 */
class Bed extends Tile
{

	public function new (X:Float , Y:Float)
	{
		super(X,Y, "bed");

		loadGraphic("assets/images/bear_sheet.png", false, 91, 136);
		
		this.animation.add("iddle", [0], 5, true);
		this.animation.add("sleep", [1,2,3,4,5,6,7,8,9,10,11,12,13,14], 5, true);
		this.animation.play("iddle");
		
		this.blocking = true;
	}

	override public function draw():Void
	{
		super.draw();
	}
	
	public function sleep() : Void
	{
		this.animation.play("sleep");
	}
}