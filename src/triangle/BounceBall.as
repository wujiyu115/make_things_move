package triangle
{
	import comps.Ball;
	import flash.display.Sprite;
	import flash.display.Stage;
	
	/**
	 * 反弹
	 * @author far
	 */
	public class BounceBall extends BoundaryBall
	{
		private var bound:Number = -0.9; //摩擦系数
		public function BounceBall(mystage:Stage)
		{
		    super(mystage);
		}
		
		//当超过边界时 将坐标设置到边界，然后将速度向量反转,加上摩擦系数后，物体会越来越慢,重力相当于y轴加一个向下的加速度 ,风力相当于在x轴加一个加速度
		//摩擦力不能单独作用在一轴上，不然会有一轴速度提前到零，物体变成垂直或水平运动.但摩擦力在两轴上的速率相同，所以简便方法如下。
		override protected function dealBall(ball:Ball, index:int):void
		{
			var ridus:Number = ball.width / 2;
			var left:Number = ridus;
			var right:Number = sta.stageWidth - ridus;
			var top:Number = ridus;
			var bottom:Number = sta.stageHeight - ridus;
			
			var bx:Number = ball.x;
			var by:Number = ball.y;
			
			if (bx > right)
			{
				bx = right;
				ball.vx *= bound;
			}
			if (bx < left)
			{
				bx = left;
				ball.vx *= bound;
			}
			if (by > bottom)
			{
				by = bottom;
				ball.vy *= bound;
			}
			if (by < top)
			{
				by = top;
				ball.vy *= bound;
			}
		}
	
	}

}