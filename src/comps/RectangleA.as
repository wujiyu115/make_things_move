package comps 
{
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author far
	 */
	public class RectangleA extends Sprite 
	{
		
		public function RectangleA() 
		{
			graphics.clear();
			graphics.beginFill(0x00ffff);
			graphics.drawRect(0, 0, 200, 200);
			graphics.endFill();
		}
		
	}

}