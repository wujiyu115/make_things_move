package easing 
{
	import comps.Ball;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author far
	 */
	public class EasingTest extends Sprite 
	{
		protected  var _ball:Ball;
		protected var _target:Point;
		protected var _easing:Number=.1;
		public function EasingTest() 
		{
			_ball = new Ball();
			_target = new Point();
			addChild(_ball);
			
			this.addEventListener(Event.ADDED_TO_STAGE, addHandler);
		}
		
		private function addHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addHandler);
			changeTarget();
		}
		
		private function clickHandler(e:MouseEvent):void 
		{
			_target.x =  stage.mouseX;
			_target.y =  stage.mouseY;
			this.addEventListener(Event.ENTER_FRAME, enterFramehandler);
		}
		
		protected function action():void 
		{
			var dx:Number = _target.x - _ball.x;
			var dy:Number = _target.y - _ball.y;
		   var vx:Number = dx * _easing;
		   var vy:Number = dy * _easing;
		   if (Math.abs(dx) < 1)
			  this.removeEventListener(Event.ENTER_FRAME, enterFramehandler);
			_ball.x += vx;
			_ball.y += vy;
		}
		
		protected function changeTarget():void 
		{
			stage.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		protected function enterFramehandler(e:Event):void 
		{
			 action();
		}
		
	}

}