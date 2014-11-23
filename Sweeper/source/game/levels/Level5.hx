package game.levels;

class Level5 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "tttttttttttttttt",
		"tSS>>>>>vv<<<SSt",
		"tS>^<vvb..>>^vSt",
		"t>>^^vttt.>>^<<t",
		"t^><<*.P_..>*<<t",
		"t^v<<..B..>v>>^t",
		"t^<v......>vv<<t",
		"tS^>vv^>>v>*<<St",
		"tSS^<<<<<>>^<SSt",
		"tttttttttttttttt",
    ];

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
