package game ;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxPoint;
import haxe.macro.Expr.Var;

import motion.Actuate;

/**
 * ...
 * @author Ivo Capelo
 */
class Bear extends FlxSprite
{


	public static var NORTH : FlxPoint = new FlxPoint(0, -1);
	public static var SOUTH : FlxPoint  = new FlxPoint(0, 1);
	public static var WEST : FlxPoint = new FlxPoint(-1, 0);
	public static var EAST : FlxPoint  = new FlxPoint(1, 0);
	public static var SPEED : Float = 5;
	
	public var isStopped: Bool = false;
	

	var dir:FlxPoint = EAST;
	
	public function new(direction:FlxPoint) 
	{
		super();
		Reg.bear = this;
		loadGraphic("assets/images/bear_sheet.png", false, 91, 136);
		
		updateDirection(direction, 0, 0, 0);
		
		this.animation.add("iddle", [0, 1, 2,3,4,5,6,7,8,9], 5, true);
		this.animation.play("iddle");
		this.immovable = true;
	}

	public function redirectBear(newDir:FlxPoint, duration:Float, horMove:Float, verMove:Float)
	{
		if (isStopped)
			return;

		updateDirection(newDir, duration, horMove, verMove);

		Reg.rageBar.incrementRage();

		if (Reg.rageBar.isMaxRage())
		{
			Reg.rageBar.shouldUpdate(false);

			 Reg.game.killPlayerBear();

		}
	}
	
	public function updateDirection(newDir:FlxPoint, duration:Float, horMove:Float, verMove:Float)
	{
		this.acceleration = new FlxPoint(0,0);
		this.dir = newDir;

		if (this.velocity.x < 0)
			this.scale.x = -1;
		if (this.velocity.x > 0)
			this.scale.x = 1;
			
		if (duration != 0)
		{
			var xPath = this.x + horMove;
			var yPath = this.y + verMove;

			Actuate.tween(this, duration, { x:xPath, y:yPath } );
		}
	}

	public function setStopped( stopped : Bool)
	{
		isStopped = stopped;
		if(stopped)
			this.velocity = new FlxPoint(0, 0);
		
	}
	
	public override function update() : Void
	{
		super.update();
		
		var tile : Tile = Game.instance.getTile(Game.instance.getGridX(this.x + this.width / 2), Game.instance.getGridY(this.y + this.height / 2));
		if (Game.instance.isBomb( tile ))
		{
			Game.instance.killBear();
		}
		else if (Game.instance.isBed(tile))
		{
			Game.instance.finishGame();
		}
	
	}
	
}