package menus;

import duckgame.*;

class PlayState extends flixel.FlxState
{
	private var duck:Duck;
	private var platforms:flixel.group.FlxGroup.FlxTypedGroup<flixel.FlxSprite>;

	override public function create()
	{
		super.create();

		platforms = new flixel.group.FlxGroup.FlxTypedGroup<flixel.FlxSprite>();
		add(platforms);

		var floor = new flixel.FlxSprite(0, flixel.FlxG.height - 20).makeGraphic(flixel.FlxG.width, 20, flixel.util.FlxColor.GREEN);
		floor.immovable = true;
		platforms.add(floor);

		var floor = new flixel.FlxSprite(0, flixel.FlxG.height - 60).makeGraphic(40, 20, flixel.util.FlxColor.BROWN);
		floor.immovable = true;
		floor.screenCenter(X);
		platforms.add(floor);

		var floor = new flixel.FlxSprite(0, flixel.FlxG.height - 90).makeGraphic(40, 20, flixel.util.FlxColor.BROWN);
		floor.immovable = true;
		floor.screenCenter(X);
		floor.x += 100;
		platforms.add(floor);

		add(duck = new Duck());
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		flixel.FlxG.collide(duck, platforms);
	}
}
