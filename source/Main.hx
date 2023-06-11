package;

using StringTools;

class Main extends openfl.display.Sprite
{
	public static var appTitle:String = 'Duck Game Recreation';

	public function new()
	{
		super();
		//					1280 / 4      720 / 4
		addChild(new flixel.FlxGame(320, 180, substates.Start, 60, 60, true));
		addChild(new Objects.FPSCounter());

		#if debug
		flixel.addons.studio.FlxStudio.create();
		#end

		#if sys
		openfl.Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(openfl.events.UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end

		#if (hl && !debug)
		hl.UI.closeConsole();
		#end
	}

	// Code was entirely made by sqirra-rng for their fnf engine named "Izzy Engine", big props to them!!!
	#if sys
	private function onCrash(e:openfl.events.UncaughtErrorEvent):Void
	{
		var errMsg:String = "";
		var path:String;
		var callStack:Array<haxe.CallStack.StackItem> = haxe.CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		path = "./crash/" + 'crash_' + dateNow + ".txt";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += "\nUncaught Error: " + e.error + "\nPlease report this error to the dev team.\n\n> Crash Handler written by: sqirra-rng";

		if (!sys.FileSystem.exists("./crash/"))
			sys.FileSystem.createDirectory("./crash/");

		sys.io.File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + haxe.io.Path.normalize(path));

		lime.app.Application.current.window.alert(errMsg, "Error!");
		#if DISCORD_CLIENT
		DiscordClient.shutdown();
		#end
		Sys.exit(1);
	}
	#end
}
