package game.levels;

class Level8 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [	
		"TttSvSSSSSTT",
		"TttS>>>>vSTT",
		"Ttb...*.vSST",
		"Ttt.t.t*>vST",
		"T.P.B..__vST",
		"TS>.tvt**<ST",
		"TS^......vST",
		"TS^SSSSSv<ST",
		"TS^<<<<<<SST",
		"TSvSSSSSSSTT",
    ];

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
