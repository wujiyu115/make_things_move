package  hit.quadtree.hitTest.normal
{
    import flash.display.*;

    public class NormalHitTest extends Object
    {
        private static var _checks:Vector.<DisplayObject>;

        public function NormalHitTest()
        {
            return;
        }// end function

        public static function check(param1:Vector.<DisplayObject>) : void
        {
            var _loc_4:DisplayObject = null;
            var _loc_5:int = 0;
            var _loc_6:DisplayObject = null;
            _checks = new Vector.<DisplayObject>;
            var _loc_2:* = param1.length;
            var _loc_3:int = 0;
            while (_loc_3 < (_loc_2 - 1))
            {
                
                _loc_4 = param1[_loc_3];
                _loc_5 = _loc_3 + 1;
                while (_loc_5 < _loc_2)
                {
                    
                    _loc_6 = param1[_loc_5];
                    _checks.push(_loc_4, _loc_6);
                    _loc_5 = _loc_5 + 1;
                }
                _loc_3 = _loc_3 + 1;
            }
            return;
        }// end function

        public static function get checks() : Vector.<DisplayObject>
        {
            return _checks;
        }// end function

    }
}
