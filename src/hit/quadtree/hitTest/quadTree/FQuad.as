package hit.quadtree.hitTest.quadTree
{
	import flash.display.DisplayObject;
	import flash.filters.DisplacementMapFilter;
	
	public class FQuad
	{
		public var x:Number;
		public var y:Number;
		public var width:Number;
		public var height:Number;
		public static var divisions:uint;
		protected var _canSubDivide:Boolean;
		protected var _headNode:FNode;
		protected var _tailNode:FNode;
		protected static var _min:uint;
		protected var _one:FQuad;
		protected var _two:FQuad;
		protected var _three:FQuad;
		protected var _four:FQuad;
		protected var _left:Number;
		protected var _right:Number;
		protected var _top:Number;
		protected var _bottom:Number;
		protected var _hWidth:Number;
		protected var _hHeight:Number;
		protected var _midX:Number;
		protected var _midY:Number;
		protected static var _object:DisplayObject;
		protected static var _objectLeft:Number;
		protected static var _objectRight:Number;
		protected static var _objectTop:Number;
		protected static var _objectBottom:Number;
		protected static var _processingCallBack:Function;
		protected static var _iterator:FNode;
		
		public function FQuad(X:Number, Y:Number, w:Number, h:Number, p:FQuad = null)
		{
			x = X;
			y = Y;
			width = w;
			height = h;
			
			_headNode = _tailNode = new FNode();
			
			if (p != null)
			{
				var iterator:FNode;
				var ot:FNode;
				if (p._headNode.object != null)
				{
					iterator = p._headNode;
					while (iterator != null)
					{
						if (_tailNode.object != null)
						{
							ot = _tailNode;
							_tailNode = new FNode();
							ot.next = _tailNode;
						}
						_tailNode.object = iterator.object;
						iterator = iterator.next;
					}
				}
			}
			else
			{
				_min = (width + height) / (2 * divisions);
			}
			_canSubDivide = (width > _min) || (height > _min);
			
			_one = null;
			_two = null;
			_three = null;
			_four = null;
			_left = x;
			_right = x + width;
			_top = y;
			_bottom = y + height;
			_hWidth = width / 2;
			_hHeight = height / 2;
			_midX = _left + _hWidth;
			_midY = _top + _hHeight;
		}
		
		public function destroy():void
		{
			_headNode.destroy();
			_headNode = null;
			_tailNode.destroy();
			_tailNode = null;
			
			if (_one)
			{
				_one.destroy();
				_one = null;
			}
			if (_two)
			{
				_two.destroy();
				_two = null;
			}
			if (_three)
			{
				_three.destroy();
				_three = null;
			}
			if (_four)
			{
				_four.destroy();
				_four = null;
			}
			
			_object = null;
			_processingCallBack = null;
		}
		
		public function load(objVec:Vector.<DisplayObject>, back:Function = null):void
		{
			add(objVec);
			_processingCallBack = back;
		}
		
		private function add(objVec:Vector.<DisplayObject>):void
		{
			var len:int = objVec.length;
			for (var i:int = 0; i < len; i++)
			{
				_object = objVec[i];
				_objectLeft = _object.x;
				_objectTop = _object.y;
				_objectRight = _object.x + _object.width;
				_objectBottom = _object.y + _object.height;
				addObject();
			}
		}
		
		private function addObject():void
		{
			if (!_canSubDivide || ((_left >= _objectLeft) && (_right <= _objectRight) && (_top >= _objectTop) && (_bottom <= _objectBottom)))
			{
				addToList();
				return;
			}
			
			if ((_objectLeft > _left) && (_objectRight < _midX))
			{
				if ((_objectTop > _top) && (_objectBottom < _midY))
				{
					if (_one == null)
						_one = new FQuad(_left, _top, _hWidth, _hHeight, this);
					_one.addObject();
					return;
				}
				if ((_objectTop > _midY) && (_objectBottom < _bottom))
				{
					if (_four == null)
						_four = new FQuad(_left, _midY, _hWidth, _hHeight, this);
					_four.addObject();
					return;
				}
			}
			if ((_objectLeft > _midX) && (_objectRight < _right))
			{
				if ((_objectTop > _top) && (_objectBottom < _midY))
				{
					if (_two == null)
						_two = new FQuad(_midX, _top, _hWidth, _hHeight, this);
					_two.addObject();
					return;
				}
				if ((_objectTop > _midY) && (_objectBottom < _bottom))
				{
					if (_three == null)
						_three = new FQuad(_midX, _midY, _hWidth, _hHeight, this);
					_three.addObject();
					return;
				}
			}
			
			if ((_objectRight > _left) && (_objectLeft < _midX) && (_objectBottom > _top) && (_objectTop < _midY))
			{
				if (_one == null)
					_one = new FQuad(_left, _top, _hWidth, _hHeight, this);
				_one.addObject();
			}
			if ((_objectRight > _midX) && (_objectLeft < _right) && (_objectBottom > _top) && (_objectTop < _midY))
			{
				if (_two == null)
					_two = new FQuad(_midX, _top, _hWidth, _hHeight, this);
				_two.addObject();
			}
			if ((_objectRight > _midX) && (_objectLeft < _right) && (_objectBottom > _midY) && (_objectTop < _bottom))
			{
				if (_three == null)
					_three = new FQuad(_midX, _midY, _hWidth, _hHeight, this);
				_three.addObject();
			}
			if ((_objectRight > _left) && (_objectLeft < _midX) && (_objectBottom > _midY) && (_objectTop < _bottom))
			{
				if (_four == null)
					_four = new FQuad(_left, _midY, _hWidth, _hHeight, this);
				_four.addObject();
			}
		}
		
		protected function addToList():void
		{
			var ot:FNode;
			if (_tailNode.object != null)
			{
				ot = _tailNode;
				_tailNode = new FNode();
				ot.next = _tailNode;
			}
			_tailNode.object = _object;
			
			if (!_canSubDivide)
				return;
			if (_one != null)
				_one.addToList();
			if (_two != null)
				_two.addToList();
			if (_three != null)
				_three.addToList();
			if (_four != null)
				_four.addToList();
		}
		
		public function execute():void
		{
			var iterator:FNode;
			
			if (_headNode.object != null)
			{
				iterator = _headNode;
				while (iterator != null)
				{
					_object = iterator.object;
					_iterator = iterator.next;
					if (_iterator != null && _iterator.object != null)
					{
						overlapNode();
					}
					iterator = iterator.next;
				}
			}
			
			if (_one != null)
				_one.execute();
			if (_two != null)
				_two.execute();
			if (_three != null)
				_three.execute();
			if (_four != null)
				_four.execute();
		}
		
		protected function overlapNode():void
		{
			var checkObject:DisplayObject;
			while (_iterator != null)
			{
				checkObject = _iterator.object;
				if (_object === checkObject)
				{
					_iterator = _iterator.next;
					continue;
				}
				_processingCallBack(_object, checkObject);
				
				_iterator = _iterator.next;
			}
		}
	}
}