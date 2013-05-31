package code
{
	import flash.display.MovieClip;
	import flash.events.*;

	// Play button will take the player to level one
	public class PlayClip extends ButtonLayer
	{

		public function PlayClip()
		{
			addEventListener(MouseEvent.CLICK, startGame, false, 0, true);
		}

		private function startGame(e:MouseEvent):void
		{
			(parent as Document).gotoAndPlay("level_one");
			Document.GLOBAL_LEVEL = 1;
			Document.BEGIN_GAME = true;
		}
	}
}