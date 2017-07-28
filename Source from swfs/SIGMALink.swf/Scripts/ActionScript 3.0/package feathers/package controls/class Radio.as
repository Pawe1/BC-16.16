//class Radio
package feathers.controls 
{
    import feathers.core.*;
    import feathers.skins.*;
    import flash.errors.*;
    import starling.events.*;
    
    public class Radio extends feathers.controls.ToggleButton implements feathers.core.IGroupedToggle
    {
        public function Radio()
        {
            super();
            super.isToggle = true;
            this.labelStyleName = DEFAULT_CHILD_STYLE_NAME_LABEL;
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.radio_addedToStageHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.radio_removedFromStageHandler);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return Radio.globalStyleProvider;
        }

        public override function set isToggle(arg1:Boolean):void
        {
            throw flash.errors.IllegalOperationError("Radio isToggle must always be true.");
        }

        public override function set toggleGroup(arg1:feathers.core.ToggleGroup):void
        {
            if (this._toggleGroup === arg1) 
            {
                return;
            }
            if (!arg1 && !(this._toggleGroup === defaultRadioGroup) && this.stage) 
            {
                arg1 = defaultRadioGroup;
            }
            super.toggleGroup = arg1;
            return;
        }

        protected function radio_addedToStageHandler(arg1:starling.events.Event):void
        {
            if (!this._toggleGroup) 
            {
                this.toggleGroup = defaultRadioGroup;
            }
            return;
        }

        protected function radio_removedFromStageHandler(arg1:starling.events.Event):void
        {
            if (this._toggleGroup == defaultRadioGroup) 
            {
                this._toggleGroup.removeItem(this);
            }
            return;
        }

        public static const DEFAULT_CHILD_STYLE_NAME_LABEL:String="feathers-radio-label";

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

        public static const defaultRadioGroup:feathers.core.ToggleGroup=new feathers.core.ToggleGroup();

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


