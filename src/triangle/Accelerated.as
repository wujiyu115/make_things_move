package triangle
{
	import flash.ui.Keyboard;
	import comps.Ball;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	
	/**
	 * 加速度
	 * @author far
	 */
	public class Accelerated extends Sprite
	{
		private var ball:Ball = new Ball();
		
		public function Accelerated(mystage:Stage)
		{
			addChild(ball);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			mystage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			mystage.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
		}
		
		private function keyUpHandler(e:KeyboardEvent):void
		{
			ax = 0;
			ay = 0;
		}
		
		private function keyDownHandler(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case Keyboard.LEFT: 
					ax = -0.1;
					break;
				case Keyboard.RIGHT: 
					ax = 0.1;
					break;
				case Keyboard.UP: 
					ay = -0.1;
					break;
				case Keyboard.DOWN: 
					ay = 0.1;
					break;
			}
		}
		private var ax:Number = 0; //x轴加速度
		private var ay:Number = 0; //y轴加速度
		private var vx:Number = 0; //x轴速度
		private var vy:Number = 0; //y轴速度
		
		private function enterFrameHandler(e:Event):void
		{
			
			vx += ax;
			vy += ay;
			ball.x += vx;
			ball.y += vy;
		}
	
	}

}