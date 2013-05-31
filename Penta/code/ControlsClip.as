package code
{
	import flash.display.MovieClip;
	import flash.events.*;

	// Class of the conrols clip
	public class ControlsClip extends ButtonLayer
	{
		public function ControlsClip()
		{
			addEventListener(MouseEvent.CLICK, displayControls, false, 0, true);
		}

		private function displayControls(e:MouseEvent):void
		{
			(parent as Document).gotoAndPlay("controls"); // takes the game to the screen that has information on how to play the game
		}
	}
}