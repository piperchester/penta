package code {
	
	import flash.display.MovieClip;
	import flash.events.*;
	
	// An abstract class that manages the clicking, mousing over, and mousing off of buttons 
	public class ButtonLayer extends MovieClip {
		
		public function ButtonLayer() {
			addEventListener(MouseEvent.MOUSE_OVER, onMouseOver, false, 0, true);
			addEventListener(MouseEvent.MOUSE_OUT, onMouseOut, false, 0, true);
			addEventListener(MouseEvent.CLICK, onClick, false, 0, true);
		}
		
		private function onMouseOver(e:MouseEvent):void{
			buttonMode = true;
			gotoAndPlay("text");
		}
		
		private function onMouseOut(e:MouseEvent):void{
			gotoAndPlay("main");
		}
		
		private function onClick(e:MouseEvent):void
		{
			
		}
	}	
}
