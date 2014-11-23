package game.levels;

class Level2 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "SwwwSSSwwwS",
        "t>>>>v<<<<t",
		"tSSSSvSSSSt",
        "ttP.B>>>vSt",
		"t....tSSvSt",
        "t..*..*..bt",
		"tt._t...t_t",
        "ttttttttttt",

    ];
	/*
	 *         "t#t*ttttttt",
        "tP########t",
        "t#########t",
        "tB########t",
		"tb########t",
		"t#########t",
		"t#########t",
		"ttttttttttt",
		*/

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
