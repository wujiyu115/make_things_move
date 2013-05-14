package  hit.quadtree.hitTest
{
    import flash.display.*;

    public class Rect extends Sprite
    {
        private var _width:int;
        private var _height:int;
        private var _color:uint = 255;
        private var _vx:Number;
        private var _vy:Number;

        public function Rect(param1:int = 0, param2:int = 0)
        {
            if (param1 && param2)
            {
                this._width = param1;
                this._height = param2;
            }
            else
            {
                this._width = 5 + Math.random() * 15;
                this._height = 5 + Math.random() * 15;
            }
            this.draw();
            return;
        }// end function

        private function draw() : void
        {
            this.graphics.clear();
            this.graphics.beginFill(this._color);
            this.graphics.drawRect(0, 0, this._width, this._height);
            this.graphics.endFill();
            return;
        }// end function

        public function set color(param1:uint) : void
        {
            this._color = param1;
            this.draw();
            return;
        }// end function

        public function update() : void
        {
            this.x = this.x + this._vx;
            this.y = this.y + this._vy;
            return;
        }// end function

        public function set vx(param1:Number) : void
        {
            this._vx = param1;
            return;
        }// end function

        public function set vy(param1:Number) : void
        {
            this._vy = param1;
            return;
        }// end function

        public function get vx() : Number
        {
            return this._vx;
        }// end function

        public function get vy() : Number
        {
            return this._vy;
        }// end function

    }
}
