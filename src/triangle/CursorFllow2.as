package triangle
{
	import flash.display.Sprite;
	import comps.Arrow;
	import flash.events.Event;
	/**
	 * ...
	 * @author far
	 */
	public class CursorFllow2 extends Sprite
	{
		
		private var arrow:Arrow = new Arrow();
		private var speed:Number = .5; //加速度范围
		private var vx:Number = 0; //x轴速度
		private var vy:Number = 0; //y轴速度
		
		public function CursorFllow2()
		{
			addChild(arrow);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void
		{
			var dx:Number = mouseX - arrow.x;
			var dy:Number = mouseY - arrow.y;
			var angle:Number = Math.atan2(dy, dx);
			arrow.rotation = angle * 180 / Math.PI;
			//x y上的加速度
			var ax:Number = Math.cos(angle) * speed;
			var ay:Number = Math.sin(angle) * speed;
			
			vx += ax;
			vy += ay;
			arrow.x += vx;
			arrow.y += vy;
		}
	
	}

}