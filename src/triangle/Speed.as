package triangle
{
	import comps.Ball;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author far
	 */
	public class Speed extends Sprite
	{
		private var ball:Ball;
		
		public function Speed()
		{
			ball = new Ball();
			addChild(ball);
			addEventListener(Event.ADDED_TO_STAGE, addToStage);
		
		}
		
		private function addToStage(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addToStage);
			addEventListener(Event.ENTER_FRAME, enterFameHandler);
		}
		
		private function enterFameHandler(e:Event):void
		{
			ball.x += vx;
			ball.y += vx;
			//vx += speed;
		}
		private var vx:Number = 2;
		private var speed:Number = .1;
	
	}

}