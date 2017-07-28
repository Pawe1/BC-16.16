//class CustomHScrollContainer
package frontend.components.scrollContainer 
{
    import core.general.*;
    import feathers.controls.*;
    import frontend.components.list.*;
    import handler.*;
    import starling.display.*;
    import starling.events.*;
    
    public class CustomHScrollContainer extends feathers.controls.ScrollContainer
    {
        public function CustomHScrollContainer()
        {
            super();
            clipContent = frontend.components.list.ListSetting.CLIP_CONTENT;
            autoHideBackground = frontend.components.list.ListSetting.AUTO_HIDE_BACKGROUND;
            useFixedThrowDuration = frontend.components.list.ListSetting.USE_FIXED_THROW_DURATION;
            verticalScrollPolicy = feathers.controls.ScrollContainer.SCROLL_POLICY_OFF;
            if (!autoHideBackground) 
            {
                backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            }
            return;
        }

        protected override function throwVertically(arg1:Number):void
        {
            arg1 = arg1 + arg1 * SCROLL_ACCELERATION_FACTOR;
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

        internal function onPopUpModeChanged(arg1:starling.events.Event):void
        {
            if (handler.ViewHandler.getInstance().popUpMode) 
            {
                if (horizontalScrollPolicy == feathers.controls.Scroller.SCROLL_POLICY_OFF) 
                {
                    this._scrollPolicyOffOnPopUpClose = true;
                }
                horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_OFF;
            }
            else 
            {
                if (this._scrollPolicyOffOnPopUpClose) 
                {
                    horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_OFF;
                }
                else 
                {
                    horizontalScrollPolicy = feathers.controls.Scroller.SCROLL_POLICY_ON;
                }
                this._scrollPolicyOffOnPopUpClose = false;
            }
            return;
        }

        internal static const SCROLL_ACCELERATION_FACTOR:Number=0.8;

        internal var _scrollPolicyOffOnPopUpClose:Boolean=false;
    }
}


