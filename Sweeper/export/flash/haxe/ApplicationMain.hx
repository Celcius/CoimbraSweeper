import lime.Assets;
#if !macro


class ApplicationMain {
	
	
	public static var config:lime.app.Config;
	public static var preloader:openfl.display.Preloader;
	
	private static var app:lime.app.Application;
	
	
	public static function create ():Void {
		
		app = new openfl.display.Application ();
		app.create (config);
		
		var display = new flixel.system.FlxPreloader ();
		
		preloader = new openfl.display.Preloader (display);
		preloader.onComplete = init;
		preloader.create (config);
		
		#if js
		var urls = [];
		var types = [];
		
		
		urls.push ("assets/data/data-goes-here.txt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/images/images-go-here.txt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/images/player.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Brown_Block.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Character Boy.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Character Cat Girl.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Character Horn Girl.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Character Pink Girl.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Character Princess Girl.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Chest Closed.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Chest Lid.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Chest Open.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Dirt Block.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Door Tall Closed.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Door Tall Open.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Enemy Bug.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Gem Blue.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Gem Green.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Gem Orange.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Grass_Block.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Heart.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Key.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Plain Block.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Ramp East.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Ramp North.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Ramp South.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Ramp West.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Rock.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Roof East.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Roof North East.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Roof North West.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Roof North.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Roof South East.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Roof South West.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Roof South.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Roof West.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Selector.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Shadow East.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Shadow North East.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Shadow North West.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Shadow North.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Shadow Side West.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Shadow South East.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Shadow South West.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Shadow South.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Shadow West.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/SpeechBubble.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Star.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Stone Block Tall.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Stone Block.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Tree Short.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Tree Tall.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Tree Ugly.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Wall Block Tall.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Wall Block.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Water Block.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Window Tall.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/images/tiles/Wood Block.png");
		types.push (AssetType.IMAGE);
		
		
		urls.push ("assets/music/music-goes-here.txt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/sounds/sounds-go-here.txt");
		types.push (AssetType.TEXT);
		
		
		urls.push ("assets/sounds/beep.mp3");
		types.push (AssetType.MUSIC);
		
		
		urls.push ("assets/sounds/flixel.mp3");
		types.push (AssetType.MUSIC);
		
		
		
		preloader.load (urls, types);
		#end
		
		var result = app.exec ();
		
		#if sys
		Sys.exit (result);
		#end
		
	}
	
	
	public static function init ():Void {
		
		var loaded = 0;
		var total = 0;
		var library_onLoad = function (_) {
			
			loaded++;
			
			if (loaded == total) {
				
				start ();
				
			}
			
		}
		
		preloader = null;
		
		
		
		if (loaded == total) {
			
			start ();
			
		}
		
	}
	
	
	public static function main () {
		
		config = {
			
			antialiasing: Std.int (0),
			background: Std.int (0),
			borderless: false,
			depthBuffer: false,
			fps: Std.int (60),
			fullscreen: false,
			height: Std.int (480),
			orientation: "portrait",
			resizable: true,
			stencilBuffer: false,
			title: "Sweeper",
			vsync: true,
			width: Std.int (640),
			
		}
		
		#if js
		#if munit
		flash.Lib.embed (null, 640, 480, "000000");
		#end
		#else
		create ();
		#end
		
	}
	
	
	public static function start ():Void {
		
		openfl.Lib.current.stage.align = openfl.display.StageAlign.TOP_LEFT;
		openfl.Lib.current.stage.scaleMode = openfl.display.StageScaleMode.NO_SCALE;
		
		var hasMain = false;
		
		for (methodName in Type.getClassFields (Main)) {
			
			if (methodName == "main") {
				
				hasMain = true;
				break;
				
			}
			
		}
		
		if (hasMain) {
			
			Reflect.callMethod (Main, Reflect.field (Main, "main"), []);
			
		} else {
			
			var instance:DocumentClass = Type.createInstance (DocumentClass, []);
			
			if (Std.is (instance, openfl.display.DisplayObject)) {
				
				openfl.Lib.current.addChild (cast instance);
				
			}
			
		}
		
		openfl.Lib.current.stage.dispatchEvent (new openfl.events.Event (openfl.events.Event.RESIZE, false, false));
		
	}
	
	
	#if neko
	@:noCompletion public static function __init__ () {
		
		var loader = new neko.vm.Loader (untyped $loader);
		loader.addPath (haxe.io.Path.directory (Sys.executablePath ()));
		loader.addPath ("./");
		loader.addPath ("@executable_path/");
		
	}
	#end
	
	
}


#if flash @:build(DocumentClass.buildFlash())
#else @:build(DocumentClass.build()) #end
@:keep class DocumentClass extends Main {}


#else


import haxe.macro.Context;
import haxe.macro.Expr;


class DocumentClass {
	
	
	macro public static function build ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				
				var method = macro {
					
					this.stage = flash.Lib.current.stage;
					super ();
					dispatchEvent (new openfl.events.Event (openfl.events.Event.ADDED_TO_STAGE, false, false));
					
				}
				
				fields.push ({ name: "new", access: [ APublic ], kind: FFun({ args: [], expr: method, params: [], ret: macro :Void }), pos: Context.currentPos () });
				
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
	macro public static function buildFlash ():Array<Field> {
		
		var classType = Context.getLocalClass ().get ();
		var searchTypes = classType;
		
		while (searchTypes.superClass != null) {
			
			if (searchTypes.pack.length == 2 && searchTypes.pack[1] == "display" && searchTypes.name == "DisplayObject") {
				
				var fields = Context.getBuildFields ();
				var method = macro {
					return flash.Lib.current.stage;
				}
				
				fields.push ({ name: "get_stage", access: [ APrivate ], meta: [ { name: ":getter", params: [ macro stage ], pos: Context.currentPos() } ], kind: FFun({ args: [], expr: method, params: [], ret: macro :flash.display.Stage }), pos: Context.currentPos() });
				return fields;
				
			}
			
			searchTypes = searchTypes.superClass.t.get ();
			
		}
		
		return null;
		
	}
	
	
}


#end
