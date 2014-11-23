package game.levels;

class Level0B extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "TTTTTSvST",
		"TTTTTSvST",
        "tttttSvST",
		"TP..B.vTT",
        "tttttTvTT",
		"ttTttTvTT",
		"tttTtTbTT",
		"TTTTTTtTT",
        
    ];
	
    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
