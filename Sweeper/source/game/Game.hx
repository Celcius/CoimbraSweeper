package game;

import flixel.FlxG;
import flixel.FlxState;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.FlxCamera;

class Game extends FlxState {

	private var player:Player;
	
    public static var BLOCK_WIDTH:Int = 101;
    public static var BLOCK_HEIGHT:Int = 83;

    public static var GRID:Array<String> = [
        "#*##########",
        "#*##########",
        "############",
        "############",
        "############",
        "############",
        "############",
    ];

    private var numberGrid:Array<Array<Int>>;

    public static var GMAP:Map<String,String>;

    public static var _gridGroup:FlxSpriteGroup;


    override public function create():Void
    {
        GMAP = new Map<String, String>();
        GMAP.set('#', 'Grass_Block');
        GMAP.set('*', 'Brown_Block');

        _gridGroup = new FlxSpriteGroup();
        add(_gridGroup);

        drawGrid(GRID);
        populateNumberGrid(GRID);
		
		player = new Player(BLOCK_WIDTH * 0, BLOCK_HEIGHT * 1.5);
		add(player);
		
		FlxG.camera.follow(player, FlxCamera.STYLE_TOPDOWN, 1);


        super.create();
    }

    private function drawGrid(grid:Array<String>):Void
    {
        for( i in 0... grid.length)
        {
            var row = grid[i];
            for ( j in 0...row.length )
            {
                var tileName= GMAP.get(row.charAt(j));
                var tile:Tile = new Tile(i*BLOCK_WIDTH, j*BLOCK_HEIGHT - 51, tileName);
                _gridGroup.add(tile);
            }
        }
    }

    private function populateNumberGrid(grid:Array<String>):Void
    {

    }

    /**
	 * Function that is called once every frame.
	 */
    override public function update():Void
    {
        super.update();
    }
}