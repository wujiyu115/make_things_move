package hit 
{
	import comps.Ball;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author far
	 */
	public class HitTestPoint extends Sprite 
	{
		private var _ball:Ball;
		public function HitTestPoint() 
		{
			_ball = new Ball();
			addChild(_ball);
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			 //trace(  _ball.hitTestPoint(mouseX,mouseY));
			 //是否是可以见区域
			 trace(  _ball.hitTestPoint(mouseX,mouseY,true));
		}
		
	}

}