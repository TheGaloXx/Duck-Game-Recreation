package;

class Paths
{
	public static function getPath(file:String, type:openfl.utils.AssetType, library:Null<Library>)
	{
		if (library != null)
			return getLibraryPath(file, library);

		return getPreloadPath(file);
	}

	static public function getLibraryPath(file:String, library:Library = PRELOAD)
	{
		return getLibraryPathForce(file, library);
	}

	inline static function getLibraryPathForce(file:String, library:Library)
	{
		return '${libraryToString(library)}:assets/${libraryToString(library)}/$file';
	}

	inline static function getPreloadPath(file:String)
	{
		return 'assets/$file';
	}

	inline static public function file(file:String, type:openfl.utils.AssetType = TEXT, ?library:Library)
	{
		return getPath(file, type, library);
	}

	inline static public function txt(key:String, ?library:Library)
	{
		return getPath('data/$key.txt', TEXT, library);
	}

	inline static public function xml(key:String, ?library:Library)
	{
		return getPath('data/$key.xml', TEXT, library);
	}

	inline static public function json(key:String, ?library:Library)
	{
		return getPath('data/$key.json', TEXT, library);
	}

	static public function sound(key:String, ?library:Library)
	{
		return getPath('sounds/$key.ogg', SOUND, library);
	}

	inline static public function music(key:String, ?library:Library)
	{
		return getPath('music/$key.ogg', MUSIC, library);
	}

	inline static public function image(key:String, ?library:Library)
	{
		return getPath('images/$key.png', IMAGE, library);
	}

	inline static public function font(key:String)
	{
		return 'assets/fonts/$key';
	}

	inline static public function getSparrowAtlas(key:String, ?library:Library)
	{
		return flixel.graphics.frames.FlxAtlasFrames.fromSparrow(image(key, library), file('images/$key.xml', library));
	}

	inline static public function getPackerAtlas(key:String, ?library:Library)
	{
		return flixel.graphics.frames.FlxAtlasFrames.fromSpriteSheetPacker(image(key, library), file('images/$key.txt', library));
	}

	static public function jsonData(key:String, ?library:Library):Dynamic
	{
		try
		{
			return haxe.Json.parse(openfl.utils.Assets.getText(Paths.json(key, library)));
		}
		catch (e)
		{
			trace("AN ERROR OCCURRED parsing a JSON file: " + e.message + ".");
		}

		return null;
	}

	static public function libraryToString(library:Library):String
	{
		return Std.string(library).toLowerCase();
	}
}

enum Library
{
	PRELOAD;
	SHARED;
	DEFAULT; // ayo??
}
