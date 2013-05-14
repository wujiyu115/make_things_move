package triangle
{
	import comps.Ball;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 波形运动
	 * @author far
	 */
	public class SinMove extends Sprite
	{
		private var ball:Ball;
		
		public function SinMove()
		{
			ball = new Ball();
			addChild(ball);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void
		{
			//sinaMove();
			//heartMove();
			//circleMove();
			ellipseMove();
		}
		
		//波形
		private function sinaMove():void
		{
			ball.x += _xSpeed;
			ball.y = Math.sin(angle) * range;
			angle += speed;
		}
		
		//心跳运动
		private function heartMove():void
		{
			ball.scaleX = ball.scaleY = 1+Math.sin(angle) * range;
			angle += speed;
		}
		
		//圆周运动
		private function circleMove():void
		{
			ball.x = Math.cos(angle) * range;
			ball.y = Math.sin(angle) * range;
			angle += speed;
		}
		
		//椭圆运动
		private function ellipseMove():void
		{
			ball.x = Math.cos(angle) * (range + 10);
			ball.y = Math.sin(angle) * range;
			angle += speed;
		}
		
		private var _xSpeed:Number = 1;
		private var angle:Number = 0; //递增角度
		private var speed:Number = .1;//速度
		private var range:Number = 50;//放大倍数
	
	}

}