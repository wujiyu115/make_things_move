package hit.quadtree
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.events.Event;
	import flash.events.MouseEvent;

	[SWF(width="800", height="600", frameRate="60", backgroundColor="#FFffff")]
	public class Template extends Sprite
	{
		public function Template()
		{
			super()
			this.addEventListener(Event.ADDED_TO_STAGE,init)
		}
		
		protected function init(e:Event):void
		{
			stage.align = StageAlign.TOP_LEFT
			stage.scaleMode = "noScale"
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			
		}
		
		protected function onEnterFrame(e:Event):void
		{
			
		}
		
		private function onMouseMove(e:MouseEvent):void
		{
			 stage.removeEventListener(MouseEvent.MOUSE_MOVE,onMouseMove)
			 stage.addEventListener(Event.MOUSE_LEAVE, onMouseLeave);
			 stage.addEventListener(Event.ENTER_FRAME,onEnterFrame) 
		}
		
		private function onMouseLeave(e:Event):void
		{
			stage.removeEventListener(Event.MOUSE_LEAVE,onMouseLeave);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			stage.removeEventListener(Event.ENTER_FRAME,onEnterFrame);
			
		}
	}
}