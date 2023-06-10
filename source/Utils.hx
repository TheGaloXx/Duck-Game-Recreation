package;

using StringTools;

class Utils
{
	/**
	 * Function that changes the `Discord Rich Presence`.
	 * @param   state   The second line in the presence (use it for info).
	 * @param   details   The first line in the presence (use for current state and details).
	 * @param   smallImageKey The small image name.
	**/
	public static function presence(state:String, details:String, smallImageKey:String, addLittleIcon:Bool = false)
	{
		#if DISCORD_CLIENT
		Discord.DiscordClient.changePresence(state, details, smallImageKey, addLittleIcon);
		#end
	}

	public static function firstLetterUpperCase(string:String):String
	{
		var firstLetter = string.charAt(0).toUpperCase();
		var restString = string.substring(1, string.length);
		var resultString = firstLetter + restString;
		return resultString.replace('-', ' ');
	}

	public static function title(state:String, deleteAppTitle:Bool = false)
	{
		var daTitle:String = "";
		if (!deleteAppTitle && Main.appTitle != null)
			daTitle = Main.appTitle;

		if (state == null || state == "")
			lime.app.Application.current.window.title = daTitle;
		else
			lime.app.Application.current.window.title = ('$daTitle - $state');
	}

	// Code from FNF': Psych Engine
	inline public static function boundTo(value:Float, min:Float, max:Float):Float
	{
		return Math.max(min, Math.min(max, value));
	}

	public static function glow(sprite:flixel.FlxSprite, blurX:Int = 50, blurY = 50, color:Int):Void
	{
		// long ass code for glow effect. Got it from https://haxeflixel.com/demos/FlxSpriteFilters
		flixel.graphics.frames.FlxFilterFrames.fromFrames(sprite.frames, blurX, blurY, [new openfl.filters.GlowFilter(color, sprite.alpha, blurX, blurY, 3)])
			.applyToSprite(sprite, false, true);
	}

	public static function middleSprite(staticSprite:flixel.FlxSprite, toMoveSprite:flixel.FlxSprite, axes:flixel.util.FlxAxes):Void
	{
		var x = (staticSprite.x + (staticSprite.width / 2)) - (toMoveSprite.width / 2);
		var y = (staticSprite.y + (staticSprite.height / 2)) - (toMoveSprite.height / 2);

		if (axes == X)
			toMoveSprite.x = x;
		else if (axes == Y)
			toMoveSprite.y = y;
		else if (axes == XY)
			toMoveSprite.setPosition(x, y);
	}

	public static function size(sprite:flixel.FlxSprite, mult:Float, updateHitbox:Bool = true, height:Bool = false):Void
	{
		if (!height)
			sprite.setGraphicSize(Std.int(sprite.width * mult));
		else
			sprite.setGraphicSize(0, Std.int(sprite.height * mult));

		if (updateHitbox)
			sprite.updateHitbox();
	}

	static public function alert(windowMessage:String, errorMessage:String):Void
	{
		#if !hl // for some reason it doesn't work on HashLink
		return lime.app.Application.current.window.alert(errorMessage, windowMessage);
		#else
		flixel.FlxG.state.add(new Objects.Error(errorMessage));
		#end
	}
}
