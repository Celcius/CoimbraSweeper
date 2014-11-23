package game.levels;

class Level4 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "ttttttttttttttttt",
		"tSS>>>>>v<<<<<SSt",
		"tS>^<vvvb..>>^vSt",
		"t>>>^^vttt.>>^<<t",
		"t^>><<*P...>....t",
		"t^v<<<..B..>v...t",
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