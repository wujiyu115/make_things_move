package  hit.quadtree.hitTest.grid
{
   import flash.display.DisplayObject;
   import flash.display.Graphics;
   import flash.events.EventDispatcher;
   import flash.utils.getTimer;

   public class GridHitTest extends EventDispatcher
   {
       private var _checks:Vector.<DisplayObject>;
       private var _grid:Vector.<Vector.<DisplayObject>>;
       private var _gridWidth:Number;
       private var _gridHeight:Number;
       private var _numGrid:int;
       private var _numCols:int;
       private var _numRows:int;
       private var _width:Number;
       private var _height:Number;
       
       public function GridHitTest(w:Number, h:Number, gw:Number, gh:Number)
       {
           _width = w;
           _height = h;
           _gridWidth = gw;
           _gridHeight = gh;
           _numCols = Math.ceil(_width / gw);
           _numRows = Math.ceil(_height / gh);
           _numGrid = _numCols * _numRows;
       }
       
       public function drawGrid(graphics:Graphics):void
       {
           graphics.lineStyle(0.5);
           for (var i:int = 0; i <= _width; i += _gridWidth)
           {
               graphics.moveTo(i, 0);
               graphics.lineTo(i, _height);
           }
           for (i = 0; i <= _height; i += _gridHeight)
           {
               graphics.moveTo(0, i);
               graphics.lineTo(_width, i);
           }
       }
       
       public function check(objects:Vector.<DisplayObject>):void
       {
           var numObjects:int = objects.length;
           _grid = new Vector.<Vector.<DisplayObject>>(_numGrid);
           _checks = new Vector.<DisplayObject>();
           for (var i:int = 0; i < numObjects; i++)
           {
               var obj:DisplayObject = objects[i];
               var index:int = int(obj.y / _gridHeight) * _numCols;
               index += int(obj.x / _gridWidth); 
               if (_grid[index] == null)
               {
                   _grid[index] = new Vector.<DisplayObject>;
               }
               _grid[index].push(obj);
           }
           checkGrid();

       }
       
       private function checkGrid():void
       {
           for (var i:int = 0; i < _numCols; i++)
           {
               for (var j:int = 0; j < _numRows; j++)
               {
                   checkOneCell(i, j);
                   checkTwoCells(i, j, i + 1, j);
                   checkTwoCells(i, j, i - 1, j + 1);
                   checkTwoCells(i, j, i, j + 1);
                   checkTwoCells(i, j, i + 1, j + 1);
               }
           }
       }
       
       private function checkOneCell(x:int, y:int):void
       {
           var cell:Vector.<DisplayObject> = _grid[y * _numCols + x];
           if (cell == null) return;
           
           var cellLength:int = cell.length;
           for (var i:int = 0; i < cellLength - 1; i++)
           {
               var objA:DisplayObject = cell[i];
               for (var j:int = i + 1; j < cellLength; j++)
               {
                   var objB:DisplayObject = cell[j];
                   _checks.push(objA, objB);
               }
           }
       }
       
       private function checkTwoCells(x1:int, y1:int, x2:int, y2:int):void
       {
           if (x2 >= _numCols || x2 < 0 || y2 >= _numRows) return;
           var cellA:Vector.<DisplayObject> = _grid[y1 * _numCols + x1];
           var cellB:Vector.<DisplayObject> = _grid[y2 * _numCols + x2];
           if (cellA == null || cellB == null) return;
           
           var cellALength:int = cellA.length;
           var cellBLength:int = cellB.length;
           for (var i:int = 0; i < cellALength; i++)
           {
               var objA:DisplayObject = cellA[i];
               for (var j:int = 0; j < cellBLength; j++)
               {
                   var objB:DisplayObject = cellB[j];
                   _checks.push(objA, objB);
               }
           }
       }
       
       public function get checks():Vector.<DisplayObject>
       {
           return _checks;
       }
   }
}