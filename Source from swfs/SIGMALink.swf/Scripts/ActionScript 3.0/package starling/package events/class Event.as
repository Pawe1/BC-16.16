//class Event
package starling.events 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    import starling.core.*;
    import starling.utils.*;
    
    use namespace starling_internal;
    
    public class Event extends Object
    {
        public function Event(arg1:String, arg2:Boolean=false, arg3:Object=null)
        {
            super();
            this._type = arg1;
            this._bubbles = arg2;
            this._data = arg3;
            return;
        }

        function setData(arg1:Object):void
        {
            this._data = arg1;
            return;
        }

        function get stopsPropagation():Boolean
        {
            return this._stopsPropagation;
        }

        function get stopsImmediatePropagation():Boolean
        {
            return this._stopsImmediatePropagation;
        }

        starling_internal function reset(arg1:String, arg2:Boolean=false, arg3:Object=null):starling.events.Event
        {
            this._type = arg1;
            this._bubbles = arg2;
            this._data = arg3;
            var loc1:*;
            this._currentTarget = loc1 = null;
            this._target = loc1;
            this._stopsImmediatePropagation = loc1 = false;
            this._stopsPropagation = loc1;
            return this;
        }

        starling_internal static function toPool(arg1:starling.events.Event):void
        {
            var loc1:*;
            arg1._currentTarget = loc1 = null;
            arg1._target = loc1 = loc1;
            arg1._data = loc1;
            sEventPool[sEventPool.length] = arg1;
            return;
        }

        public function get target():starling.events.EventDispatcher
        {
            return this._target;
        }

        starling_internal static function fromPool(arg1:String, arg2:Boolean=false, arg3:Object=null):starling.events.Event
        {
            if (sEventPool.length) 
            {
                return sEventPool.pop().reset(arg1, arg2, arg3);
            }
            return new Event(arg1, arg2, arg3);
        }

        public function stopPropagation():void
        {
            this._stopsPropagation = true;
            return;
        }

        public function stopImmediatePropagation():void
        {
            var loc1:*;
            this._stopsImmediatePropagation = loc1 = true;
            this._stopsPropagation = loc1;
            return;
        }

        public function toString():String
        {
            return starling.utils.StringUtil.format("[{0} type=\"{1}\" bubbles={2}]", flash.utils.getQualifiedClassName(this).split("::").pop(), this._type, this._bubbles);
        }

        public function get bubbles():Boolean
        {
            return this._bubbles;
        }

        
        {
            sEventPool = new Vector.<>(0);
        }

        public function get currentTarget():starling.events.EventDispatcher
        {
            return this._currentTarget;
        }

        public function get type():String
        {
            return this._type;
        }

        public function get data():Object
        {
            return this._data;
        }

        function setTarget(arg1:starling.events.EventDispatcher):void
        {
            this._target = arg1;
            return;
        }

        function setCurrentTarget(arg1:starling.events.EventDispatcher):void
        {
            this._currentTarget = arg1;
            return;
        }

        public static const FATAL_ERROR:String="fatalError";

        public static const READY:String="ready";

        public static const UPDATE:String="update";

        public static const SELECT:String="select";

        public static const ADDED:String="added";

        public static const ADDED_TO_STAGE:String="addedToStage";

        public static const ENTER_FRAME:String="enterFrame";

        public static const REMOVED:String="removed";

        public static const REMOVED_FROM_STAGE:String="removedFromStage";

        public static const TRIGGERED:String="triggered";

        public static const RESIZE:String="resize";

        public static const COMPLETE:String="complete";

        public static const CONTEXT3D_CREATE:String="context3DCreate";

        public static const RENDER:String="render";

        public static const ROOT_CREATED:String="rootCreated";

        public static const REMOVE_FROM_JUGGLER:String="removeFromJuggler";

        public static const TEXTURES_RESTORED:String="texturesRestored";

        public static const IO_ERROR:String="ioError";

        public static const SECURITY_ERROR:String="securityError";

        public static const PARSE_ERROR:String="parseError";

        public static const CHANGE:String="change";

        public static const CANCEL:String="cancel";

        public static const SCROLL:String="scroll";

        public static const OPEN:String="open";

        public static const CLOSE:String="close";

        internal var _target:starling.events.EventDispatcher;

        internal var _currentTarget:starling.events.EventDispatcher;

        internal var _type:String;

        internal var _bubbles:Boolean;

        internal static var sEventPool:__AS3__.vec.Vector.<starling.events.Event>;

        internal var _data:Object;

        internal var _stopsPropagation:Boolean;

        internal var _stopsImmediatePropagation:Boolean;
    }
}


