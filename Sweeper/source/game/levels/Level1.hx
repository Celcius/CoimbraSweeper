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
		"t..tt.ttttt",
        "t._t..ttt_t",
		"t.P.B.*..bt",
        "t_tt._...*t",
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
