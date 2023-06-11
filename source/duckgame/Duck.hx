package duckgame;

class Duck extends flixel.FlxSprite
{
	private var gravity = 890;

	private var jumping = false;
	private var ducking = false;
	private var speed:Int = 100;

	override public function new()
	{
		super();

		loadGraphic(Paths.image('duck', PRELOAD), true, 22, 25);
		animation.add('idle', [0], 0);
		animation.add('walk', [1, 2, 3, 4, 5, 6], 12);
		animation.add('jump', [8], 0);
		animation.add('jumpEnd', [9], 0);
		animation.add('fly', [10], 0);
		animation.add('duck', [11], 0);
		animation.add('lay', [12], 0);
		animation.add('freeze', [13], 0);
		animation.add('emote', [14], 0);
		animation.play('idle');
		acceleration.y = gravity;
		screenCenter();
		setSize(10, 23);
		offset.set(6, 2);
	}

	private var anim:String = 'idle';

	override public function update(e)
	{
		input();

		if (velocity.y == 0)
			jumping = false;

		speed = (ducking ? 0 : 100);

		if (velocity.x != 0 && velocity.y == 0)
			anim = 'walk';
		else if (velocity.y != 0 && velocity.y < 0)
			anim = 'jump';
		else if (velocity.y != 0 && velocity.y > 0)
			anim = 'jumpEnd';
		else if (ducking && velocity.x == 0)
			anim = 'duck';
		else if (ducking && velocity.x != 0)
			anim = 'lay';
		else
			anim = 'idle';

		animation.play(anim);

		super.update(e);
	}

	private function jump()
	{
		if (jumping || ducking)
			return;

		jumping = true;
		velocity.y = -gravity / 3;
		trace('jumped');
	}

	private function input()
	{
		if (flixel.FlxG.keys.pressed.LEFT)
		{
			velocity.x = -speed;
			flipX = true;
		}
		else if (flixel.FlxG.keys.pressed.RIGHT)
		{
			velocity.x = speed;
			flipX = false;
		}
		else
			velocity.x = 0;

		if (flixel.FlxG.keys.pressed.UP)
			jump();

		if (flixel.FlxG.keys.pressed.DOWN)
		{
			ducking = true;
			acceleration.y = gravity * 1.5;
		}

		if (flixel.FlxG.keys.justReleased.DOWN)
		{
			ducking = false;
			acceleration.y = gravity;
		}
	}
}
