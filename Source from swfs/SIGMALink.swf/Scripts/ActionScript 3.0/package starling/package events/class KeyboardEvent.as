//class KeyboardEvent
package starling.events 
{
    public class KeyboardEvent extends starling.events.Event
    {
        public function KeyboardEvent(arg1:String, arg2:uint=0, arg3:uint=0, arg4:uint=0, arg5:Boolean=false, arg6:Boolean=false, arg7:Boolean=false)
        {
            super(arg1, false, arg3);
            this._charCode = arg2;
            this._keyCode = arg3;
            this._keyLocation = arg4;
            this._ctrlKey = arg5;
            this._altKey = arg6;
            this._shiftKey = arg7;
            return;
        }

        public function preventDefault():void
        {
            this._isDefaultPrevented = true;
            return;
        }

        public function isDefaultPrevented():Boolean
        {
            return this._isDefaultPrevented;
        }

        public function get charCode():uint
        {
            return this._charCode;
        }

        public function get keyCode():uint
        {
            return this._keyCode;
        }

        public function get keyLocation():uint
        {
            return this._keyLocation;
        }

        public function get altKey():Boolean
        {
            return this._altKey;
        }

        public function get ctrlKey():Boolean
        {
            return this._ctrlKey;
        }

        public function get shiftKey():Boolean
        {
            return this._shiftKey;
        }

        public static const KEY_UP:String="keyUp";

        public static const KEY_DOWN:String="keyDown";

        internal var _charCode:uint;

        internal var _keyCode:uint;

        internal var _keyLocation:uint;

        internal var _altKey:Boolean;

        internal var _ctrlKey:Boolean;

        internal var _shiftKey:Boolean;

        internal var _isDefaultPrevented:Boolean;
    }
}


