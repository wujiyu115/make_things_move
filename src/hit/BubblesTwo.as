package hit 
{
	import comps.SpriteEasingBall;
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * 多物体弹性碰撞
	 * @author far
	 */
	public class BubblesTwo extends Sprite 
	{
		private var _numChildren:int = 30;
		private var _ball:Array=[];
		private var spring:Number = .05;//弹性
		private var gravity:Number = .1;//重力
		private var bounce:Number =- .5;//弹力
		public function BubblesTwo() 
		{
			this.addEventListener(Event.ADDED_TO_STAGE, addEdStageHanlder);
			
		}
		
		private function addEdStageHanlder(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, addEdStageHanlder);
			inits();
		}
		
		private function inits():void 
		{
			 for (var i:int = 0; i < _numChildren; i++) 
			 {
				 var ball:SpriteEasingBall = new SpriteEasingBall(Math.random() * 30 + 20, Math.random() * 0xffffff);
				 ball.x = Math.random() * stage.stageWidth;
				 ball.y = Math.random() * stage.stageHeight;
				 ball.vx = Math.random() * 6 - 3;
				 ball.vy = Math.random() * 6 - 3;
				 addChild(ball);
				 _ball.push(ball);
			 }
			 addEventListener(Event.ENTER_FRAME, enterFramehandler);
		}
		
		private function enterFramehandler(e:Event):void 
		{
			 for (var i:int = 0; i < _numChildren-1; i++) 
			 {
				 var ballOne:SpriteEasingBall = _ball[i];
				   for (var j:int = i+1; j < _numChildren; j++) 
				   {
					     var ball:SpriteEasingBall = _ball[j];
						 var dx:Number = ball.x - ballOne.x;
						 var dy:Number = ball.y - ballOne.y;
						 var dist:Number = Math.sqrt(dx * dx + dy * dy);
						 var minDist:Number = (ballOne.width + ball.width) / 2;
						 if (dist < minDist) {
						           var angle:Number = Math.atan2(dy, dx);
								   var tx:Number = ballOne.x + Math.cos(angle) * minDist;
								   var ty:Number = ballOne.y + Math.sin(angle) * minDist;
								   var ax:Number = (tx -ball.x) * spring;
								   var ay:Number = (ty -ball.y) * spring;
								   ballOne.vx  -= ax;
								   ballOne.vy -= ay;
								   ball.vx += ax;
								   ball.vy += ay;
						}
				   }
				   for (var k:int = 0; k < _numChildren; k++) 
				   {
					   var myball:SpriteEasingBall = _ball[k];
					   move(myball);
				   }
			 }
		}
		
		private function move(ball:SpriteEasingBall):void 
		{
			 //ball.vy += gravity;
			 ball.x += ball.vx;
			 ball.y += ball.vy;
			 
			 var minPosX:Number = stage.stageWidth - ball.width / 2;
			 if (ball.x > minPosX) {
			     ball.x = minPosX;
				 ball.vx *= bounce;
			}else if(ball.x<ball.width/2) {
				  ball.x = ball.width / 2;
				  ball.vx *= bounce;
			}
			
			 var minPosY:Number = stage.stageHeight - ball.width / 2;
			 if (ball.x > minPosY) {
			     ball.y = minPosY;
				 ball.vy *= bounce;
			}else if(ball.x<ball.width/2) {
				  ball.y = ball.width / 2;
				  ball.vy *= bounce;
			}
		}
		
	}

}