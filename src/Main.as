package
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import triangle.Accelerated;
	import triangle.CursorFllow;
	import triangle.Dist;
	import triangle.DragInRectangle;
	import triangle.SinMove;
	import triangle.Speed;
	import triangle.TriangleTest;
	import triangle.CursorFllow2;
	/**
	 * ...
	 * @author far
	 */
	public class Main extends Sprite
	{
		
		public function Main():void
		{
			if (stage)
				init();
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			test();
		}
		
		private function test():void
		{
			var tt:TriangleTest = new TriangleTest();
			centerMc(tt);
			var sinMove:SinMove = new SinMove();
			centerMc(sinMove);
			var dist:Dist = new Dist(stage);
			centerMc(dist);
			var speed:Speed = new Speed();
			centerMc(speed);
			var dr:DragInRectangle = new DragInRectangle(stage);
			centerMc(dr);
			var cursor:CursorFllow = new CursorFllow();
			centerMc(cursor);
			var acce:Accelerated = new Accelerated(stage);
			centerMc(acce);
			var cursor2:CursorFllow2 = new CursorFllow2();
			centerMc(cursor2);
			addChild(cursor2);
		
		}
		
		public function centerMc(mc:DisplayObject):void
		{
			mc.x = (stage.stageWidth - mc.width) / 2;
			mc.y = (stage.stageHeight - mc.height) / 2;
		}
	
	}

}