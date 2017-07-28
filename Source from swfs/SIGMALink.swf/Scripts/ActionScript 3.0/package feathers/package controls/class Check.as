//class Check
package feathers.controls 
{
    import feathers.skins.*;
    import flash.errors.*;
    
    public class Check extends feathers.controls.ToggleButton
    {
        public function Check()
        {
            super();
            this.labelStyleName = DEFAULT_CHILD_STYLE_NAME_LABEL;
            super.isToggle = true;
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return Check.globalStyleProvider;
        }

        public override function set isToggle(arg1:Boolean):void
        {
            throw flash.errors.IllegalOperationError("CheckBox isToggle must always be true.");
        }

        public static const DEFAULT_CHILD_STYLE_NAME_LABEL:String="feathers-check-label";

        public static const STATE_UP:String="up";

        public static const STATE_DOWN:String="down";

        public static const STATE_HOVER:String="hover";

        public static const STATE_DISABLED:String="disabled";

        public static const STATE_UP_AND_SELECTED:String="upAndSelected";

        public static const STATE_DOWN_AND_SELECTED:String="downAndSelected";

        public static const STATE_HOVER_AND_SELECTED:String="hoverAndSelected";

        public static const STATE_DISABLED_AND_SELECTED:String="disabledAndSelected";

        public static const ICON_POSITION_TOP:String="top";

        public static const ICON_POSITION_RIGHT:String="right";

        public static const ICON_POSITION_BOTTOM:String="bottom";

        public static const ICON_POSITION_LEFT:String="left";

        public static const ICON_POSITION_MANUAL:String="manual";

        public static const ICON_POSITION_LEFT_BASELINE:String="leftBaseline";

        public static const ICON_POSITION_RIGHT_BASELINE:String="rightBaseline";

        public static const HORIZONTAL_ALIGN_LEFT:String="left";

        public static const HORIZONTAL_ALIGN_CENTER:String="center";

        public static const HORIZONTAL_ALIGN_RIGHT:String="right";

        public static const VERTICAL_ALIGN_TOP:String="top";

        public static const VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const VERTICAL_ALIGN_BOTTOM:String="bottom";

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


