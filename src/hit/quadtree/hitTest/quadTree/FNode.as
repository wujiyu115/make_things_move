package  hit.quadtree.hitTest.quadTree
{
    import flash.display.DisplayObject;

    public class FNode extends Object
    {
        public var object:DisplayObject;
        public var next:FNode;

        public function FNode()
        {
            this.object = null;
            this.next = null;
            return;
        }// end function

        public function destroy() : void
        {
            this.object = null;
            if (this.next != null)
            {
                this.next.destroy();
            }
            this.next = null;
            return;
        }// end function

    }
}
