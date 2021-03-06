package game ;

import flixel.util.FlxSort;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxRandom;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.FlxObject;
import flixel.FlxCamera;
import flixel.util.FlxPoint;

import game.levels.Level;
import game.levels.Level0A;
import game.levels.Level0B;
import game.levels.Level0C;
import game.levels.Level1;
import game.levels.Level2;
import game.levels.Level3;
import game.levels.Level4;
import game.levels.Level5;
import game.levels.Level6;
import game.levels.Level7;
import game.levels.Level8;


import game.tiles.*;
import flixel.effects.particles.FlxParticle;
import flixel.effects.particles.FlxEmitter;
import haxe.macro.Expr.Var;
import flixel.input.touch.FlxTouch;

class Game extends FlxState {

    public static var instance:Game;

	private var player:Player;

    public static var BLOCK_WIDTH:Int = 100;
    public static var BLOCK_HEIGHT:Int = 83;

    private var gridW:Int;
    private var gridH:Int;
    public var _grid:Array<Array<Tile>>;
    private var _level:Level;

	private var _levels : Array<Level> = [new Level0A(), new Level0B(), new Level0C(), new Level1(), new Level2(), new Level3(), new Level7(), new Level8(), new Level4(), new Level5()];

	private var _levelIndex : Int = 0;

    private var numberGrid:Array<Array<Int>>;

    public static var GMAP:Map<String,Dynamic>;

    public static var _gridGroup:FlxSpriteGroup;

	public var _gameOver:Bool;
	public var _levelFinished:Bool;
    public var playerColliderGroup:FlxGroup;

    public var layers:FlxGroup;
    public var groundLayer:FlxGroup;
    public var playerLayer:FlxSpriteGroup;
    public var topLayer:FlxGroup;


    public function new(levelIndex : Int)
    {
        super();

		if (levelIndex >= _levels.length)
			levelIndex = _levels.length - 1;
		if (levelIndex < 0)
			levelIndex = 0;

			_levelIndex = levelIndex;
        _level = _levels[_levelIndex];

        instance = this;

    }

    override public function create():Void
    {
		loadLevel(_levelIndex);
        super.create();
    }

	function loadLevel(levelIndex:Int)
	{
	    instance = this;
		Reg.game = this;

		for ( member in members)
			remove(member);

		if (_levelIndex >= _levels.length)
		{
			FlxG.switchState(new GameOverScreen());
			return;
		}
		if (levelIndex < 0)
			levelIndex = 0;

			_levelIndex = levelIndex;
        _level = _levels[_levelIndex];

        groundLayer = new FlxGroup();
        playerLayer = new FlxSpriteGroup();
        topLayer = new FlxGroup();
        add(groundLayer);
        add(playerLayer);
        add(topLayer);

        playerColliderGroup = new FlxGroup();

        GMAP = new Map<String, Dynamic>();
        GMAP.set('.', Grass);
        GMAP.set('_', Terrain);
        GMAP.set('*', Bomb);
        GMAP.set('t', TreeSmall);
		GMAP.set('T', Tree);
        GMAP.set(' ', Empty);
		GMAP.set('b', Bed);

		GMAP.set('P', Grass); // player
		GMAP.set('B', Grass); // bear
		// PB joke again :D

		GMAP.set('>', WaterRight);
		GMAP.set('<', WaterLeft);
		GMAP.set('v', WaterDown);
		GMAP.set('^', WaterUp);
		GMAP.set('w', Waterfall);
		GMAP.set('S', StoneWall);


        _gridGroup = new FlxSpriteGroup();
        //add(_gridGroup);

		drawGrid(_level.getGrid());
        populateNumberGrid();
        discover(getGridX(player.anchorX), getGridY(player.anchorY));

		_levelFinished = false;

		_gameOver = false;

		FlxG.camera.setBounds(0 , 3 * BLOCK_HEIGHT / 5, _grid[0].length * BLOCK_WIDTH, _grid.length * BLOCK_HEIGHT, true);

		if (player != null)
			FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN, 1);
		else
			trace("Error: Failed to create player!!!");

		Reg.game = this;
	}

    private function drawGrid(grid:Array<String>):Void
    {
        _grid = new Array<Array<Tile>>();
        gridH = grid.length;
        for( i in 0... grid.length)
        {
            var row = grid[i];
            _grid[i] = new Array<Tile>();
            for ( j in 0...row.length )
            {
				var GMAPkey = row.charAt(j);
                var classType = GMAP.get(GMAPkey);

                var tile:Tile = Type.createInstance(classType, [getWorldX(j), getWorldY(i)] );
                _grid[i][j] = tile;
                _gridGroup.add(tile);
                groundLayer.add(tile);

				if (GMAPkey == 'P')
					createPlayer(j, i); // X=j, Y=i

				if (GMAPkey == 'B')
					createBear(j, i);

            }
            gridW = row.length;
        }

    }

    private function populateNumberGrid():Void
    {
		for( i in 0... _grid.length)
        {
            var _row = _grid[i];
            for ( j in 0... _row.length )
            {
                var tile:Tile = _grid[i][j];

				var numBombs:Int = countBombs(i, j);
				tile.number = numBombs;
				
				if (tile.className == "terrain")
				{
					tile.showNumber = true;
					tile.setExplored(true);
				}
            }
        }
    }

	private function countBombs(i:Int, j:Int):Int
	{
		var numBombs:Int = 0;

		var prevLine:Array<Tile> = null;
		if (i > 0)
			prevLine = _grid[i - 1];

		var thisLine = _grid[i];

		var nextLine:Array<Tile> = null;
		if (i < _grid.length - 1)
			nextLine = _grid[i + 1];

		// i - 1
		if (prevLine != null)
		{
			// j - 1
			if (j > 0)
				numBombs += isBomb(prevLine[j-1]) ? 1 : 0;
			// j
			numBombs += isBomb(prevLine[j]) ? 1 : 0;
			// j + 1
			if (j < prevLine.length - 1)
				numBombs += isBomb(prevLine[j+1]) ? 1 : 0;
		}

		// i
		// j - 1
		if (j > 0)
			numBombs += isBomb(thisLine[j-1]) ? 1 : 0;
		// j + 1
		if (j < thisLine.length - 1)
			numBombs += isBomb(thisLine[j+1]) ? 1 : 0;

		// i + 1
		if (nextLine != null)
		{
			// j - 1
			if (j > 0)
				numBombs += isBomb(nextLine[j-1]) ? 1 : 0;
			// j
			numBombs += isBomb(nextLine[j]) ? 1 : 0;
			// j + 1
			if (j < nextLine.length - 1)
				numBombs += isBomb(nextLine[j+1]) ? 1 : 0;
		}

		return numBombs;
	}

	public function isBomb(tile:Tile):Bool
	{
		if (tile == null)
			return false;

		if (tile.className == "bomb")
			return true;

		return false;
	}

	public function isBed(tile:Tile):Bool
	{
		if (tile == null)
		return false;

		return tile.className == "bed";

	}
    public function getGridX(X:Float):Int
    {
        return Math.floor( X/BLOCK_WIDTH);
    }
    public function getGridY(Y:Float):Int
    {
        return Math.floor((Y-3 * BLOCK_HEIGHT / 5)/BLOCK_HEIGHT);
    }

	public static function getWorldX(X:Int):Float
	{
		return Math.floor(X * BLOCK_WIDTH);
	}
	public static function getWorldY(Y:Int):Float
	{
		return Math.floor(Y * BLOCK_HEIGHT);
	}

	public function getTileFromWorld(X:Float, Y:Float):game.Tile
	{
		return getTile(getGridX(X), getGridY(Y));
	}

    public function getTile(X:Int, Y:Int):game.Tile
    {
        if (X >= 0 && X < gridW && Y >= 0 && Y < gridH){
            return _grid[Y][X];
        }
        return null;
    }

    /**
	 * Function that is called once every frame.
	 */
    override public function update():Void
    {
		if (_levelIndex >= _levels.length)
		{
			loadLevel(_levelIndex);
			return;
		}

        //trace("Player X="+getGridX(player.anchorX) + " Y="+getGridY(player.anchorY));


		if (_gameOver)
		{
#if android

		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
			{
#else
		if ( FlxG.keys.anyPressed(["R"]))
		{
#end
			loadLevel(_levelIndex);
			return;
		}
		#if android
			}
		#end

		}

		if (_levelFinished)
		{

			#if android

		for (touch in FlxG.touches.list)
		{
		if (touch.justPressed)
		{
#else
		if ( FlxG.keys.anyPressed(["SPACE"]))
		{
#end
			_levelIndex++;
				loadLevel(_levelIndex);
			return;
		}
		#if android
			}
		#end

		}



		checkFlagInput();

        //FlxG.collide(player, playerColliderGroup);

        super.update();

        playerLayer.sort(sortObjs, FlxSort.ASCENDING);
    }

    public static inline function sortObjs(Order:Int, Obj1:FlxObject, Obj2:FlxObject):Int
    {
        var obj1Offset =0;
        var obj2Offset =0;

        if (Std.is(Obj1, TreeSprite)){
            obj1Offset = 50;
        }
        if (Std.is(Obj2, TreeSprite)){
            obj2Offset = 50;
        }

        if (Std.is(Obj1, FlagSprite) && Std.is(Obj2, Bear)){
            obj1Offset = -80;
        }
        if (Std.is(Obj2, FlagSprite) && Std.is(Obj1, Bear)){
            obj2Offset = -80;
        }

        return FlxSort.byValues(Order, Obj1.y + obj1Offset, Obj2.y + obj2Offset);

}

	private function createBear(X:Int, Y:Int):Void
	{
		Reg.bear = new Bear(getWorldX(X), getWorldY(Y));
		playerLayer.add(Reg.bear);
	}

	private function createPlayer(X:Int, Y:Int)
	{
		player = new Player(getWorldX(X), getWorldY(Y));
		playerLayer.add(player);
	}

	public function killPlayerBear():Void
	{
		if (!_gameOver)
		{
			var player : Player = Reg.player;
			bloodExplosion(player.x+ player.width/2 , player.y+ player.height/2 , 1);

			#if android
				gameOver("You awoke the Bear!\nHis stomach feels warm...", "Press the forest to hire a new Ranger...");
			#else
				gameOver("You awoke the Bear!\nHis stomach feels warm...", "Press R to hire a new Ranger...");
			#end

			remove(Reg.player);
			Reg.player.destroy();
			Reg.player = null;
		}
	}

function checkFlagInput() : Void
{
#if android
	if (FlxG.touches.list.length == 1)
	{
		for (swipe in FlxG.swipes)
		{
			if (swipe.distance > 30)
				return;
		}
	
#else
	if (FlxG.mouse.justReleased)
	{
#end

		for ( x in 0 ... _grid.length)
			for (y in 0 ... _grid[x].length)
			{
				var x2 : Int = _grid.length - x - 1;
				var y2 : Int = _grid[x].length - y - 1;

				var tile:Tile = _grid[x2][y2];
				if (!tile.canPlantFlag())
					continue;



	#if android
			var touch:FlxTouch = FlxG.touches.getFirst();
			if (touch.justReleased && tile.pixelsOverlapPoint(new FlxPoint(touch.x, touch.y)))
			{
				
				tile.plantFlag();
				return;
			}
	#else


			if (tile.pixelsOverlapPoint(new FlxPoint(FlxG.mouse.x, FlxG.mouse.y)))
			{
				tile.plantFlag();
				return;
			}
	#end
		}
	}

}

public function killPlayerMine():Void
	{
		if (!_gameOver)
		{
			var player : Player = Reg.player;

			mineExplosion(player.x+ player.width/2 , player.y+ player.height/2, 2);

			#if android
				gameOver("You became Bear food!\nThe delicious smell awoke it...", "Press the forest to hire a new Ranger...");
			#else
				gameOver("You became Bear food!\nThe delicious smell awoke it...", "Press R to hire a new Ranger...");
			#end
			remove(Reg.player);
			Reg.player.destroy();
			Reg.player = null;
		}
	}

	public function killPlayerDrown():Void
	{
		if (!_gameOver)
		{
			var player : Player = Reg.player;
			waterExplosion(player.x+ player.width/2 , player.y+ player.height/2, 1);

			#if android
				gameOver("Don't you know Rangers can't swim...", "Press the forest to hire a new Ranger...");
			#else
				gameOver("Don't you know Rangers can't swim...", "Press R to hire a new Ranger...");
			#end
			remove(Reg.player);
			Reg.player.destroy();
			Reg.player = null;
		}
	}

	public function killBear():Void
	{
		if (!_gameOver)
		{
			
			var bear : Bear = Reg.bear;
			
			mineExplosion(bear.anchorX , bear.anchorY -17.5 , 1);

					#if android
				gameOver("You awoke the Bear!\nFor the last time...", "Press the forest to find a new Bear...");
			#else
				gameOver("You awoke the Bear!\nFor the last time...", "Press R to find a new Bear...");
			#end
			remove(Reg.bear);

            Reg.bear.destroy();
            Reg.bear = null;

		}
	}

	public function finishGame():Void
	{
		if (!_levelFinished)
		{
			Reg.bear.setStopped(true);
			Reg.player.setStopped(true);

			remove(Reg.bear);
			Reg.bear.destroy();
			Reg.bear = null;

		#if android
			endScreenLabel("You put the bear to sleep!\nFor now...", "Press the forest...");
		#else
			endScreenLabel("You put the bear to sleep!\nFor now...", "Press Space...");
		#end
			_levelFinished = true;
		}
	}

	function gameOver(text : String, text2 : String) : Void
	{
		_gameOver = true;
		Reg.player.setStopped(true);
		Reg.bear.setStopped(true);

			endScreenLabel(text, text2);
	}

	public function discover(tileX:Int, tileY:Int)
	{
		var tile:Tile = getTile(tileX, tileY);

		if (tile == null || tile.explored == true)
			return;

		if (tile.className == "grass" || tile.className == "terrain")
		{
			tile.setExplored(true);

			if (tile.number > 0)
				return;

			for (i in [ -1 , 0, 1])
				for (j in [ -1, 0, 1])
				{
					var tile:Tile = getTile(tileX + i, tileY + j);
					if ( tile != null && !tile.explored)
						discover(tileX + i, tileY + j);
				}
		}
	}

	function endScreenLabel(text1:String, text2:String):Void
	{

		var label1: FlxText = new FlxText(FlxG.width / 2, FlxG.height * 1 / 3, 0, text1,30);
		var label2: FlxText = new FlxText(FlxG.width / 2, FlxG.height * 3/ 6, 0, text2, 25);

		label1.color = 0xff000000;
		label1.scrollFactor.x = label1.scrollFactor.y = 0;
		label1.alignment = "center";
		label1.borderStyle = FlxText.BORDER_OUTLINE;
		label1.borderColor = 0xffffffff;
		label1.borderSize = 3;
		label1.x -= label1.width / 2;

		label2.color = 0xff000000;
		label2.scrollFactor.x = label2.scrollFactor.y = 0;
		label2.alignment = "center";
		label2.borderStyle = FlxText.BORDER_OUTLINE;
		label2.borderColor = 0xffffffff;
		label2.borderSize = 3;
		label2.x -= label2.width / 2;

		add(label1);
		add(label2);

	}
	public function bloodExplosion(x:Float,y:Float,depth:Int) : Void
	{
			var xp : Explosion =  new Explosion(x, y, 0);
			xp.createBloodParticles();
			add(xp);
			xp.setAlpha(1, 0.9, 0, 0);
			xp.setScale(1, 0.7, 0, 0);
			xp.start(true,Explosion.TIME_SPAN);
	}

	public function mineExplosion(x:Float,y:Float,depth:Int) : Void
	{
			var xp : Explosion =  new Explosion(x, y, 0);
			xp.createMineParticles();
			add(xp);
			xp.setAlpha(1, 0.9, 0, 0);
			xp.setScale(1, 0.7, 0, 0);
			xp.start(true, Explosion.TIME_SPAN);
	}


	public function waterExplosion(x:Float,y:Float,depth:Int) : Void
	{
			var xp : Explosion =  new Explosion(x, y, 0);
			xp.createWaterParticles();
			add(xp);
			xp.setAlpha(1, 0.9, 0, 0);
			xp.setScale(1, 0.7, 0, 0);
			xp.start(true, Explosion.TIME_SPAN);
	}


}