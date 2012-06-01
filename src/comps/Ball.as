package comps 
{
	import flash.display.Sprite;
	
	/**
	 * 小球
	 * @author far
	 */
	public class Ball extends Sprite 
	{
		public var vx:Number=1;
		public var vy:Number=1;
		public function Ball(size:int = 10, color:uint=0x000000 ) 
		{
			graphics.beginFill(color);
			graphics.drawCircle(size, size, size);
			graphics.endFill();
		}
		
	}

}