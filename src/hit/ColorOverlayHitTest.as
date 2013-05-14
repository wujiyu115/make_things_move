package hit 
{
	import comps.Circle;
	import comps.Plus;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	
	/**
	 * ...
	 * @author far
	 */
	public class ColorOverlayHitTest extends MovieClip 
	{
		private var _circle:Circle;
		private var _plus:Plus;
		public function ColorOverlayHitTest() 
		{
			_circle = new Circle();
			addChild(_circle);
			_plus = new Plus();
			_plus.x = _plus.y = 100;
			addChild(_plus);
			_circle.addEventListener(MouseEvent.MOUSE_DOWN, moudeDownHandler);
			_circle.addEventListener(MouseEvent.MOUSE_UP, moudeUpHandler);
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void
		{
			if (HitTest.complexHitTestObject(_circle, _plus))
			{
				applyGreenTint(_circle);
			}
			else
			{
				resetTint(_circle);
			}
		}
		
		private function moudeUpHandler(e:MouseEvent):void
		{
			_circle.stopDrag();
		}
		
		private function moudeDownHandler(e:MouseEvent):void
		{
			_circle.startDrag();
		}
		
		private function applyGreenTint(clip:DisplayObjectContainer):void
		{
			var colorTint:ColorTransform = clip.transform.colorTransform;
			colorTint.redOffset = 0;
			colorTint.blueOffset = 0;
			colorTint.greenOffset = 255;
			clip.transform.colorTransform = colorTint;
		}
		
		private function resetTint(clip:DisplayObjectContainer):void
		{
			var colorTint:ColorTransform = clip.transform.colorTransform;
			colorTint.redOffset = 0;
			colorTint.blueOffset = 0;
			colorTint.greenOffset = 0;
			clip.transform.colorTransform = colorTint;
		}
		
	}

}