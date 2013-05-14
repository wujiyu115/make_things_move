package rotation
{
	import comps.Ball;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author far
	 */
	public class Rotatel3 extends Rotatel2
	{
		private var _balls:Array = [];
		private var _numChilds:int = 10;
		
		public function Rotatel3()
		{
		
		}
		
		override protected function initBall():void
		{
			for (var i:int = 0; i < _numChilds; i++)
			{
				var _ball:Ball = new Ball();
				_ball.x = Math.random() * stage.stageWidth;
				_ball.y = Math.random() * stage.stageHeight;
				addChild(_ball);
				_balls.push(_ball);
			}
		
		}
		
		override protected function enterFrameHandler(e:Event):void
		{
			for (var i:int = 0; i < _numChilds; i++)
			{
				move(_balls[i]);
			}
		}
	
	}

}