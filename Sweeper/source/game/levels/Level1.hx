package game.levels;

class Level1 extends Level
{
    public function new()
    {
        super();
    }

	public var _grid:Array<String> = [
        "#___#*#v####*#########",
        "#_*_t#tv#*######tvt###",
        "#___t##v##^##t##tvtt##",
        "#P##t#_>>>^##**ttvtt##",
        "###t##ttt#**###v<<####",
        "##*#*######*##*v#ttt##",
        "#Rb#########*##t#ttt##",
		"######t#t###*##t#t#t##",
		"#######t####*##t#t#t##",
    ];

    override public function getGrid():Array<String>
    {
        return _grid;
    }
}
