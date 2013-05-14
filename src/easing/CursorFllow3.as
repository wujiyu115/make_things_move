package easing 
{
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author far
	 */
	public class CursorFllow3 extends SpringEasing 
	{
		protected var gravity:Number = 5;//重力
		public function CursorFllow3() 
		{
			
		}
		override protected function changeTarget():void 
		{
			this.addEventListener(Event.ENTER_FRAME, enterFramehandler);
		}
		override protected function enterFramehandler(e:Event):void 
		{
			 
			_target.x = mouseX;
			_target.y  = mouseY;
			action();
		}
		
		override protected function action():void 
		{
			var dx:Number = _target.x - _ball.x;
			var dy:Number = _target.y - _ball.y;
		   var ax:Number = dx * _easing;
		   var ay:Number = dy*_easing;
		   vx += ax;
		   //不乘以弹性系统会一直运动
		   vx *= _friction;
		   vy += ay;
		   vy += gravity;
		   vy *= _friction;
		   //if (Math.abs(dx) < 1)
			  //this.removeEventListener(Event.ENTER_FRAME, enterFramehandler);
			_ball.x += vx;
		   _ball.y += vy;
		   graphics.clear();
		   graphics.lineStyle(1);
		   graphics.moveTo(_ball.x, _ball.y);
		   graphics.lineTo(mouseX,mouseY);
		}
		
	}

}