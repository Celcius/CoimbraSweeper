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

	private var anchor:FlxSprite;

	public var isStopped: Bool = false;
	public var canMove:Bool = true;

	private var SPRITE_WIDTH = 91;
	private var SPRITE_HEIGHT = 136;

	public function new(X:Float, Y:Float)
	{
		super(X + (Game.BLOCK_WIDTH - SPRITE_WIDTH) / 2, Y - 75);
		loadGraphic("assets/images/bear_sheet.png", false, SPRITE_WIDTH, SPRITE_HEIGHT);
		
		this.animation.add("iddle", [0, 1, 2,3,4,5,6,7,8,9], 5, true);
		this.animation.play("iddle");

		this.immovable = true;
		Reg.bear = this;
	}

	public function redirectBear(duration:Float, horMove:Float, verMove:Float)
	{
		if (isStopped)
			return;

		if (horMove > 0)
			this.scale.x = 1;
		else if (horMove < 0)
			this.scale.x = -1;

		updateDirection(duration, horMove, verMove);

		Reg.rageBar.incrementRage();

		if (Reg.rageBar.isMaxRage())
		{
			Reg.rageBar.shouldUpdate(false);

			 Reg.game.killPlayerBear();

		}
	}

	public function updateDirection(duration:Float, horMove:Float, verMove:Float)
	{
		if (!canMove) return;

		if (this.velocity.x < 0)
			this.scale.x = -1;
		if (this.velocity.x > 0)
			this.scale.x = 1;

		if (duration != 0)
		{
			canMove = false;
			var xPath = this.x + horMove;
			var yPath = this.y + verMove;

			Actuate.tween(this, duration, { x:xPath, y:yPath } ).onComplete(this.setCanMove);
		}
	}

	public function setCanMove()
	{
		this.canMove = true;
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

		if (tile.className == "water" && canMove){

		}

	}

	public var anchorX(get, never):Float;

	function get_anchorX() {
		return x + width/2;
	}

	public var anchorY(get, never):Float;
	function get_anchorY() {
		return y + height-5;
	}

}