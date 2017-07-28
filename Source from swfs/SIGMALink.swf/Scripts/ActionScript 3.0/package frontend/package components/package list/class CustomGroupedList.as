//class CustomGroupedList
package frontend.components.list 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import starling.display.*;
    
    public class CustomGroupedList extends feathers.controls.GroupedList
    {
        public function CustomGroupedList()
        {
            super();
            backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            clipContent = frontend.components.list.ListSetting.CLIP_CONTENT;
            autoHideBackground = frontend.components.list.ListSetting.AUTO_HIDE_BACKGROUND;
            useFixedThrowDuration = frontend.components.list.ListSetting.USE_FIXED_THROW_DURATION;
            horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_OFF;
            return;
        }

        public override function set layout(arg1:feathers.layout.ILayout):void
        {
            if (arg1 is feathers.layout.VerticalLayout) 
            {
                (arg1 as feathers.layout.VerticalLayout).stickyHeader = this.stickyHeader;
                (arg1 as feathers.layout.VerticalLayout).useVirtualLayout = this.useVirtualLayout;
            }
            super.layout = arg1;
            return;
        }

        protected override function throwVertically(arg1:Number):void
        {
            arg1 = arg1 + arg1 * frontend.components.list.ListSetting.SCROLL_ACCELERATION_FACTOR;
            super.throwVertically(arg1);
            return;
        }

        public var stickyHeader:Boolean=true;

        public var useVirtualLayout:Boolean=true;
    }
}


