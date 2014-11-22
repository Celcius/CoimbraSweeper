package ;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxPoint;
import haxe.macro.Expr.Var;

/**
 * ...
 * @author Ivo Capelo
 */
class Bear extends FlxGroup
{
	static var NORTH : FlxPoint = new FlxPoint(0, -1);
	static var SOUTH : Int  = new FlxPoint(0, 1);
	static var WEST : Int = new FlxPoint(-1, 0);
	static var EAST : Int  = new FlxPoint(1, ');
	var sprite : FlxSprite;
	var dir:
	
	public function new() 
	{
		super();
		sprite = new FlxSprite();
		sprite.loadGraphic("assets/images/bear.png");
		sprite.setSize(sprite.width * 3, sprite.height * 3);
		add(sprite);
		
	}
	
}