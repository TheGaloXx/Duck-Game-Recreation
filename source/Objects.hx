package;

import flixel.FlxG;
import flixel.util.FlxColor;

// THIS IS A MODIFICATION OF THE OPENFL FPS CLASS
#if !openfl_debug
@:fileXml('tags="haxe,release"')
@:noDebug
#end
class FPSCounter extends openfl.text.TextField
{
	public var currentFPS(default, null):Int;

	@:noCompletion private var cacheCount:Int;
	@:noCompletion private var currentTime:Float;
	@:noCompletion private var times:Array<Float>;

	public function new()
	{
		super();

		x = 10;
		y = 8;

		currentFPS = 0;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new openfl.text.TextFormat("_sans", 12, 0xFFFFFFFF);
		text = "FPS: ";
		defaultTextFormat.align = "left";
		defaultTextFormat.bold = true;

		cacheCount = 0;
		currentTime = 0;
		times = [];
	}

	@:noCompletion
	private override function __enterFrame(deltaTime:Float):Void
	{
		currentTime += deltaTime;
		times.push(currentTime);

		while (times[0] < currentTime - 1000)
		{
			times.shift();
		}

		var currentCount = times.length;
		currentFPS = Math.round((currentCount + cacheCount) / 2);

		if (currentCount != cacheCount)
			text = "FPS: " + currentFPS;

		cacheCount = currentCount;

		if (currentFPS < (flixel.FlxG.updateFramerate / 1.2))
			textColor = 0xFFFF0000;
		else
			textColor = 0xFFFFFFFF;
	}
}

class Error extends flixel.text.FlxText
{
	override public function new(message:String)
	{
		super(0, 100, flixel.FlxG.width, "", 64);

		autoSize = false;
		setFormat(null, 52, FlxColor.RED, CENTER, OUTLINE, FlxColor.BLACK);
		text = 'Error\n$message';
		screenCenter(X);
		borderSize = 4;
		active = false;

		flixel.tweens.FlxTween.tween(this, {alpha: 0, y: 0}, 1, {
			startDelay: 2,
			onComplete: function(_)
			{
				this.destroy();
				destroy();
			}
		});
	}
}
