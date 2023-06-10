package substates;

import flixel.FlxG;

class Start extends flixel.FlxState
{
	override function create()
	{
		#if debug
		saveCompiles();

		#if (!FLX_NO_SOUND_TRAY && !FLX_NO_SOUND_SYSTEM)
		FlxG.sound.volumeUpKeys = [PLUS, Q];
		#end
		#end

		#if DISCORD_CLIENT
		Discord.DiscordClient.initialize();
		Utils.presence('Playing', 'test');
		#end

		Utils.title(null);

		// flixel.system.FlxAssets.FONT_DEFAULT = Paths.font('Storytime.ttf', PRELOAD);
		FlxG.worldBounds.set(0, 0);
		flixel.FlxSprite.defaultAntialiasing = true;

		#if (!FLX_NO_SOUND_TRAY && !FLX_NO_SOUND_SYSTEM)
		FlxG.sound.muted = false;
		FlxG.sound.volume = 1;
		#end

		#if !FLX_NO_MOUSE
		FlxG.mouse.visible = FlxG.mouse.enabled = FlxG.mouse.useSystemCursor = true;
		#end

		FlxG.signals.preStateSwitch.add(function()
		{
			// FlxG.bitmap.dumpCache();
		});

		FlxG.signals.postStateSwitch.add(function()
		{
			//
		});

		lime.app.Application.current.onExit.add(function(exitCode)
		{
			#if DISCORD_CLIENT
			DiscordClient.shutdown();
			#end

			#if sys
			Sys.exit(1);
			#else
			openfl.system.System.exit(1);
			#end
		});

		FlxG.switchState(new menus.PlayState());

		super.create();
	}

	private function saveCompiles()
	{
		#if sys
		var GAME_NAME = lime.app.Application.current.meta.get('version'); // Change this to your game's folder name to save the times compiled

		var thePath = lime.system.System.desktopDirectory + 'Carpetas/Source Code/other/$GAME_NAME/compiles.galo';
		var compiles:Int = 0;

		trace('Path exists: ${sys.FileSystem.exists(thePath)}.');

		if (sys.FileSystem.exists(thePath))
			compiles = Std.parseInt(sys.io.File.getContent(thePath));

		trace("TIMES COMPILED: " + compiles);

		sys.io.File.saveContent(thePath, Std.string(compiles += 1));
		#end

		return;
	}
}
