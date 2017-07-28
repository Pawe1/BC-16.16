//class Application
package feathers.core 
{
    import feathers.controls.*;
    import feathers.utils.display.*;
    import flash.display.*;
    import flash.errors.*;
    import starling.core.*;
    import starling.events.*;
    
    public class Application extends feathers.controls.LayoutGroup implements feathers.core.IApplication
    {
        public function Application()
        {
            super();
            this.autoSizeMode = feathers.controls.LayoutGroup.AUTO_SIZE_MODE_STAGE;
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.application_addedToStageHandler);
            return;
        }

        public function get theme():Class
        {
            return this._theme;
        }

        public function set theme(arg1:Class):void
        {
            if (this._isInitialized) 
            {
                throw new flash.errors.IllegalOperationError("theme can only be set in MXML before an application has initialized.");
            }
            this._theme = arg1;
            return;
        }

        public function get context3DProfile():String
        {
            if (this._context3DProfile !== null) 
            {
                return this._context3DProfile;
            }
            return starling.core.Starling.current.profile;
        }

        public function set context3DProfile(arg1:String):void
        {
            if (this._isInitialized) 
            {
                throw new flash.errors.IllegalOperationError("context3DProfile can only be set in MXML before an application has initialized.");
            }
            this._context3DProfile = arg1;
            return;
        }

        public function get shareContext():Boolean
        {
            return this._shareContext;
        }

        public function set shareContext(arg1:Boolean):void
        {
            if (this._isInitialized) 
            {
                throw new flash.errors.IllegalOperationError("shareContext can only be set in MXML before an application has initialized.");
            }
            this._shareContext = arg1;
            return;
        }

        public function get skipUnchangedFrames():Boolean
        {
            return this._skipUnchangedFrames;
        }

        public function set skipUnchangedFrames(arg1:Boolean):void
        {
            this._skipUnchangedFrames = arg1;
            var loc1:*=feathers.utils.display.stageToStarling(this.stage);
            if (loc1 !== null) 
            {
                loc1.skipUnchangedFrames = arg1;
            }
            return;
        }

        public function get showStats():Boolean
        {
            return this._showStats;
        }

        public function set showStats(arg1:Boolean):void
        {
            this._showStats = arg1;
            var loc1:*=feathers.utils.display.stageToStarling(this.stage);
            if (loc1 !== null) 
            {
                loc1.showStats = arg1;
            }
            return;
        }

        protected function application_addedToStageHandler(arg1:starling.events.Event):void
        {
            var loc3:*=null;
            var loc1:*=feathers.utils.display.stageToStarling(this.stage);
            var loc2:*=loc1.nativeStage;
            if ("nativeWindow" in loc2) 
            {
                loc3 = loc2["nativeWindow"];
                if (loc3) 
                {
                    loc3.visible = true;
                }
            }
            return;
        }

        protected var _theme:Class;

        protected var _context3DProfile:String;

        protected var _shareContext:Boolean=false;

        protected var _skipUnchangedFrames:Boolean=true;

        protected var _showStats:Boolean=false;
    }
}


