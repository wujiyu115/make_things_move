package startDrag 
{
	import comps.Ball;
	import comps.RectangleA;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	/**
	 * 矩形内拖动
	 * @author far
	 */
	public class DragInRectangle extends Sprite 
	{
		private var rec:RectangleA = new RectangleA();
		private var ball:Ball = new Ball();
		private var _mystag:Stage;
		public function DragInRectangle(mystage:Stage) 
		{
			addChild(rec);
			addChild(ball);
			ball.addEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			this._mystag = mystage;
			
		}
		
		private function upHandler(e:MouseEvent):void 
		{
			_mystag.removeEventListener(MouseEvent.MOUSE_UP, upHandler);
			ball.stopDrag();
		}
		
		private function downHandler(e:MouseEvent):void 
		{
			_mystag.addEventListener(MouseEvent.MOUSE_UP, upHandler);
			ball.startDrag(false, new Rectangle(0, 0, rec.width - ball.width, rec.height - ball.height));
		}
		
	}

}