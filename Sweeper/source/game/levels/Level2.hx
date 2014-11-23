package game.levels;

class Level2 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "ttttttttttttt",
        "tttttttt___tt",
		"tttSt____*_*t",
        "tttt___***_*t",
		"tP___B_tb__tt",
        "tttt______ttt",
		"tttSttt*__*tt",
        "ttttttttttttt",
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
