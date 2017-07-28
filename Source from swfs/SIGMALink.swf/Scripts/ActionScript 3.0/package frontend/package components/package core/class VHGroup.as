//class VHGroup
package frontend.components.core 
{
    public class VHGroup extends frontend.components.core.Group
    {
        public function VHGroup()
        {
            super();
            return;
        }

        public function get gap():Number
        {
            return _customLayout.gap;
        }

        public function set gap(arg1:Number):void
        {
            _customLayout.gap = arg1;
            return;
        }

        public function get horizontalAlign():String
        {
            return _customLayout.horizontalAlign;
        }

        public function set horizontalAlign(arg1:String):void
        {
            _customLayout.horizontalAlign = arg1;
            return;
        }

        public function get padding():Number
        {
            return _customLayout.padding;
        }

        public function set padding(arg1:Number):void
        {
            _customLayout.padding = arg1;
            return;
        }

        public function get paddingBottom():Number
        {
            return _customLayout.paddingBottom;
        }

        public function set paddingBottom(arg1:Number):void
        {
            _customLayout.paddingBottom = arg1;
            return;
        }

        public function get paddingLeft():Number
        {
            return _customLayout.paddingLeft;
        }

        public function set paddingLeft(arg1:Number):void
        {
            _customLayout.paddingLeft = arg1;
            return;
        }

        public function get paddingRight():Number
        {
            return _customLayout.paddingRight;
        }

        public function set paddingRight(arg1:Number):void
        {
            _customLayout.paddingRight = arg1;
            return;
        }

        public function get paddingTop():Number
        {
            return _customLayout.paddingTop;
        }

        public function set paddingTop(arg1:Number):void
        {
            _customLayout.paddingTop = arg1;
            return;
        }

        public function get verticalAlign():String
        {
            return _customLayout.verticalAlign;
        }

        public function set verticalAlign(arg1:String):void
        {
            _customLayout.verticalAlign = arg1;
            return;
        }
    }
}


