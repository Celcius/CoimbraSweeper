package game;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.util.FlxPoint;


import motion.Actuate;


/**
 * ...
 * @author ...
 */
class Player extends FlxSprite
{
	private static var ANIMATION_DURATION = 0.25;

	private var anchor:FlxSprite;

	public var collider:FlxSprite;
	public var colliderOffset:FlxPoint;

	private var oppositeAnchor:FlxPoint;

	var isStopped : Bool = false;
	var canMove:Bool = true;

	private var SPRITE_WIDTH = 68;
	private var SPRITE_HEIGHT = 78;


	public function new(X:Float, Y:Float)
	{
		super(X + (Game.BLOCK_WIDTH - SPRITE_WIDTH) / 2, Y + 25);
		loadGraphic( "assets/images/tiles/Character_Horn_Girl.png", true, SPRITE_WIDTH, SPRITE_HEIGHT);

		anchor = new FlxSprite(anchorX, anchorY);
		anchor.makeGraphic(2,2, 0xFFFF0000);
		anchor.makeGraphic(2, 2, 0xFFFF0000);


		Reg.player = this;

		oppositeAnchor = new FlxPoint();
	}

	override public function update():Void
	{
		super.update();

		if (isStopped)
			return;

		var horDiff:Float = Game.BLOCK_WIDTH;
		var verDiff:Float = Game.BLOCK_HEIGHT;

		var horMove:Float = 0.0;
		var verMove:Float = 0.0;

		if (canMove)
		{
			// left movement
			if (FlxG.keys.anyPressed(["A", "LEFT"]))
			{
				horMove = -horDiff;
			}
			else if (FlxG.keys.anyPressed(["D", "RIGHT"]))
			{
				horMove = horDiff;
			}
			else if (FlxG.keys.anyPressed(["W", "UP"]))
			{
				verMove = -verDiff;
			}
			else if (FlxG.keys.anyPressed(["S", "DOWN"]))
			{
				verMove = verDiff;
			}

			// check if should move - create action to move if yes
			if ( this.shouldMove(horMove, verMove) )
			{
				canMove = false;
				var xPath = this.x + horMove;
				var yPath = this.y + verMove;

				Actuate.tween(this, ANIMATION_DURATION, { x:xPath, y:yPath } ).onComplete(this.setCanMove);
			}

			anchor.x = anchorX;
			anchor.y = anchorY;
		}

		var currentTile:Tile = Game.instance.getTileFromWorld(anchorX, anchorY);
		if (currentTile != null){
			currentTile.setExplored(true);
		}

		super.update();

		if (Game.instance.isBomb( Game.instance.getTile(Game.instance.getGridX(anchorX), Game.instance.getGridY(anchorY))))
		{
			Game.instance.killPlayerMine();
		}
	}

	public function setCanMove()
	{
		this.canMove = true;
	}

	private function shouldMove(horMove:Float, verMove:Float):Bool
	{
		if (horMove == 0 && verMove == 0)
			return false;
		
		var aTile:Tile = Game.instance.getTileFromWorld(anchorX + horMove, anchorY + verMove);
		
		if (aTile.blocking)
		{
			trace("SELF BLOCK");
			return false;
		}
			
		var bear:Bear = Reg.bear;
		var bTile:Tile = Game.instance.getTileFromWorld(bear.x, bear.y);
			
		if (aTile == bTile)
		{
			trace("FOUND BEAR");
			
			var cTile:Tile = Game.instance.getTileFromWorld(bear.x + horMove, bear.y + verMove);
			if (cTile.blocking)
			{
				trace("BEAR BLOCK");
				return false;
			}
			
			bear.redirectBear(ANIMATION_DURATION, horMove, verMove);
		}
		
		return true;
	}

	override public function draw():Void
	{
		super.draw();
		anchor.draw();
	}

	public var anchorX(get, never):Float;

	function get_anchorX() {
		return x + width/2;
	}

	public var anchorY(get, never):Float;
	function get_anchorY() {
		return y + height-5;
	}

	public function setStopped(stopped : Bool):Void
	{
		isStopped = stopped;
		if(stopped)
			this.velocity  = new FlxPoint(0, 0);
	}

}