package rotation
{
	import comps.Ball;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	/**
	 *  以起始点作为原点旋转.优化计算次数
	 * @author far
	 */
	public class Rotatel2 extends Sprite
	{
		private var _ball:Ball;
		private var _vr:Number = 0.05;
		private var _cos:Number = Math.cos(_vr);
		private var _sin:Number = Math.sin(_vr);
		private var _centerPoint:Point;
		
		public function Rotatel2()
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addedToHandler);
		}
		
		protected function initBall():void
		{
			_ball = new Ball();
			_ball.x = Math.random() * stage.stageWidth;
			_ball.y = Math.random() * stage.stageHeight;
			addChild(_ball);
		}
		
		private function addedToHandler(e:Event):void
		{
			initBall();
			removeEventListener(Event.ADDED_TO_STAGE, addedToHandler);
			_centerPoint = new Point(stage.stageWidth / 2, stage.stageHeight / 2);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		protected function enterFrameHandler(e:Event):void
		{
			move(_ball);
		}
		
		protected function move(_ball:Ball):void
		{
			var dx:Number = _ball.x - _centerPoint.x;
			var dy:Number = _ball.y - _centerPoint.y;
			//此公式计算旋转vr角度后x,y的增量
			var x2:Number = _cos * dx - _sin * dy;
			var y2:Number = _cos * dy + _sin * dx;
			_ball.x = _centerPoint.x + x2;
			_ball.y = _centerPoint.y + y2;
		}
	
	}

}