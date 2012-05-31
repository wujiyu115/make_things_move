package comps 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author far
	 */
	public class Ball extends Sprite 
	{
		
		public function Ball(size:int = 10, color:uint=0x000000 ) 
		{
			graphics.beginFill(color);
			graphics.drawCircle(size, size, size);
			graphics.endFill();
		}
		
	}

}