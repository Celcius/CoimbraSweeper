package game.levels;

class Level3 extends Level
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
		"t_..._StvSt",
        "t..*..*..bt",
		"tt._....t_t",
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
