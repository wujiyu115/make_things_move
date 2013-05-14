package rotation
{
	import comps.Ball;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author far
	 */
	public class Rotatel extends Sprite
	{
		private var _ball:Ball;
		private var _vr:Number = 0.05;
		private var _angle:Number = 0;
		private var _radius:Number = 150;
		
		public function Rotatel()
		{
			_ball = new Ball();
			addChild(_ball);
			//_radius = _ball.width / 2;
			this.addEventListener(Event.ADDED_TO_STAGE, addEdHandler);
		}
		
		private function addEdHandler(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addEdHandler);
			this.addEventListener(Event.ENTER_FRAME, enteerFrameHandler);
		}
		
		private function enteerFrameHandler(e:Event):void
		{
		    _ball.x = stage.stageWidth / 2 + Math.cos(_angle) * _radius;
		    _ball.y = stage.stageHeight / 2 + Math.sin(_angle) * _radius;
			_angle += _vr;
		}
	
	}

}