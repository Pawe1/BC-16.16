//class ScrollScreen
package feathers.controls 
{
    import feathers.skins.*;
    import feathers.utils.display.*;
    import flash.events.*;
    import flash.ui.*;
    import starling.core.*;
    import starling.events.*;
    
    public class ScrollScreen extends feathers.controls.ScrollContainer implements feathers.controls.IScreen
    {
        public function ScrollScreen()
        {
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.scrollScreen_addedToStageHandler);
            super();
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return ScrollScreen.globalStyleProvider;
        }

        public function get screenID():String
        {
            return this._screenID;
        }

        public function set screenID(arg1:String):void
        {
            this._screenID = arg1;
            return;
        }

        public function get owner():Object
        {
            return this._owner;
        }

        public function set owner(arg1:Object):void
        {
            this._owner = arg1;
            return;
        }

        protected function scrollScreen_addedToStageHandler(arg1:starling.events.Event):void
        {
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.scrollScreen_removedFromStageHandler);
            var loc1:*=-feathers.utils.display.getDisplayObjectDepthFromStage(this);
            var loc2:*=feathers.utils.display.stageToStarling(this.stage);
            loc2.nativeStage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.scrollScreen_nativeStage_keyDownHandler, false, loc1, true);
            return;
        }

        protected function scrollScreen_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.scrollScreen_removedFromStageHandler);
            var loc1:*=feathers.utils.display.stageToStarling(this.stage);
            loc1.nativeStage.removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.scrollScreen_nativeStage_keyDownHandler);
            return;
        }

        protected function scrollScreen_nativeStage_keyDownHandler(arg1:flash.events.KeyboardEvent):void
        {
            if (arg1.isDefaultPrevented()) 
            {
                return;
            }
            if (!(this.backButtonHandler == null) && arg1.keyCode == flash.ui.Keyboard.BACK) 
            {
                arg1.preventDefault();
                this.backButtonHandler();
            }
            if (!(this.menuButtonHandler == null) && arg1.keyCode == flash.ui.Keyboard.MENU) 
            {
                arg1.preventDefault();
                this.menuButtonHandler();
            }
            if (!(this.searchButtonHandler == null) && arg1.keyCode == flash.ui.Keyboard.SEARCH) 
            {
                arg1.preventDefault();
                this.searchButtonHandler();
            }
            return;
        }

        public static const SCROLL_POLICY_AUTO:String="auto";

        public static const SCROLL_POLICY_ON:String="on";

        public static const SCROLL_POLICY_OFF:String="off";

        public static const SCROLL_BAR_DISPLAY_MODE_FLOAT:String="float";

        public static const SCROLL_BAR_DISPLAY_MODE_FIXED:String="fixed";

        public static const SCROLL_BAR_DISPLAY_MODE_NONE:String="none";

        public static const VERTICAL_SCROLL_BAR_POSITION_RIGHT:String="right";

        public static const VERTICAL_SCROLL_BAR_POSITION_LEFT:String="left";

        public static const INTERACTION_MODE_TOUCH:String="touch";

        public static const INTERACTION_MODE_MOUSE:String="mouse";

        public static const INTERACTION_MODE_TOUCH_AND_SCROLL_BARS:String="touchAndScrollBars";

        public static const DECELERATION_RATE_NORMAL:Number=0.998;

        public static const DECELERATION_RATE_FAST:Number=0.99;

        public static const AUTO_SIZE_MODE_STAGE:String="stage";

        public static const AUTO_SIZE_MODE_CONTENT:String="content";

        protected var _screenID:String;

        protected var _owner:Object;

        protected var backButtonHandler:Function;

        protected var menuButtonHandler:Function;

        protected var searchButtonHandler:Function;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


