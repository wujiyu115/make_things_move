package easing 
{
	import comps.Ball;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 
	 * @author far
	 */
	public class SpringEasing extends EasingTest 
	{
		protected var vx:Number = 0;
		protected var vy:Number = 0;
		protected var _friction:Number = .95;
		public function SpringEasing() 
		{
		
			 
		}
		
		//一维弹性运动
		//override protected function enterFramehandler(e:Event):void 
		//{
			 //var dx:Number = _target.x - _ball.x;
			 //var dy:Number = _target.y - _ball.y;
			//var ax:Number = dx * _easing;
			//vx += ax;
			//不乘以弹性系统会一直运动
			//vx *= _friction;
			//if (Math.abs(dx) < 1)
			   //this.removeEventListener(Event.ENTER_FRAME, enterFramehandler);
			 //_ball.x += vx;
			 //_ball.y += vx;
		//}
		
		//二维弹性运动
		override protected function enterFramehandler(e:Event):void 
		{
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
		   vy *= _friction;
		   //if (Math.abs(dx) < 1)
			  //this.removeEventListener(Event.ENTER_FRAME, enterFramehandler);
			_ball.x += vx;
		   _ball.y += vy;
		}
		
	}

}