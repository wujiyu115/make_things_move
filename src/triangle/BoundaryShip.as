package triangle
{
	import comps.Ship;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	/**
	 * 飞船加速度 ，加上摩擦力
	 * @author far
	 */
	public class BoundaryShip extends Sprite
	{
		private var ship:Ship;
		private var sta:Stage;
		private var vr:Number = 0; //旋转角度
		private var vx:Number = 0; //x轴速度 
		private var vy:Number = 0; //y 轴速度 
		private var thrust:Number = 0; //加速度 
		private var friction:Number = .9; //摩擦系数,数值在0-1,越大摩擦力越小
		
		public function BoundaryShip(mystage:Stage)
		{
			ship = new Ship();
			sta = mystage;
			addChild(ship);
			sta.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			sta.addEventListener(KeyboardEvent.KEY_UP, keyUpHandler);
			addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			
			sta.scaleMode = StageScaleMode.NO_SCALE;
			sta.align = StageAlign.TOP_LEFT;
		}
		
		private function enterFrameHandler(e:Event):void
		{
			ship.rotation += vr;
			var angle:Number = ship.rotation * Math.PI / 180;
			var ax:Number = Math.cos(angle) * thrust;
			var ay:Number = Math.sin(angle) * thrust;
			vx += ax;
			vy += ay;
			//摩擦力
			//vx *= friction;
			//vy *= friction;
			ship.x += vx;
			ship.y += vy;
			
			dealShip(ship);
		}
		
		private function keyDownHandler(e:KeyboardEvent):void
		{
			switch (e.keyCode)
			{
				case Keyboard.LEFT: 
					vr = -5;
					break;
				case Keyboard.RIGHT: 
					vr = 5;
					break;
				case Keyboard.UP: 
					thrust = .2;
					ship.draw(true);
					break;
				case Keyboard.DOWN:
					
					break;
			}
		}
		
		private function keyUpHandler(e:KeyboardEvent):void
		{
			vr = 0;
			thrust = 0;
			ship.draw(false);
		}
		
		private function dealShip(ship:Ship):void
		{
			
			var wid:Number = ship.width / 2;
			var he:Number = ship.height / 2;
			
			var left:Number = -wid;
			var right:Number = sta.stageWidth + wid;
			var top:Number = -he;
			var bottom:Number = sta.stageHeight + he;
			
			var bx:Number = ship.x;
			var by:Number = ship.y;
			
			//trace(bx, by, left, right, top, bottom);
			
			//环绕
			if (bx > right)
			{
				ship.x = left;
				trace("out right");
			}
			if (bx < left)
			{
				ship.x = right;
				trace("out left");
			}
			if (by > bottom)
			{
				ship.y = top;
				trace("out bottom");
			}
			if (by < top)
			{
				ship.y = bottom;
				trace("out up");
			}
		}
	
	}

}