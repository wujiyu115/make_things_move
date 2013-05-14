package AngleBounce
{
	import comps.Ball;
	import comps.SpriteEasingBall;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Rectangle;
	
	/**
	 * 斜面反弹先将斜面旋转成平面,将速度向量计算好后再将平面旋转回去
	 * @author far
	 */
	public class AngleBounce extends Sprite
	{
		private var _ball:SpriteEasingBall;
		private var _line:Sprite;
		private var _gravity:Number = 0.3;
		private var _bounce:Number = -.6;
		
		public function AngleBounce()
		{
			_ball = new SpriteEasingBall();
			addChild(_ball);
			_ball.x = _ball.y = 100;
			_line = new Sprite();
			_line.graphics.lineStyle(1);
			_line.graphics.lineTo(400, 0);
			addChild(_line);
			_line.x = 50;
			_line.y = 200;
			_line.rotation = 30;
			
			//trace(_ball.getBounds(this));
			
			this.addEventListener(Event.ADDED_TO_STAGE, addHandler);
		}
		
		private function addHandler(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addHandler);
			this.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void
		{
			//_line.rotation = (stage.stageWidth / 2 - mouseX) * .5;
			_ball.vy += _gravity;
			_ball.x += _ball.vx;
			_ball.y += _ball.vy;
			
			var bound:Rectangle = _line.getBounds(this);
			//if (_ball.hitTestObject(_line))
			if(_ball.x>bound.left&&_ball.x<bound.right)
			{
				//get angle
				var angle:Number = _line.rotation * Math.PI / 180;
				var cos:Number = Math.cos(angle);
				var sin:Number = Math.sin(angle);
				var x1:Number = _ball.x - _line.x;
				var y1:Number = _ball.y - _line.y;
				var y2:Number = cos * y1 - sin * x1;
				//反弹
				if (y2 > -_ball.height / 2)
				{
					//旋转
					var x2:Number = cos * x1 + sin * y1;
					var vx1:Number = cos * _ball.vx + sin * _ball.vy;
					var vy1:Number = cos * _ball.vy - sin * _ball.vx;
					y2 = -_ball.height / 2;
					vy1 *= _bounce;
					//旋转回去 
					x1 = cos * x2 - sin * y2;
					y1 = cos * y2 + sin * x2;
					_ball.vx = cos * vx1 - sin * vy1;
					_ball.vy = cos * vy1 + sin * vx1;
					_ball.x = _line.x + x1;
					_ball.y = _line.y + y1;
				}
			}
		}
	
	}

}