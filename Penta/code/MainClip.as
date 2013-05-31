package code
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;

	// Class that will display the Main Title screen when clicked
	public class MainClip extends ButtonLayer
	{
		public function MainClip()
		{
			addEventListener(MouseEvent.CLICK, displayMain, false, 0, true);
		}
		
		// Initializes the score and lives counters when button is clicked
		private function displayMain(e:MouseEvent):void
		{
			(parent as Document).gotoAndPlay("main");
			Document.GLOBAL_LEVEL = 0;
			Document.GLOBAL_SCORE = 0;
			Document.GLOBAL_LIVES = 10;
		}
	}
}