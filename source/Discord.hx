package;

#if DISCORD_CLIENT
import discord_rpc.DiscordRpc;
using StringTools;

class DiscordClient
{
	public function new()
	{
		trace("Discord Client starting...");
		DiscordRpc.start({
			clientID: "1081628829094785084",
			onReady: onReady,
			onError: onError,
			onDisconnected: onDisconnected
		});

		trace("Discord Client started.");

		while (true)
		{
			DiscordRpc.process();
			Sys.sleep(2);
		}

		DiscordRpc.shutdown();
	}

	public static function shutdown()
	{
		DiscordRpc.shutdown();
	}

	static function onReady()
	{
		DiscordRpc.presence({
            state: null,
			details: null,
            startTimestamp: null,
            endTimestamp: null,
			largeImageKey: 'your discord icon here',
            largeImageText: null,
			smallImageKey: null,
            smallImageText: null,
            partyID: null,
            partySize: null,
            partyMax: null,
            joinSecret: null
		});
	}

	static function onError(_code:Int, _message:String)
	{
		trace('Error! $_code : $_message');
	}

	static function onDisconnected(_code:Int, _message:String)
	{
		trace('Disconnected! $_code : $_message');
	}

	public static function initialize()
	{
		var DiscordDaemon = sys.thread.Thread.create(() ->
		{
			new DiscordClient();
		});
		trace("Discord Client initialized");
	}

    /**
			 * Function that changes the `Discord Rich Presence`.
			 * @param   state   The second line in the presence (use it for info).
			 * @param   details   The first line in the presence (use for current state and details).
             * @param   smallImageKey The small image name.
    **/

	public static function changePresence(state:String, details:String, smallImageKey:String, addLittleIcon:Bool = false)
	{
		DiscordRpc.presence({
			state: state,
			details: details,
			largeImageKey: 'your game discord image',
            largeImageText: null,
			smallImageKey: smallImageKey,
            smallImageText: null, //these are unnecesary but whatever
            partyID: null,
            partySize: null,
            partyMax: null,
            joinSecret: null
		});
	}
}
#end