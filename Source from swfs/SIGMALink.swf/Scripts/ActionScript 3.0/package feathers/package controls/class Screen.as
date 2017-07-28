//class Screen
package feathers.controls 
{
    import feathers.skins.*;
    import feathers.utils.display.*;
    import flash.events.*;
    import flash.ui.*;
    import starling.core.*;
    import starling.events.*;
    
    public class Screen extends feathers.controls.LayoutGroup implements feathers.controls.IScreen
    {
        public function Screen()
        {
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.screen_addedToStageHandler);
            super();
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return Screen.globalStyleProvider;
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

        protected function screen_addedToStageHandler(arg1:starling.events.Event):void
        {
            if (arg1.target != this) 
            {
                return;
            }
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.screen_removedFromStageHandler);
            var loc1:*=-feathers.utils.display.getDisplayObjectDepthFromStage(this);
            var loc2:*=feathers.utils.display.stageToStarling(this.stage);
            loc2.nativeStage.addEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.screen_nativeStage_keyDownHandler, false, loc1, true);
            return;
        }

        protected function screen_removedFromStageHandler(arg1:starling.events.Event):void
        {
            if (arg1.target != this) 
            {
                return;
            }
            this.removeEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.screen_removedFromStageHandler);
            var loc1:*=feathers.utils.display.stageToStarling(this.stage);
            loc1.nativeStage.removeEventListener(flash.events.KeyboardEvent.KEY_DOWN, this.screen_nativeStage_keyDownHandler);
            return;
        }

        protected function screen_nativeStage_keyDownHandler(arg1:flash.events.KeyboardEvent):void
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


