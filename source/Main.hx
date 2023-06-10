package;

import lime.app.Application;

using StringTools;

#if (sys && CRASH_HANDLER)
import haxe.CallStack.StackItem;
import haxe.CallStack;
import haxe.io.Path;
import lime.app.Application;
import openfl.Lib;
import openfl.events.UncaughtErrorEvent;
import sys.FileSystem;
import sys.FileSystem;
import sys.io.File;
import sys.io.File;
import sys.io.Process;
#end

class Main extends openfl.display.Sprite
{
	public static var appTitle:String = Application.current.meta.get('title');

	public function new()
	{
		super();
		addChild(new flixel.FlxGame(0, 0, substates.Start));
		addChild(new Objects.FPSCounter());

		#if debug
		flixel.addons.studio.FlxStudio.create();
		#end

		#if (sys && CRASH_HANDLER)
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end

		#if (hl && !debug)
		hl.UI.closeConsole();
		#end
	}

	// Code was entirely made by sqirra-rng for their fnf engine named "Izzy Engine", big props to them!!!
	#if (sys && CRASH_HANDLER)
	private function onCrash(e:UncaughtErrorEvent):Void
	{
		var errMsg:String = "";
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
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

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));

		Application.current.window.alert(errMsg, "Error!");
		#if DISCORD_CLIENT
		DiscordClient.shutdown();
		#end
		Sys.exit(1);
	}
	#end
}
