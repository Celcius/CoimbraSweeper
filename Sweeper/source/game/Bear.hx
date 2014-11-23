package game ;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.util.FlxPoint;
import game.tiles.Bed;
import haxe.macro.Expr.Var;
import game.tiles.Water;

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

	private var currentTile:Tile;

	public function new(X:Float, Y:Float)
	{
		super(X + (Game.BLOCK_WIDTH - SPRITE_WIDTH) / 2, Y - 25);
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

		updateDirection(duration, horMove, verMove);

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
		currentTile = Game.instance.getTileFromWorld(anchorX, anchorY);
		
		
		if (Game.instance.isBomb( currentTile ))
		{
			Game.instance.killBear();
		}
		
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

		currentTile = Game.instance.getTileFromWorld(anchorX, anchorY);
		
		if (Game.instance.isBed(currentTile))
		{
			var bed:Bed = cast (currentTile, Bed);
			bed.sleep();

			Game.instance.finishGame();
		}

		if (currentTile.className == "water" && canMove){
			var horDiff:Float = Game.BLOCK_WIDTH;
			var verDiff:Float = Game.BLOCK_HEIGHT;
			var horMove:Float = 0.0;
			var verMove:Float = 0.0;

			switch(cast(currentTile,Water).direction){
				case Water.LEFT: horMove = -horDiff;
				case Water.RIGHT: horMove = horDiff;
				case Water.UP: verMove = -verDiff;
				case Water.DOWN: verMove = verDiff;
			}

			if (shouldMove(horMove, verMove))
				updateDirection(0.5, horMove, verMove);
		}

	}

	private function shouldMove(horMove:Float, verMove:Float):Bool
	{
		if (horMove == 0 && verMove == 0)
			return false;

		var aTile:Tile = Game.instance.getTileFromWorld(this.anchorX + horMove, this.anchorY + verMove);

		if (aTile.blocking)
			return false;

		var player:Player = Reg.player;
		if (player != null)
		{
				
			var bTile:Tile = Game.instance.getTileFromWorld(player.anchorX, player.anchorY);

			if (aTile == bTile)
				return false;
		}

		return true;
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