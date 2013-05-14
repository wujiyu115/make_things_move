package comps 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author far
	 */
	public class SpriteEasingBall extends Sprite 
	{
		
		public var vx:Number=0;
		public var vy:Number = 0;
		public function SpriteEasingBall(size:int = 10, color:uint=0x000000 ) 
		{
			graphics.beginFill(color);
			graphics.drawCircle(size, size, size);
			graphics.endFill();
		}
		
	}

}