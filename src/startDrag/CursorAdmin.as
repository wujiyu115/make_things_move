package startDrag
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.ui.Mouse;
	import flash.ui.MouseCursor;
	
	/**
	 * 鼠标管理
	 * @author far
	 */
	public class CursorAdmin extends Sprite
	{
		private var currentCursor:Sprite;
		private var mystage:Stage;
		
		public function CursorAdmin()
		{
		}
		
		public function init(mystages:Stage):CursorAdmin
		{
			mystage = mystages;
			return this;
		}
		

		public function setCursor(mc:Sprite = null):void
		{
			//useMouseMove(mc);
			useStartDrag(mc);
		}
		//使用startDrag
		private function useStartDrag(mc:Sprite):void
		{
			if (mc)
			{
				Mouse.hide();
				currentCursor = mc;
				currentCursor.x = mystage.mouseX;
				currentCursor.y = mystage.mouseY;
				addChild(currentCursor);
				currentCursor.startDrag();
			}
			else
			{
				if (currentCursor)
				{
					currentCursor.stopDrag();
					currentCursor.visible = false;
				}
				Mouse.cursor = MouseCursor.AUTO;
				Mouse.show();
			}
		}
		//使用MouseMove
		private function useMouseMove(mc:Sprite):void
		{
			if (mc)
			{
				mystage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				Mouse.hide();
				currentCursor = mc;
				currentCursor.x = mystage.mouseX;
				currentCursor.y = mystage.mouseY;
				addChild(currentCursor);
				
			}
			else
			{
				mystage.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				if (currentCursor)
				{
					currentCursor.visible = false;
				}
				Mouse.cursor = MouseCursor.AUTO;
				Mouse.show();
			}
		}
		
		private function mouseMoveHandler(e:MouseEvent):void
		{
			currentCursor.x = mystage.mouseX;
			currentCursor.y = mystage.mouseY;
			//强制刷新，使鼠标不卡
			e.updateAfterEvent();
		}
	
	}

}