package;

import flixel.FlxGame;
import openfl.display.Sprite;

class Main extends Sprite
{

var screenX:Int;
var screenY:Int;

	public function new()
	{
	#if FULL_RES
		screenX = 800;
		screenY = 500;
		trace("Original Resolution");
	#end
	#if BIG_720P
		screenX = 1280;
		screenY = 720;
		trace("1280x720");
	#end

		super();
		addChild(new FlxGame(screenX, screenY, play.PlayState));
	}
}
