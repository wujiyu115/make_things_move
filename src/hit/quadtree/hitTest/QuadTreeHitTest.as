package hit.quadtree.hitTest
{
	
	/**
	 * http://www.feidongping.com/post/25.html
	 * 
	 *  hittest 1000                                               正式版   调试版
	 *   网格碰撞物体尺寸正常                  40fps          20fps
	 *   网格非正常                                              9fps             5fps
	 *   flixel改写四叉树物体尺寸正常      35fps          20fps
	 *  flixel改写四叉树非正常                     35fps           20fps
	 * 
	 * 在物体大小相差不大时四叉树表现稳定,1000物体,四叉树大概要检测碰撞6000次，而网格碰撞检测需76000
	 * 而网格碰撞适用于物体相差不大时使用,1000物体,四叉树大概要检测碰撞6000次，而网格碰撞检测只需3500 ,
	 * */
	import flash.display.*;
	import flash.events.*;
	import flash.geom.*;
	import hit.quadtree.hitTest.grid.GridHitTest;
	import hit.quadtree.hitTest.normal.NormalHitTest;
	import hit.quadtree.hitTest.quadTree.FQuad;
	import hit.quadtree.QuadTree;
	import utils.Stats;
	
	public class QuadTreeHitTest extends Sprite
	{
		private var GRID_WIDTH:Number = 20;
		private var GRID_HEIGTH:Number = 20;
		private var _speSize:Number = 100;
		private var _container:Sprite;
		private var _grid:GridHitTest;
		private var _rects:Vector.<DisplayObject>;
		private var _numRects:int = 1000;
		private var _nShen:QuadTree;
		private var _fQuad:FQuad;
		private var _callHit:Function;
		
		public function QuadTreeHitTest()
		{
		
		}
		
		//1 传统  2 n神四叉树  3 网格正常尺寸 4 flixel改写四叉树正常尺寸  5 网格尺寸差别较大 6  flixel改写四叉树尺寸差别较大
		public function test(flag:int):void
		{
			switch (flag)
			{
				case 1: 
					_callHit = this.normalHitTest;
					break;
				case 2: 
					_callHit = this.nShenHitTest;
					break;
				case 3: 
					this.GRID_WIDTH = this.GRID_HEIGTH = 20;
					this._speSize = 20;
					_callHit = this.gridHitTest;
					break;
				case 4: 
					this.GRID_WIDTH = this.GRID_HEIGTH = 20;
					this._speSize = 20;
					_callHit = this.quadHitTest;
					break;
				case 5: 
					this.GRID_WIDTH = this.GRID_HEIGTH = 100;
					this._speSize = 100;
					_callHit = this.gridHitTest;
					break;
				case 6: 
					this.GRID_WIDTH = this.GRID_HEIGTH = 100;
					this._speSize = 100;
					_callHit = this.quadHitTest;
					break;
			}
			addEventListener(Event.ADDED_TO_STAGE, addEdhandler);
		}
		
		private function addEdhandler(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, addEdhandler);
			inits();
		}
		
		private function inits():void
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.frameRate = 60;
			this._grid = new GridHitTest(stage.stageWidth, stage.stageHeight, this.GRID_WIDTH, this.GRID_HEIGTH);
			this._nShen = new QuadTree(new Rectangle(0, 0, stage.stageWidth, stage.stageHeight));
			FQuad.divisions = 8;
			this._container = new Sprite();
			this._container.graphics.beginFill(0xff0000, 0);
			this._container.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			this._container.graphics.endFill();
			_container.mouseEnabled = false;
			_container.mouseChildren = false;
			addChild(this._container);
			addChild(new Stats());
			this.makeRects();
			this.addEventListener(MouseEvent.ROLL_OVER, this.mouseOver);
			this.addEventListener(MouseEvent.ROLL_OUT, this.mouseOut);
		}
		
		private function mouseOver(event:MouseEvent):void
		{
			addEventListener(Event.ENTER_FRAME, this.onEnterFrame);
		}
		
		private function onEnterFrame(event:Event):void
		{
			this.updateRect();
			this._callHit();
		}
		
		private function normalHitTest():void
		{
			NormalHitTest.check(this._rects);
			var len:int = NormalHitTest.checks.length;
			var index:int = 0;
			while (index < len)
			{
				
				this.checkCollision(NormalHitTest.checks[index], NormalHitTest.checks[(index + 1)]);
				index = index + 2;
			}
			return;
		}
		
		private function gridHitTest():void
		{
			this._grid.check(this._rects);
			var len:* = this._grid.checks.length;
			trace(len / 2);
			var index:int = 0;
			while (index < len)
			{
				
				this.checkCollision(this._grid.checks[index], this._grid.checks[(index + 1)]);
				index = index + 2;
			}
		}
		
		private function nShenHitTest():void
		{
			var arr:Array = null;
			var stuffLen:int = 0;
			var stuffIndex:int = 0;
			var len:int = this._rects.length;
			var index:int = 0;
			while (index < len)
			{
				
				this._nShen.insert(this._rects[index]);
				index = index + 1;
			}
			index = 0;
			while (index < len)
			{
				
				arr = this._nShen.retrieve(this._rects[index]);
				stuffLen = arr.length;
				stuffIndex = 0;
				while (stuffIndex < stuffLen)
				{
					
					if (arr[stuffIndex] == this._rects[index])
					{
					}
					else if (Rect(arr[stuffIndex]).hitTestObject(this._rects[index]))
					{
						Rect(arr[stuffIndex]).color = 16711680;
						Rect(this._rects[index]).color = 16711680;
					}
					stuffIndex++;
				}
				index++;
			}
			this._nShen.clear();
		}
		
		private function quadHitTest():void
		{
			this._fQuad = new FQuad(0, 0, stage.stageWidth, stage.stageHeight);
			this._fQuad.load(this._rects, this.checkCollision);
			this._fQuad.execute();
			this._fQuad.destroy();
		}
		
		private function mouseOut(event:MouseEvent):void
		{
			removeEventListener(Event.ENTER_FRAME, this.onEnterFrame);
			return;
		}
		
		private function makeRects():void
		{
			
			this._rects = new Vector.<DisplayObject>(this._numRects);
			var rect:Rect = new Rect(_speSize, _speSize);
			rect.x = Math.random() * stage.stageWidth;
			rect.y = Math.random() * stage.stageHeight;
			rect.vx = Math.random() * 4 - 2;
			rect.vy = Math.random() * 4 - 2;
			this._container.addChild(rect);
			this._rects[0] = rect;
			var index:int = 1;
			var other:Rect = null;
			while (index < this._numRects)
			{
				
				other = new Rect();
				other.x = Math.random() * stage.stageWidth;
				other.y = Math.random() * stage.stageHeight;
				other.vx = Math.random() * 4 - 2;
				other.vy = Math.random() * 4 - 2;
				this._container.addChild(other);
				this._rects[index] = other;
				index++;
			}
		}
		
		private function updateRect():void
		{
			var rect:Rect = null;
			var index:int = 0;
			while (index < this._numRects)
			{
				
				rect = this._rects[index] as Rect;
				rect.update();
				if (rect.x < 0)
				{
					rect.x = 0;
					rect.vx = rect.vx * -1;
				}
				else if (rect.x >= stage.stageWidth)
				{
					rect.x = stage.stageWidth - 1;
					rect.vx = rect.vx * -1;
				}
				if (rect.y < 0)
				{
					rect.y = 0;
					rect.vy = rect.vy * -1;
				}
				else if (rect.y >= stage.stageHeight)
				{
					rect.y = stage.stageHeight - 1;
					rect.vy = rect.vy * -1;
				}
				rect.color = 255;
				index++;
			}
			return;
		}
		
		private function checkCollision(param1:DisplayObject, param2:DisplayObject):Boolean
		{
			if (param1.hitTestObject(param2))
			{
				Rect(param1).color = 0xff0000;
				Rect(param2).color = 0xff0000;
				return true;
			}
			return false;
		}
	
	}
}
