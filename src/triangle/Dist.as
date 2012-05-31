package triangle
{
	import comps.Ball;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author far
	 */
	public class Dist extends Sprite
	{
		private var ball:Ball;
		private var label:TextField;
		
		public function Dist(mystage:Stage)
		{
			ball = new Ball();
			label = new TextField();
			label.x = 100;
			label.width = 200;
			addChild(label);
			addChild(ball);
			mystage.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			var dx:Number = mouseX - ball.x;
			var dy:Number = mouseY - ball.y;
			label.text ="小球距点击距离:"+ Math.sqrt(dx * dx + dy * dy);
		}
	
	}

}