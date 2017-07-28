//class GVDispatcher
package com.milkmangames.nativeextensions 
{
    import __AS3__.vec.*;
    import flash.events.*;
    
    public class GVDispatcher extends flash.events.EventDispatcher
    {
        public function GVDispatcher()
        {
            super();
            if (!_isCreating) 
            {
                throw new Error("Use an async method of GoViral.goViral to create a GVDispatcher..");
            }
            this.eventIDs = new Vector.<String>();
            return;
        }

        protected function addListener(arg1:String, arg2:Function):void
        {
            this.addEventListener(arg1, arg2, false, 0, false);
            this.eventIDs.push(arg1);
            return;
        }

        public override function dispatchEvent(arg1:flash.events.Event):Boolean
        {
            return super.dispatchEvent(arg1);
        }

        function removeListeners():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this.eventIDs;
            for each (loc1 in loc3) 
            {
                if (!this.hasEventListener(loc1)) 
                {
                    continue;
                }
                this.removeEventListener(loc1, this.listener);
            }
            this.listener = null;
            this.eventIDs.length = 0;
            return;
        }

        
        {
            _isCreating = false;
        }

        var requestID:String;

        protected var listener:Function;

        protected var eventIDs:__AS3__.vec.Vector.<String>;

        static var _isCreating:Boolean=false;
    }
}


