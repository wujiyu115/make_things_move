package startDrag
{
	import comps.Ball;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import triangle.BounceBall;
	
	/**
	 *运动拖拽
	 * 拖拽有两种实现方法
	 *  startDrag: 
	 *	MouseMove: 拖拽多个mc时的解决办法 
	 *  
	 * 
	 * 
	 * @author far
	 */
	public class MoveDrag extends BounceBall
	{
		
		public function MoveDrag(mystage:Stage)
		{
			super(mystage);
			sta.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		
		private function mouseDownHandler(e:MouseEvent):void
		{
			sta.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			var ball:Ball = (e.target as Ball);
			if (ball)
			{
				//拖拽后立即停止运动 
				//ball.vx = 0;
				//ball.vy = 0;
				ball.startDrag();
			}
			removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function mouseUpHandler(e:MouseEvent):void
		{
			sta.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			var ball:Ball = (e.target as Ball);
			if (ball)
			{
				ball.stopDrag();
			}
		
		}
		
		
	}

}