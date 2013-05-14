package hit
{
	import comps.Ball;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author far
	 */
	public class DistHitTet extends Sprite
	{
		private var _ballOne:Ball;
		private var _ballTwo:Ball;
		private var _radius:int;
		
		public function DistHitTet()
		{
			_ballOne = new Ball();
			_ballTwo = new Ball();
			_ballOne.y = _ballTwo.y = 100;
			_ballTwo.x = 100;
			_radius = _ballOne.width;
			addChild(_ballOne);
			addChild(_ballTwo);
			_ballOne.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			_ballOne.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void
		{
			var dx:Number = _ballOne.x - _ballTwo.x;
			var dy:Number = _ballOne.y - _ballTwo.y;
			var dist:Number = Math.sqrt(dx*dx+dy*dy);
			if (dist<= _radius)
			{
				trace("hit");
			}
		}
		
		private function mouseUpHandler(e:MouseEvent):void
		{
			_ballTwo.stopDrag();
		}
		
		private function mouseDownHandler(e:MouseEvent):void
		{
			_ballOne.startDrag();
		
		}
	
	}

}