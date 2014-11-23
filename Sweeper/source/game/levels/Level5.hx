package game.levels;

class Level5 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "ttttttttttttttttt",
		"tSS>>>>>>vv<<SSt",
		"tS>^<vvvb..>>^vSt",
		"t>>>^^vttt.>>^<<t",
		"t^>><<*.P_..>*<<t",
		"t^v<<<..B..>v>>^t",
		"t^<<v......>vv<<t",
		"tS^<>vv^>>v>*<<St",
		"tSS>^<<<<<>>^<SSt",
		"ttttttttttttttttt",
    ];

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
