package comps 
{
	import flash.display.Sprite;
	
	/**
	 * 矩形
	 * @author far
	 */
	public class RectangleA extends Sprite 
	{
		
		public function RectangleA(color:uint=0x00ffff,size:int= 200) 
		{
			graphics.clear();
			graphics.beginFill(color);
			graphics.drawRect(0, 0, size, size);
			graphics.endFill();
		}
		
	}

}