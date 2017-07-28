//class ScreenNavigator
package feathers.controls 
{
    import feathers.controls.supportClasses.*;
    import feathers.events.*;
    import feathers.skins.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ScreenNavigator extends feathers.controls.supportClasses.BaseScreenNavigator
    {
        public function ScreenNavigator()
        {
            this._screenEvents = {};
            super();
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.ScreenNavigator.globalStyleProvider;
        }

        public function get transition():Function
        {
            return this._transition;
        }

        public function set transition(arg1:Function):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._transition = arg1;
            return;
        }

        public function get mxmlContent():Array
        {
            return this._mxmlContent;
        }

        public function set mxmlContent(arg1:Array):void
        {
            var loc3:*=null;
            var loc4:*=null;
            if (this._mxmlContent == arg1) 
            {
                return;
            }
            this._mxmlContent = arg1;
            this.removeAllScreens();
            var loc1:*=arg1.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = feathers.controls.ScreenNavigatorItem(arg1[loc2]);
                loc4 = loc3.mxmlID;
                this.addScreen(loc4, loc3);
                ++loc2;
            }
            return;
        }

        public function addScreen(arg1:String, arg2:feathers.controls.ScreenNavigatorItem):void
        {
            this.addScreenInternal(arg1, arg2);
            return;
        }

        public function removeScreen(arg1:String):feathers.controls.ScreenNavigatorItem
        {
            return feathers.controls.ScreenNavigatorItem(this.removeScreenInternal(arg1));
        }

        public function getScreen(arg1:String):feathers.controls.ScreenNavigatorItem
        {
            if (this._screens.hasOwnProperty(arg1)) 
            {
                return feathers.controls.ScreenNavigatorItem(this._screens[arg1]);
            }
            return null;
        }

        public function showScreen(arg1:String, arg2:Function=null):starling.display.DisplayObject
        {
            if (this._activeScreenID === arg1) 
            {
                return this._activeScreen;
            }
            if (arg2 === null) 
            {
                arg2 = this._transition;
            }
            return this.showScreenInternal(arg1, arg2);
        }

        public function clearScreen(arg1:Function=null):void
        {
            if (arg1 == null) 
            {
                arg1 = this._transition;
            }
            this.clearScreenInternal(arg1);
            this.dispatchEventWith(feathers.events.FeathersEventType.CLEAR);
            return;
        }

        protected override function prepareActiveScreen():void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=feathers.controls.ScreenNavigatorItem(this._screens[this._activeScreenID]);
            var loc2:*=loc1.events;
            var loc3:*={};
            var loc8:*=0;
            var loc9:*=loc2;
            for (loc4 in loc9) 
            {
                loc5 = null;
                if (!(feathers.controls.supportClasses.BaseScreenNavigator.SIGNAL_TYPE === null) && this._activeScreen.hasOwnProperty(loc4)) 
                {
                    loc5 = this._activeScreen[loc4] as feathers.controls.supportClasses.BaseScreenNavigator.SIGNAL_TYPE;
                }
                loc6 = loc2[loc4];
                if (loc6 is Function) 
                {
                    if (loc5) 
                    {
                        loc5.add(loc6 as Function);
                    }
                    else 
                    {
                        this._activeScreen.addEventListener(loc4, loc6 as Function);
                    }
                    continue;
                }
                if (loc6 is String) 
                {
                    if (loc5) 
                    {
                        loc7 = this.createShowScreenSignalListener(loc6 as String, loc5);
                        loc5.add(loc7);
                    }
                    else 
                    {
                        loc7 = this.createShowScreenEventListener(loc6 as String);
                        this._activeScreen.addEventListener(loc4, loc7);
                    }
                    loc3[loc4] = loc7;
                    continue;
                }
                throw new TypeError("Unknown event action defined for screen:", loc6.toString());
            }
            this._screenEvents[this._activeScreenID] = loc3;
            return;
        }

        protected override function cleanupActiveScreen():void
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=feathers.controls.ScreenNavigatorItem(this._screens[this._activeScreenID]);
            var loc2:*=loc1.events;
            var loc3:*=this._screenEvents[this._activeScreenID];
            var loc8:*=0;
            var loc9:*=loc2;
            for (loc4 in loc9) 
            {
                loc5 = null;
                if (!(feathers.controls.supportClasses.BaseScreenNavigator.SIGNAL_TYPE === null) && this._activeScreen.hasOwnProperty(loc4)) 
                {
                    loc5 = this._activeScreen[loc4] as feathers.controls.supportClasses.BaseScreenNavigator.SIGNAL_TYPE;
                }
                loc6 = loc2[loc4];
                if (loc6 is Function) 
                {
                    if (loc5) 
                    {
                        loc5.remove(loc6 as Function);
                    }
                    else 
                    {
                        this._activeScreen.removeEventListener(loc4, loc6 as Function);
                    }
                    continue;
                }
                if (!(loc6 is String)) 
                {
                    continue;
                }
                loc7 = loc3[loc4] as Function;
                if (loc5) 
                {
                    loc5.remove(loc7);
                    continue;
                }
                this._activeScreen.removeEventListener(loc4, loc7);
            }
            this._screenEvents[this._activeScreenID] = null;
            return;
        }

        protected function createShowScreenEventListener(arg1:String):Function
        {
            var screenID:String;
            var self:feathers.controls.ScreenNavigator;
            var eventListener:Function;

            var loc1:*;
            self = null;
            screenID = arg1;
            self = this;
            eventListener = function (arg1:starling.events.Event):void
            {
                self.showScreen(screenID);
                return;
            }
            return eventListener;
        }

        protected function createShowScreenSignalListener(arg1:String, arg2:Object):Function
        {
            var screenID:String;
            var signal:Object;
            var self:feathers.controls.ScreenNavigator;
            var signalListener:Function;

            var loc1:*;
            self = null;
            signalListener = null;
            screenID = arg1;
            signal = arg2;
            self = this;
            if (signal.valueClasses.length != 1) 
            {
                signalListener = function (... rest):void
                {
                    self.showScreen(screenID);
                    return;
                }
            }
            else 
            {
                signalListener = function (arg1:Object):void
                {
                    self.showScreen(screenID);
                    return;
                }
            }
            return signalListener;
        }

        public static const AUTO_SIZE_MODE_STAGE:String="stage";

        public static const AUTO_SIZE_MODE_CONTENT:String="content";

        protected var _transition:Function;

        protected var _screenEvents:Object;

        protected var _mxmlContent:Array;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


