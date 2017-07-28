//class VerticalLayoutData
package feathers.layout 
{
    import starling.events.*;
    
    public class VerticalLayoutData extends starling.events.EventDispatcher implements feathers.layout.ILayoutData
    {
        public function VerticalLayoutData(arg1:Number=NaN, arg2:Number=NaN)
        {
            super();
            this._percentWidth = arg1;
            this._percentHeight = arg2;
            return;
        }

        public function get percentWidth():Number
        {
            return this._percentWidth;
        }

        public function set percentWidth(arg1:Number):void
        {
            if (this._percentWidth == arg1) 
            {
                return;
            }
            this._percentWidth = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get percentHeight():Number
        {
            return this._percentHeight;
        }

        public function set percentHeight(arg1:Number):void
        {
            if (this._percentHeight == arg1) 
            {
                return;
            }
            this._percentHeight = arg1;
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected var _percentWidth:Number;

        protected var _percentHeight:Number;
    }
}


