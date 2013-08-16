package astar
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author far
	 */
	public class AStarTest extends Sprite
	{
		private const SIZE:int = 40;
		private const DIAGONAL:int = 14; //对角线
		private const PARALLEL:int = 10; //非对角线
		
		private var _map:Array = [[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1], [1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1]];
		private var _nodeSprite:Array = [];
		private var _clickCout:int;
		
		private var _fristNodeSp:Rect;
		private var _secondNodeSp:Rect;
		private var _firstPoint:Point = new Point();
		private var _sencondPoint:Point = new Point();
		
		private var _openList:Array = [];
		private var _closeList:Array = [];
		private var _path:Array = [];
		
		public function AStarTest()
		{
			if (stage)
				init(null);
			else
				addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			initMap();
			initEventListener();
		}
		
		private function initEventListener():void
		{
			stage.addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		private function clickHandler(e:MouseEvent):void
		{
			if (_clickCout >= 2)
			{
				_clickCout = 0;
				clear();
			}
			turnNode(e.stageX, e.stageY, _clickCout);
		
		}
		
		private function clear():void
		{
			if (_fristNodeSp)
				_fristNodeSp.create();
			if (_secondNodeSp)
				_secondNodeSp.create();
			for (var i:int = 0; i < _path.length; i++)
			{
				_nodeSprite[_path[i].x][_path[i].y].create();
			}
		}
		
		private function initMap():void
		{
			for (var i:int = 0; i < _map.length; i++)
			{
				var rol:Array = _map[i];
				var node:Array = [];
				for (var j:int = 0; j < rol.length; j++)
				{
					var rect:Rect = new Rect(rol[j]);
					rect.x = j * SIZE;
					rect.y = i * SIZE;
					addChild(rect);
					node.push(rect);
				}
				_nodeSprite.push(node);
			}
		}
		
		private function turnNode(x:Number, y:Number, nodeSite:int):void
		{
			var col:int = x / SIZE;
			var row:int = y / SIZE;
			var len:int = (col + 1) * (row + 1);
			if (_nodeSprite[row] && _nodeSprite[row][col])
			{
				_clickCout++;
				var rect:Rect = _nodeSprite[row][col];
				
				if (nodeSite == 0)
				{
					_firstPoint.x = row;
					_firstPoint.y = col;
					_fristNodeSp = rect;
				}
				if (nodeSite == 1)
				{
					_sencondPoint.x = row;
					_sencondPoint.y = col;
					_secondNodeSp = rect;
					var endPoint:Point = findPath(_firstPoint, _sencondPoint);
					if (endPoint != null)
					{
						while (endPoint != null)
						{
							_path.unshift(endPoint);
							endPoint = endPoint.parent;
						}
						for (var i:int = 0; i < _path.length; i++)
						{
							var po:Point = _path[i];
							var poNode:Rect = _nodeSprite[po.x][po.y];
							poNode.turn();
						}
					}
					
				}
				rect.turn();
			}
		}
		
		private function findPath(first:Point, second:Point):Point
		{
			_openList = [];
			_closeList = [];
			_path = [];
			trace();
			trace(first, second);
			
			_openList.push(first);
			while (_openList.length != 0)
			{
				var po:Point = inList(_openList, second);
				if (po)
					return po;
				_openList.sortOn(["f"]);
				var curr:Point = _openList.shift();
				_closeList.push(curr);
				//得到邻近的点
				var sorround:Array = getSorround(curr);
				trace(curr);
				for (var i:int = 0; i < sorround.length; i++)
				{
					var sorroundPoint:Point = sorround[i];
					if (inList(_openList, sorroundPoint))
					{
						FoundPoint(curr, sorroundPoint);
					}
					else
					{
						NotFoundPoint(curr, second, sorroundPoint);
					}
				}
			}
			return null;
		}
		
		private function NotFoundPoint(curr:Point, second:Point, point:Point):void
		{
			point.parent = curr;
			point.g = cacG(curr, point);
			point.h = cacH(second, point);
			point.cacF();
			_openList.push(point);
		}
		
		//计算G值, 如果比原来的大, 就什么都不做, 否则设置它的父节点为当前点,并更新G和F
		private function FoundPoint(curr:Point, point:Point):void
		{
			var g:int = cacG(curr, point);
			if (g < point.g)
			{
				point.parent = curr;
				point.g = g;
				point.cacF();
			}
		}
		
		private function cacG(curr:Point, point:Point):int
		{
			var diff:int = Math.abs(curr.x - point.x) + Math.abs(curr.y - point.y);
			var g:int = (diff == 2) ? DIAGONAL : PARALLEL;
			var parentG:int = (curr.parent != null) ? curr.parent.g : 0;
			return g + parentG;
		}
		
		//H值不计算折点
		private function cacH(second:Point, point:Point):int
		{
			var step:int = Math.abs(second.x - point.x) + Math.abs(second.y - point.y);
			return step * PARALLEL;
		}
		
		private function getSorround(curr:Point):Array
		{
			var surroundPoints:Array = [];
			for (var i:int = curr.x - 1; i <= curr.x + 1; i++)
			{
				for (var j:int = curr.y - 1; j <= curr.y + 1; j++)
				{
					var point:Point = new Point();
					point.x = i;
					point.y = j;
					if (canReach(curr, point))
					{
						surroundPoints.push(point);
					}
				}
			}
			return surroundPoints;
		}
		
		private function canReach(curr:Point, point:Point):Boolean
		{
			if (!inMap(point.x, point.y) || inList(_closeList, point))
				return false;
			return true;
		}
		
		private function inMap(x:int, y:int):Boolean
		{
			if (_map[x] && _map[x][y] && _map[x][y] == 1)
				return true;
			return false;
		}
		
		private function inList(_list:Array, point:Point):Point
		{
			if (!_list || _list.length == 0)
				return null;
			for (var i:int = 0; i < _list.length; i++)
			{
				var po:Point = _list[i];
				if (po.x == point.x && po.y == point.y)
					return po;
			}
			return null;
		}
	
	}

}
import flash.display.Sprite;

class Rect extends Sprite
{
	private var _enable:int;
	
	public function Rect(enable:int)
	{
		this._enable = enable;
		create();
	}
	
	public function create():void
	{
		this.graphics.clear();
		if (_enable)
			this.graphics.lineStyle(1, 0);
		else
			this.graphics.beginFill(0, 1);
		
		this.graphics.drawRect(0, 0, 40, 40);
		this.graphics.endFill();
	}
	
	public function turn():void
	{
		this.graphics.clear();
		this.graphics.beginFill(0x00ff00, 1);
		this.graphics.drawRect(0, 0, 40, 40);
		this.graphics.endFill();
	}
}

class Point
{
	private var _x:int;
	private var _y:int;
	private var _g:int;
	private var _h:int;
	private var _f:int;
	private var _parent:Point;
	
	public function get x():int
	{
		return _x;
	}
	
	public function set x(value:int):void
	{
		_x = value;
	}
	
	public function get y():int
	{
		return _y;
	}
	
	public function set y(value:int):void
	{
		_y = value;
	}
	
	public function get g():int
	{
		return _g;
	}
	
	public function set g(value:int):void
	{
		_g = value;
	}
	
	public function get h():int
	{
		return _h;
	}
	
	public function set h(value:int):void
	{
		_h = value;
	}
	
	public function get f():int
	{
		return _f;
	}
	
	public function set f(f:int):void
	{
		this._f = f;
	}
	
	public function get parent():Point
	{
		return _parent;
	}
	
	public function set parent(value:Point):void
	{
		_parent = value;
	}
	
	public function cacF():void
	{
		_f = _g + _h;
	}
	
	public function toString():String 
	{
		return "[Point x=" + x + " y=" + y + " g=" + g + " h=" + h + " f=" + f + "]";
	}
}