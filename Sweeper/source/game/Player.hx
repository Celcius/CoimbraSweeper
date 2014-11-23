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

	var isStopped : Bool = false;
	var canMove:Bool = true;

	private var SPRITE_WIDTH = 92;
	private var SPRITE_HEIGHT = 99;

	var horDiff:Float = Game.BLOCK_WIDTH;
	var verDiff:Float = Game.BLOCK_HEIGHT;

	var horMove:Float = 0.0;
	var verMove:Float = 0.0;


	public function new(X:Float, Y:Float)
	{
		super(X + (Game.BLOCK_WIDTH - SPRITE_WIDTH) / 2, Y + 25);
		loadGraphic("assets/images/ranger_sheet.png", false, SPRITE_WIDTH, SPRITE_HEIGHT);

		this.animation.add("iddle", [0, 1, 2,3,4,5,6,7,8,9,10,11,12], 5, true);
		this.animation.play("iddle");
		anchor = new FlxSprite(anchorX, anchorY);
		anchor.makeGraphic(2,2, 0xFFFF0000);


		Reg.player = this;
	}

	override public function update():Void
	{
		super.update();

		if (isStopped)
			return;


		horMove = 0.0;
		verMove = 0.0;

		if (canMove)
		{
			for (swipe in FlxG.swipes)
			{
				var distance:Float = swipe.distance;

				if (distance < 50)
					continue;

				var angle:Float = swipe.angle;

				if (angle > -30 && angle < 30)
					verMove = -verDiff;
				else if (angle > 150 || angle < -150) // edge case
					verMove = verDiff;
				else if (angle > -120 && angle < -60)
					horMove = -horDiff;
				else if (angle > 60 && angle < 120)
					horMove = horDiff;
			}

			if (horMove == 0 && verMove == 0)
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

		if (Game.instance.isBomb( currentTile) )
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

		var aTile:Tile = Game.instance.getTileFromWorld(this.anchorX + horMove, this.anchorY + verMove);

		if (aTile.blocking)
			return false;

		var bear:Bear = Reg.bear;
		var bTile:Tile = Game.instance.getTileFromWorld(bear.anchorX, bear.anchorY);

		if (aTile == bTile)
		{
			var cTile:Tile = Game.instance.getTileFromWorld(bear.anchorX + horMove, bear.anchorY + verMove);
			if (cTile.blocking)
				return false;

			bear.redirectBear(ANIMATION_DURATION, horMove, verMove);
		}

		return true;
	}

	override public function draw():Void
	{
		super.draw();
		//anchor.draw();
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
	}

}