//class CustomList
package frontend.components.list 
{
    import feathers.controls.*;
    import feathers.layout.*;
    import handler.*;
    import starling.events.*;
    
    public class CustomList extends feathers.controls.List
    {
        public function CustomList()
        {
            super();
            clipContent = frontend.components.list.ListSetting.CLIP_CONTENT;
            autoHideBackground = frontend.components.list.ListSetting.AUTO_HIDE_BACKGROUND;
            useFixedThrowDuration = frontend.components.list.ListSetting.USE_FIXED_THROW_DURATION;
            horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_OFF;
            styleProvider = null;
            addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStage);
            return;
        }

        public override function set layout(arg1:feathers.layout.ILayout):void
        {
            if (arg1 is feathers.layout.VerticalLayout) 
            {
                (arg1 as feathers.layout.VerticalLayout).useVirtualLayout = this.useVirtualLayout;
            }
            super.layout = arg1;
            return;
        }

        protected override function throwVertically(arg1:Number):void
        {
            if (this.useCustomAcceleration) 
            {
                arg1 = arg1 + arg1 * frontend.components.list.ListSetting.SCROLL_ACCELERATION_FACTOR;
            }
            super.throwVertically(arg1);
            return;
        }

        protected override function feathersControl_addedToStageHandler(arg1:starling.events.Event):void
        {
            super.feathersControl_addedToStageHandler(arg1);
            handler.ViewHandler.getInstance().addEventListener(handler.ViewHandler.POPUP_MODE_CHANGED, this.onPopUpModeChanged);
            return;
        }

        protected override function feathersControl_removedFromStageHandler(arg1:starling.events.Event):void
        {
            super.feathersControl_removedFromStageHandler(arg1);
            handler.ViewHandler.getInstance().removeEventListener(handler.ViewHandler.POPUP_MODE_CHANGED, this.onPopUpModeChanged);
            return;
        }

        internal function onAddedToStage(arg1:starling.events.Event):void
        {
            this.validateScrollPolicy();
            return;
        }

        internal function onPopUpModeChanged(arg1:starling.events.Event):void
        {
            this.validateScrollPolicy();
            return;
        }

        public function validateScrollPolicy():void
        {
            if (this.allowScrollingInPopUpMode) 
            {
                verticalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_ON;
            }
            else 
            {
                verticalScrollPolicy = handler.ViewHandler.getInstance().popUpMode ? feathers.controls.Scroller.SCROLL_POLICY_OFF : feathers.controls.Scroller.SCROLL_POLICY_ON;
            }
            return;
        }

        public var allowScrollingInPopUpMode:Boolean=false;

        public var useCustomAcceleration:Boolean=true;

        public var useVirtualLayout:Boolean=true;
    }
}


