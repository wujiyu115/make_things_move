package triangle
{
	import comps.Ball;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 * 限定边界
	 * @author far
	 */
	public class BoundaryBall extends Sprite
	{
		private var balls:Array = [];
		private var size:int = 20;
		protected var sta:Stage;
		
		public function BoundaryBall(mystage:Stage)
		{
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			sta = mystage;
			init();
		}
		
		private function init():void
		{
			var ball:Ball;
			for (var i:int = 0; i < size; i++)
			{
				ball = new Ball();
				ball.vx = Math.random() * 2 - 1;
				ball.vy = Math.random() * 2 - 1;
				ball.x = Math.random() * sta.stageWidth;
				ball.y = Math.random() * sta.stageHeight;
				balls.push(ball);
				addChild(ball);
				
			}
		}
		
		protected function enterFrameHandler(e:Event):void
		{
			for (var i:int = balls.length - 1; i >= 0; i--)
			{
				var ball:Ball = balls[i] as Ball;
				ball.x += ball.vx;
				ball.y += ball.vy;
				dealBall(ball, i);
			}
		
		}
		
		protected function dealBall(ball:Ball, index:int):void
		{
			var ridus:Number = ball.width / 2;
			var left:Number = -ridus;
			var right:Number = sta.stageWidth + ridus;
			var top:Number = -ridus;
			var bottom:Number = sta.stageHeight + ridus;
			
			var bx:Number = ball.x;
			var by:Number = ball.y;
			
			if (bx > right || bx < left || by > bottom || by < top)
			{
				removeChild(ball);
				balls.splice(index, 1);
				if (balls.length == 0)
				{
					removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
					trace("remove");
				}
			}
		}
	
	}
}

