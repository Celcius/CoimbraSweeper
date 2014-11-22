package game;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.FlxCamera;
import flixel.util.FlxPoint;
import game.levels.Level;
import game.tiles.*;

class Game extends FlxState {

	private var player:Player;

    public static var BLOCK_WIDTH:Int = 101;
    public static var BLOCK_HEIGHT:Int = 83;

    public var _grid:Array<Array<Tile>>;
    private var _level:Level;

    private var numberGrid:Array<Array<Int>>;

    public static var GMAP:Map<String,Dynamic>;

    public static var _gridGroup:FlxSpriteGroup;


    public function new(level:Level)
    {
        super();
        _level = level;
    }

    override public function create():Void
    {

        GMAP = new Map<String, Dynamic>();
        GMAP.set('#', Grass);
        GMAP.set('_', Terrain);
        GMAP.set('*', Bomb);
        GMAP.set('t', Tree);
        GMAP.set('.', Empty);
		
		GMAP.set('P', Grass); // player

		GMAP.set('U', Grass); // bear
		GMAP.set('D', Grass); // bear
		GMAP.set('L', Grass); // bear
		GMAP.set('R', Grass); // bear

        _gridGroup = new FlxSpriteGroup();
        add(_gridGroup);

		drawGrid(_level.getGrid());
        populateNumberGrid();
		
		createRageBar();

		FlxG.camera.setBounds(0 , 3 * BLOCK_HEIGHT / 5, _grid[0].length * BLOCK_WIDTH, _grid.length * BLOCK_HEIGHT, true);
		
		if (player != null)
			FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN, 1);
		else
			trace("Error: Failed to create player!!!");

        super.create();
    }

    private function drawGrid(grid:Array<String>):Void
    {
        _grid = new Array<Array<Tile>>();
        for( i in 0... grid.length)
        {
            var row = grid[i];
            _grid[i] = new Array<Tile>();
            for ( j in 0...row.length )
            {
				var GMAPkey = row.charAt(j);
                var classType= GMAP.get(GMAPkey);
                var tile:Tile = Type.createInstance(classType, [getWorldX(j), getWorldY(i)] );
                _grid[i][j] = tile;
                _gridGroup.add(tile);
				
				if (GMAPkey == 'P')
					createPlayer(j, i); // X=j, Y=i
					
				if (GMAPkey == 'U' ||
					GMAPkey == 'D' ||
					GMAPkey == 'L' ||
					GMAPkey == 'R')
					createBear(j, i, GMAPkey);
            }
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

    public static function getGridX(X:Float):Float
    {
        return Math.floor( X/BLOCK_WIDTH);
    }
    public static function getGridY(Y:Float):Float
    {
        return Math.floor((Y+23)/BLOCK_HEIGHT);
    }
	
	public static function getWorldX(X:Int):Float
	{
		return Math.floor(X * BLOCK_WIDTH);
	}
	public static function getWorldY(Y:Int):Float
	{
		return Math.floor(Y * BLOCK_HEIGHT);
	}

    /**
	 * Function that is called once every frame.
	 */
    override public function update():Void
    {
        trace("Player X="+getGridX(player.anchorX) + " Y="+getGridY(player.anchorY));

        super.update();
    }

	private function createRageBar():Void
	{
		Reg.rageBar = new RageBar();
		add(Reg.rageBar);
	}

	private function createBear(X:Int, Y:Int, direction:String):Void
	{
		var dir:FlxPoint = null;
		if (direction == 'U')
			dir = Bear.NORTH;
		else if (direction == 'S')
			dir = Bear.SOUTH;
		else if (direction == 'L')
			dir = Bear.WEST;
		else if (direction == 'R')
			dir = Bear.EAST;
		
		Reg.bear = new Bear(dir);
		add(Reg.bear);
		
		Reg.bear.x = getWorldX(X);
		Reg.bear.y = getWorldY(Y);
	
	}
	
	private function createPlayer(X:Int, Y:Int)
	{
		player = new Player(getWorldX(X), getWorldY(Y));
		add(player);
	}
}