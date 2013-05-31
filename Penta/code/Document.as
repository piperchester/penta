package code
{
	import flash.display.MovieClip;
	import flash.events.*;
	import flash.ui.Mouse;
	import flash.utils.getDefinitionByName;

	// Handles collision, music, initialization and main game code
	public class Document extends MovieClip
	{
		public static var GLOBAL_SCORE:int = 0;// this is the score that the player has
		public static var GLOBAL_LIVES:int = 1; // this is the initial lives, but it will change from the XML being fed in
		public static var GLOBAL_LEVEL:uint = 0;
		public static var BEGIN_GAME:Boolean = true;
		
		private const MAX_LEVEL:int = 3;

		private var _handler:XMLHandler;
		private var _penta:Penta;
		private var _music:BackgroundMusic;
		private var _scoreSound:ScoreSound;
		private var _contactSound:ContactSound;
		private var _songCheck:Boolean;// boolean flag checks whether the sandwich song has started playing
		private var _currentLevel:MovieClip;

		public function Document()
		{
			// Initialliziing classes and arrays
			_handler = new XMLHandler();
			_music = new BackgroundMusic();
			_scoreSound = new ScoreSound();
			_contactSound = new ContactSound();
			_songCheck = true;

			if (_songCheck)
			{
				_music.play();
			}

			_songCheck = false;// this will block the song from continually playing throughout the experience
			addEventListener(Event.ENTER_FRAME, levelCheck, false, 0, true);
		}

		// Checks every frame to see if the level needs to be changed
		private function levelCheck(e:Event):void
		{
			if (Document.GLOBAL_LEVEL == 1 && BEGIN_GAME)
			{
				level_txt.text = "Level: " + GLOBAL_LEVEL;
				addEventListener(Event.ENTER_FRAME, doLoop, false, 0, true);
				Document.GLOBAL_LEVEL = 0;
				_penta = new Penta();
				addChild(_penta);
				Mouse.hide();
				nextLevel();
				BEGIN_GAME = false;
			}
			
			// Will send player to Game Over screen if lives are fewer than or equal to one
			if (GLOBAL_LIVES <= 0)
			{
				gotoAndPlay("game_over");
				removeEventListener(Event.ENTER_FRAME, doLoop);
				removeChild(_penta);
				Mouse.show();
			}
		}

		// Manages the setup of the new level, including removing the movie clips 
		private function nextLevel():void
		{
			Document.GLOBAL_LEVEL++;
			level_txt.text = "Level: " + Document.GLOBAL_LEVEL;

			// Resets to Level 1 if over max level
			if (Document.GLOBAL_LEVEL > MAX_LEVEL)
			{
				removeEventListener(Event.ENTER_FRAME, doLoop);
				gotoAndPlay("won");
				removeChild(_penta);
				Mouse.show();
			}

			if (_currentLevel && _currentLevel.stage)
			{
				removeChild(_currentLevel);
			}

			var levelClass:Class = getDefinitionByName("Level" +Document.GLOBAL_LEVEL) as Class;
			_currentLevel = new levelClass();
			addChildAt(_currentLevel,0);// keep underneath everything
		}

		private function doLoop(e:Event):void
		{
			// check collisions
			for (var i:int = 0; i < _currentLevel.numChildren; i++)
			{
				var pickup:MovieClip = (_currentLevel.getChildAt(i) as MovieClip);
				if (_penta.hitTestObject(pickup))
				{
					if (pickup is OrangeGeom)
					{
						_scoreSound.play();
						_penta.gotoAndPlay("plusfive");
						_currentLevel.removeChild(pickup);
						GLOBAL_SCORE +=  5;
					}
					
					if (pickup is BlueGeom)
					{
						_penta.scaleX += 1;
						_penta.scaleY += 1;
						_penta.gotoAndPlay("scale");
						_currentLevel.removeChild(pickup);
					}
				}
			}// end for

			// Checking collision with black enemies
			if (_penta.hitTestObject(black1) || _penta.hitTestObject(black2) || _penta.hitTestObject(black3))
			{
				_contactSound.play();
				_penta.gotoAndPlay("contact");
				GLOBAL_LIVES -=  1;
				_penta.x = black1.x + 300;
			}

			score_txt.text = "Score: " + GLOBAL_SCORE;
			lives_txt.text = "Lives: " + Document.GLOBAL_LIVES;
			if (_currentLevel.numChildren == 0)
			{
				nextLevel();
			}
		}// end doLoop
	}
}