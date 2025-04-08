package;

/**
 * ToDo: Reference the following for something:
 * https://github.com/FunkinCrew/Funkin/blob/1.0.0/source/PlayState.hx#L258
 * https://github.com/JoaTH-Team/Rhythmo-SC/blob/bce12c9175ffed0b3ec0ca10b59499170a2eec4a/source/states/PlayState.hx
 */
class Conductor
{
	public static var bpm:Int = 100;
	public static var crochet:Float = ((60 / bpm) * 1000); // beats in milliseconds
	public static var stepCrochet:Float = crochet / 4; // steps in milliseconds
	public static var songPosition:Float;
	public static var lastSongPos:Float;
	public static var offset:Float = 0;

	public static var safeFrames:Int = 10;
	public static var safeZoneOffset:Float = (safeFrames / 60) * 1000; // is calculated in create(), is safeFrames in milliseconds

	public function new()
	{
	}

	public static function changeBPM(newBpm:Int)
	{
		bpm = newBpm;

		crochet = ((60 / bpm) * 1000);
		stepCrochet = crochet / 4;
	}
}
