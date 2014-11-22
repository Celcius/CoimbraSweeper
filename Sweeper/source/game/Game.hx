package game;

import flixel.FlxG;
import flixel.text.FlxText;
import flixel.util.FlxRandom;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.FlxCamera;
import game.levels.Level;
import game.tiles.*;
import flixel.effects.particles.FlxParticle;
import flixel.effects.particles.FlxEmitter;

class Game extends FlxState {

    public static var instance:Game;

	private var player:Player;

    public static var BLOCK_WIDTH:Int = 101;
    public static var BLOCK_HEIGHT:Int = 83;

    private var gridW:Int;
    private var gridH:Int;
    public var _grid:Array<Array<Tile>>;
    private var _level:Level;

    private var numberGrid:Array<Array<Int>>;

    public static var GMAP:Map<String,Dynamic>;

    public static var _gridGroup:FlxSpriteGroup;

	public var _gameOver:Bool;

    public var playerColliderGroup:FlxGroup;


    public function new(level:Level)
    {
        super();
        _level = level;
        instance = this;

        playerColliderGroup = new FlxGroup();
    }

    override public function create():Void
    {

        GMAP = new Map<String, Dynamic>();
        GMAP.set('#', Grass);
        GMAP.set('_', Terrain);
        GMAP.set('*', Bomb);
        GMAP.set('t', Tree);
        GMAP.set('.', Empty);

        _gridGroup = new FlxSpriteGroup();
        add(_gridGroup);

		drawGrid(_level.getGrid());
        populateNumberGrid();

		createRageBar();
		createBear();

		_gameOver = false;
		
		player = new Player(BLOCK_WIDTH * 1, BLOCK_HEIGHT * 1.5);
		
		add(player);

		FlxG.camera.setBounds(BLOCK_WIDTH , 0, (_grid[0].length - 1) * BLOCK_WIDTH, _grid.length* BLOCK_HEIGHT, true);
		FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN, 1);

		Reg.game = this;
        super.create();
    }

    private function drawGrid(grid:Array<String>):Void
    {
        _grid = new Array<Array<Tile>>();
        gridW = grid.length;
        for( i in 0... grid.length)
        {
            var row = grid[i];
            _grid[i] = new Array<Tile>();
            for ( j in 0...row.length )
            {
                var classType= GMAP.get(row.charAt(j));
                var tile:Tile = Type.createInstance(classType, [j*BLOCK_WIDTH, i*BLOCK_HEIGHT - 51] );
                _grid[i][j] = tile;
                _gridGroup.add(tile);
            }
            gridH = row.length;
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

	private function isBomb(tile:Tile):Bool
	{
		if (tile == null)
			return false;

		if (tile.className == "bomb")
			return true;

		return false;
	}

    public function getGridX(X:Float):Float
    {
        return Math.floor( X/BLOCK_WIDTH);
    }
    public function getGridY(Y:Float):Float
    {
        return Math.floor((Y+23)/BLOCK_HEIGHT);
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
        //trace("Player X="+getGridX(player.anchorX) + " Y="+getGridY(player.anchorY));

		if (_gameOver && FlxG.keys.anyPressed(["R"]))
		{
			for ( member in members)
				remove(member);
			create();
			return;
		}

        FlxG.collide(player, playerColliderGroup);
        super.update();
    }

	private function createRageBar():Void
	{
		Reg.rageBar = new RageBar();
		add(Reg.rageBar);
	}

	private function createBear():Void
	{
		Reg.bear = new Bear();
		add(Reg.bear);
		Reg.bear.y = FlxG.height / 2;
		Reg.bear.x = Reg.bear.width;

	}
	
	public function killPlayerBear():Void
	{
		if (!_gameOver)
		{
			var player : Player = Reg.player;
			bloodExplosion(player.x+ player.width/2 , player.y+ player.height/2 , 2);
			remove(Reg.player);
			gameOver("You woke the Bear!\nHis stomach feels warm...");
		}
	}

	public function killPlayerMine():Void
	{
		if (!_gameOver)
		{
			var player : Player = Reg.player;
			mineExplosion(player.x+ player.width/2 , player.y+ player.height/2, 2);
			remove(Reg.player);
			gameOver("You woke the Bear!\nWhen your torso flew into him...");
		}
	}
	
	public function killBear():Void
	{
		if (!_gameOver)
		{
			var bear : Bear = Reg.bear;
			bloodExplosion(bear.x + bear.width / 2 , bear.y + bear.height / 2 , 2);
			remove(Reg.bear);
			gameOver("You woke the Bear!\nFor the last time...");
		}
	}
	
	function gameOver(text : String) : Void
	{
		_gameOver = true;
		Reg.player.setStopped(true);
		Reg.bear.setStopped(true);
		
		var label1: FlxText = new FlxText(FlxG.width / 2, FlxG.height * 1 / 3, text,30);
		var label2: FlxText = new FlxText(FlxG.width / 2, FlxG.height * 3/ 6, "Press R to retry...", 25);
		
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
		label2.x -= label2.width / 2;
		label2.borderStyle = FlxText.BORDER_OUTLINE;
		label2.borderColor = 0xffffffff;
		label2.borderSize = 3;
		
		add(label1);
		add(label2);
		
	}
	
	public function bloodExplosion(x:Float,y:Float,depth:Int) : Void
	{
			var xp : Explosion =  new Explosion(x, y, depth);
			xp.createBloodParticles();
			add(xp);
			xp.start(Explosion.TIME_SPAN);
	}
	
	public function mineExplosion(x:Float,y:Float,depth:Int) : Void
	{
			var xp : Explosion =  new Explosion(x, y, depth);
			xp.createMineParticles();
			add(xp);
			xp.start(Explosion.TIME_SPAN);
	}
}