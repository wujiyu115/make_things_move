package triangle
{
	import comps.Arrow;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.display.Sprite;
	
	/**
	 * 弧度 角度
	 * @author far
	 */
	public class TriangleTest extends Sprite
	{
		private var arrow:Arrow = new Arrow();
		//三角函数都以弧度计算，所以要将角度转换成弧度
		public function TriangleTest()
		{
			
			
			addChild(arrow);
			addEventListener(Event.ENTER_FRAME, enterFrame);
		}
		
		private function enterFrame(e:Event):void
		{
			var dx:Number = mouseX - arrow.x;
			var dy:Number = mouseY - arrow.y;
			var radians:Number = Math.atan2(dy, dx);
			arrow.rotation = AR(radians);
		}
		
		public function RA(r:Number):Number
		{
			return Math.PI * r / 180;
		}
		
		public function AR(a:Number):Number
		{
			return 180 * a / Math.PI;
		}
	}

}