package
{
	import comps.Ball;
	import comps.Ship;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import hit.ObjectHitTest;
	import startDrag.CursorAdmin;
	import startDrag.MoveDrag;
	import triangle.Accelerated;
	import triangle.BounceBall;
	import triangle.BoundaryBall;
	import triangle.BoundaryShip;
	import triangle.CursorFllow;
	import triangle.Dist;
	import startDrag.DragInRectangle;
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
			//var tt:TriangleTest = new TriangleTest();
			//centerMc(tt);
			//var sinMove:SinMove = new SinMove();
			//centerMc(sinMove);
			//var dist:Dist = new Dist(stage);
			//centerMc(dist);
			//var speed:Speed = new Speed();
			//centerMc(speed);
			//var dr:DragInRectangle = new DragInRectangle(stage);
			//centerMc(dr);
			//var cursor:CursorFllow = new CursorFllow();
			//centerMc(cursor);
			//var acce:Accelerated = new Accelerated(stage);
			//centerMc(acce);
			//var cursor2:CursorFllow2 = new CursorFllow2();
			//centerMc(cursor2);
			//var boundball:BoundaryBall = new BoundaryBall(stage);
			//var ship:BoundaryShip = new BoundaryShip(stage);
			//var bounceBall:BounceBall = new BounceBall(stage);
			//var cusoradmin:CursorAdmin = new CursorAdmin().init(stage);
			//cusoradmin.setCursor(new Ball());
			//var moveDrag:MoveDrag  = new startDrag.MoveDrag(stage); 
			var objecthit:ObjectHitTest = new ObjectHitTest();
			centerMc(objecthit);
			addChild(objecthit);
		}
		
		public function centerMc(mc:DisplayObject):void
		{
			mc.x = (stage.stageWidth - mc.width) / 2;
			mc.y = (stage.stageHeight - mc.height) / 2;
		}
	
	}

}