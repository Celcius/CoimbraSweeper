package game.levels;

class Level1 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "ttttttttttt",
        "ttttttttttt",
		"ttttt.ttttt",
        "t..t..ttt_t",
		"t.P.B.*..bt",
        "t..t._...*t",
		"ttttttt..tt",
        "ttttttttttt",
    ];
	
	/*
	        "SSSSSSSwSSSSSSSSSwSSSS",
        "#___#*#v####*####v####",
        "#_*_t#tv#*######tvt###",
        "#___###v##^##t##tvtt##",
        "#PB####>>>^##**ttvtt##",
        "######ttt#**###v<<####",
        "###########*##*v#ttt##",
        "##b#########*##t#ttt##",
		"######t#t###*##t#t#t##",
		"#######t####*##t#t#t##", */

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
