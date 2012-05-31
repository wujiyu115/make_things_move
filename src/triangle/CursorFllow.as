package triangle
{
	import comps.Arrow;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author far
	 */
	public class CursorFllow extends Sprite
	{
		private var arrow:Arrow = new Arrow();
		private var speed:Number = 5;
		
		public function CursorFllow()
		{
			addChild(arrow);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void
		{
			var dx:Number = mouseX - arrow.x;
			var dy:Number = mouseY - arrow.y;
			var angle:Number = Math.atan2(dy, dx);
			arrow.rotation = angle*180/Math.PI;
			var vx:Number = Math.cos(angle) * speed;
			var vy:Number = Math.sin(angle) * speed;
			arrow.x += vx;
			arrow.y += vy;
		}
	
	}

}