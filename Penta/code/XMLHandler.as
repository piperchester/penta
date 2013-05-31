package code
{
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.*;

	// Manages the importing of XML 
	public class XMLHandler
	{
		private var _livesFromFile:uint;
		private var _scoreFromFile:int;
		private var _myLoader:URLLoader;
		private var _myXML:XML;
		private var _xmlString:String;

		public function XMLHandler()
		{
			_myLoader = new URLLoader();
			_myLoader.load(new URLRequest("data\\game_data.xml"));
			_myLoader.addEventListener(Event.COMPLETE, processXML);
		}

		public function processXML(e:Event):void
		{
			_myXML = new XML(e.target.data);
			Document.GLOBAL_LIVES = _livesFromFile = int(_myXML.hud[0].startLives[0]);
			Document.GLOBAL_SCORE = _scoreFromFile = int(_myXML.hud[0].startScore[0]);
		}
	}
}