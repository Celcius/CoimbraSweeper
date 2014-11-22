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
		loadGraphic("assets/images/bear_sheet.png", false, 96, 136);
		
		updateDirection(direction, 0, 0, 0);
		
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
			this.frame = framesData.frames[1];

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
					
	if (Game.instance.isBomb( Game.instance.getTile(Game.instance.getGridX(this.x + this.width/2), Game.instance.getGridY(this.y + this.height/2))))
		{
			Game.instance.killBear();
		}
	}
	
}