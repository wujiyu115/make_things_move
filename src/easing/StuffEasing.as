package easing 
{
	import comps.Ball;
	import comps.SpriteEasingBall;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 多物体弹性运动 
	 * @author far
	 */
	public class StuffEasing extends Sprite 
	{
		private var _ballOne:SpriteEasingBall;
		private var _ballTwo:SpriteEasingBall;
		private var _ballThree:SpriteEasingBall;
        private var _vx:Number = 0;
		private var _vy:Number = 0;
		private var _friction:Number = .8;
		private var _easing:Number = .1;
		private var _gravity:Number =5;
		
		public function StuffEasing() 
		{
			_ballOne = new SpriteEasingBall();
			_ballTwo = new SpriteEasingBall();
			_ballThree = new SpriteEasingBall();
			addChild(_ballOne);
			addChild(_ballTwo);
			addChild(_ballThree);
			this.addEventListener(Event.ADDED_TO_STAGE, addHandler);
		}
		
		private function addHandler(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addHandler);
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function enterFrameHandler(e:Event):void 
		{
			 move(_ballOne, mouseX, mouseY);
			 move(_ballTwo, _ballOne.x, _ballOne.y);
			 move(_ballThree, _ballTwo.x, _ballTwo.y);
			 
			 graphics.clear();
			 graphics.lineStyle(1);
			 graphics.moveTo(mouseX, mouseY);
			 graphics.lineTo(_ballOne.x, _ballOne.y);
			 graphics.lineTo(_ballTwo.x, _ballTwo.y);
			 graphics.lineTo(_ballThree.x, _ballThree.y);
		}
		
		private function move(ball:SpriteEasingBall,targetX:Number,targetY:Number):void 
		{
			var dx:Number = targetX - ball.x;
			var dy:Number = targetY -ball.y;
			var ax:Number  = dx * _easing;
			var ay:Number = dy * _easing;
			
			ball.vx  +=  ax;
			ball.vx  *= _friction;
			ball.vy += ay;
			ball.vy += _gravity;
			ball.vy *= _friction;
			
			ball.x += ball.vx ;
			ball.y += ball.vy;
		}
		
	}

}