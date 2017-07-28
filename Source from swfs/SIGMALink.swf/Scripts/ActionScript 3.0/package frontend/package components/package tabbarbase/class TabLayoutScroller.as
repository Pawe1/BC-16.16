//class TabLayoutScroller
package frontend.components.tabbarbase 
{
    import core.general.*;
    import frontend.components.scrollContainer.*;
    import starling.display.*;
    
    public class TabLayoutScroller extends frontend.components.scrollContainer.CustomVScrollContainer implements frontend.components.tabbarbase.ITabLayoutContainer
    {
        public function TabLayoutScroller()
        {
            super();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            return;
        }

        public function get icon():String
        {
            return this._icon;
        }

        public function set icon(arg1:String):void
        {
            this._icon = arg1;
            return;
        }

        public function get label():String
        {
            return this._label;
        }

        public function set label(arg1:String):void
        {
            this._label = arg1;
            return;
        }

        public function get subHeader():String
        {
            return this._subHeader;
        }

        public function set subHeader(arg1:String):void
        {
            this._subHeader = arg1;
            return;
        }

        public function showContent():void
        {
            return;
        }

        public function hideContent():void
        {
            return;
        }

        internal var _icon:String="";

        internal var _label:String="";

        internal var _subHeader:String="";
    }
}


