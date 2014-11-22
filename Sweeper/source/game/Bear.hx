package game ;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxPoint;
import haxe.macro.Expr.Var;

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
	
	var dir:FlxPoint = EAST;
	//var dir:
	
	public function new() 
	{
		super();
		loadGraphic("assets/images/bear_sheet.png", false, 96, 136);
		this.velocity = new FlxPoint( dir.x * SPEED, dir.y * SPEED);
		this.acceleration = new FlxPoint(0, 0);
		this.immovable = true;
	}
	
	public function redirectBear(newDir:FlxPoint)
	{
		this.acceleration = new FlxPoint(0,0);
		this.dir = newDir;
		this.velocity = new FlxPoint( dir.x * SPEED, dir.y * SPEED);
		
		if (this.velocity.x < 0)
			this.scale.x = -1;
		if (this.velocity.x > 0)
			this.scale.x = 1;
			
		Reg.rageBar.incrementRage();
		
		if (Reg.rageBar.isMaxRage())
		{
			Reg.rageBar.shouldUpdate(false);
			this.frame = framesData.frames[1];
		}
	}
	
}