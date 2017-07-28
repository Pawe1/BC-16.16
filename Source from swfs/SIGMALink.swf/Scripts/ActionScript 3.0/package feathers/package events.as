//package events
//  class CollectionEventType
package feathers.events 
{
    public class CollectionEventType extends Object
    {
        public function CollectionEventType()
        {
            super();
            return;
        }

        public static const RESET:String="reset";

        public static const ADD_ITEM:String="addItem";

        public static const REMOVE_ITEM:String="removeItem";

        public static const REPLACE_ITEM:String="replaceItem";

        public static const UPDATE_ITEM:String="updateItem";

        public static const UPDATE_ALL:String="updateAll";
    }
}


//  class ExclusiveTouch
package feathers.events 
{
    import flash.utils.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ExclusiveTouch extends starling.events.EventDispatcher
    {
        public function ExclusiveTouch(arg1:starling.display.Stage)
        {
            this._claims = new flash.utils.Dictionary();
            super();
            if (!arg1) 
            {
                throw new ArgumentError("Stage cannot be null.");
            }
            this._stage = arg1;
            return;
        }

        public function claimTouch(arg1:int, arg2:starling.display.DisplayObject):Boolean
        {
            if (!arg2) 
            {
                throw new ArgumentError("Target cannot be null.");
            }
            if (arg2.stage != this._stage) 
            {
                throw new ArgumentError("Target cannot claim a touch on the selected stage because it appears on a different stage.");
            }
            if (arg1 < 0) 
            {
                throw new ArgumentError("Invalid touch. Touch ID must be >= 0.");
            }
            var loc1:*=starling.display.DisplayObject(this._claims[arg1]);
            if (loc1) 
            {
                return false;
            }
            this._claims[arg1] = arg2;
            if (this._stageListenerCount == 0) 
            {
                this._stage.addEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            }
            var loc2:*;
            var loc3:*=((loc2 = this)._stageListenerCount + 1);
            loc2._stageListenerCount = loc3;
            this.dispatchEventWith(starling.events.Event.CHANGE, false, arg1);
            return true;
        }

        public function removeClaim(arg1:int):void
        {
            var loc1:*=starling.display.DisplayObject(this._claims[arg1]);
            if (!loc1) 
            {
                return;
            }
            delete this._claims[arg1];
            this.dispatchEventWith(starling.events.Event.CHANGE, false, arg1);
            return;
        }

        public function getClaim(arg1:int):starling.display.DisplayObject
        {
            if (arg1 < 0) 
            {
                throw new ArgumentError("Invalid touch. Touch ID must be >= 0.");
            }
            return starling.display.DisplayObject(this._claims[arg1]);
        }

        protected function stage_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=this._claims;
            for (loc1 in loc5) 
            {
                loc2 = loc1 as int;
                loc3 = arg1.getTouch(this._stage, starling.events.TouchPhase.ENDED, loc2);
                if (!loc3) 
                {
                    continue;
                }
                delete this._claims[loc1];
                var loc6:*;
                var loc7:*=((loc6 = this)._stageListenerCount - 1);
                loc6._stageListenerCount = loc7;
            }
            if (this._stageListenerCount == 0) 
            {
                this._stage.removeEventListener(starling.events.TouchEvent.TOUCH, this.stage_touchHandler);
            }
            return;
        }

        public static function forStage(arg1:starling.display.Stage):feathers.events.ExclusiveTouch
        {
            if (!arg1) 
            {
                throw new ArgumentError("Stage cannot be null.");
            }
            var loc1:*=ExclusiveTouch(stageToObject[arg1]);
            if (loc1) 
            {
                return loc1;
            }
            loc1 = new ExclusiveTouch(arg1);
            stageToObject[arg1] = loc1;
            return loc1;
        }

        public static function disposeForStage(arg1:starling.display.Stage):void
        {
            delete stageToObject[arg1];
            return;
        }

        protected static const stageToObject:flash.utils.Dictionary=new flash.utils.Dictionary(true);

        protected var _stageListenerCount:int=0;

        protected var _stage:starling.display.Stage;

        protected var _claims:flash.utils.Dictionary;
    }
}


//  class FeathersEventType
package feathers.events 
{
    public class FeathersEventType extends Object
    {
        public function FeathersEventType()
        {
            super();
            return;
        }

        public static const INITIALIZE:String="initialize";

        public static const CREATION_COMPLETE:String="creationComplete";

        public static const RESIZE:String="resize";

        public static const ENTER:String="enter";

        public static const CLEAR:String="clear";

        public static const SCROLL_START:String="scrollStart";

        public static const SCROLL_COMPLETE:String="scrollComplete";

        public static const BEGIN_INTERACTION:String="beginInteraction";

        public static const END_INTERACTION:String="endInteraction";

        public static const TRANSITION_START:String="transitionStart";

        public static const TRANSITION_COMPLETE:String="transitionComplete";

        public static const TRANSITION_IN_START:String="transitionInStart";

        public static const TRANSITION_IN_COMPLETE:String="transitionInComplete";

        public static const TRANSITION_OUT_START:String="transitionOutStart";

        public static const TRANSITION_OUT_COMPLETE:String="transitionOutComplete";

        public static const TRANSITION_CANCEL:String="transitionCancel";

        public static const FOCUS_IN:String="focusIn";

        public static const FOCUS_OUT:String="focusOut";

        public static const RENDERER_ADD:String="rendererAdd";

        public static const RENDERER_REMOVE:String="rendererRemove";

        public static const ERROR:String="error";

        public static const LAYOUT_DATA_CHANGE:String="layoutDataChange";

        public static const LONG_PRESS:String="longPress";

        public static const SOFT_KEYBOARD_ACTIVATE:String="softKeyboardActivate";

        public static const SOFT_KEYBOARD_DEACTIVATE:String="softKeyboardDeactivate";

        public static const PROGRESS:String="progress";

        public static const LOCATION_CHANGE:String="locationChange";

        public static const LOCATION_CHANGING:String="locationChanging";

        public static const STATE_CHANGE:String="stageChange";
    }
}


//  class MediaPlayerEventType
package feathers.events 
{
    public class MediaPlayerEventType extends Object
    {
        public function MediaPlayerEventType()
        {
            super();
            return;
        }

        public static const DISPLAY_STATE_CHANGE:String="displayStageChange";

        public static const PLAYBACK_STATE_CHANGE:String="playbackStageChange";

        public static const TOTAL_TIME_CHANGE:String="totalTimeChange";

        public static const CURRENT_TIME_CHANGE:String="currentTimeChange";

        public static const DIMENSIONS_CHANGE:String="dimensionsChange";

        public static const SOUND_TRANSFORM_CHANGE:String="soundTransformChange";

        public static const METADATA_RECEIVED:String="metadataReceived";

        public static const CUE_POINT:String="cuePoint";

        public static const XMP_DATA:String="xmpData";

        public static const LOAD_PROGRESS:String="loadProgress";

        public static const LOAD_COMPLETE:String="loadComplete";
    }
}


//  class PropertyChangeEventData
package feathers.events 
{
    import __AS3__.vec.*;
    
    public class PropertyChangeEventData extends Object
    {
        public function PropertyChangeEventData(arg1:String="update", arg2:Object=null, arg3:Object=null, arg4:Object=null, arg5:Object=null)
        {
            super();
            this.reset(arg1, arg2, arg3, arg4, arg5);
            return;
        }

        public function reset(arg1:String, arg2:Object, arg3:Object, arg4:Object, arg5:Object):feathers.events.PropertyChangeEventData
        {
            this.kind = arg1;
            this.property = arg2;
            this.newValue = arg3;
            this.oldValue = arg4;
            this.source = arg5;
            return this;
        }

        public static function fromPool(arg1:String, arg2:Object, arg3:Object, arg4:Object, arg5:Object):feathers.events.PropertyChangeEventData
        {
            if (POOL.length > 0) 
            {
                return POOL.pop().reset(arg1, arg2, arg3, arg4, arg5);
            }
            return new PropertyChangeEventData(arg1, arg2, arg3, arg4, arg5);
        }

        public static function toPool(arg1:feathers.events.PropertyChangeEventData):void
        {
            arg1.newValue = null;
            arg1.oldValue = null;
            arg1.source = null;
            arg1.kind = null;
            arg1.property = null;
            POOL[POOL.length] = arg1;
            return;
        }

        public static const KIND_UPDATE:String="update";

        public static const KIND_DELETE:String="delete";

        internal static const POOL:__AS3__.vec.Vector.<feathers.events.PropertyChangeEventData>=new Vector.<>(0);

        public var kind:String;

        public var property:Object;

        public var newValue:Object;

        public var oldValue:Object;

        public var source:Object;
    }
}


