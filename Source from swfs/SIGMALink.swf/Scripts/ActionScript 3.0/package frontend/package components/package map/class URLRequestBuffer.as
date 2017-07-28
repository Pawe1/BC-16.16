//class URLRequestBuffer
package frontend.components.map 
{
    import __AS3__.vec.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    
    public class URLRequestBuffer extends flash.events.EventDispatcher
    {
        public function URLRequestBuffer(arg1:uint, arg2:uint=3000)
        {
            this.activeList = new Vector.<frontend.components.map.URLRequestBufferItem>();
            this.waitingList = new Vector.<frontend.components.map.URLRequestBufferItem>();
            super();
            this.maxRequests = Math.max(1, arg1);
            this.timeout = arg2;
            return;
        }

        public function get countActive():uint
        {
            return this.activeList.length;
        }

        public function get countWaiting():uint
        {
            return this.waitingList.length;
        }

        protected function get firstWaitingReadyItem():frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=null;
            var loc2:*=this.countWaiting;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc1 = this.waitingList[loc3];
                if (loc1.ready) 
                {
                    return loc1;
                }
                ++loc3;
            }
            return null;
        }

        public function push(arg1:flash.events.EventDispatcher, arg2:flash.net.URLRequest, arg3:flash.system.LoaderContext=null, arg4:uint=0, arg5:uint=0):frontend.components.map.URLRequestBufferItem
        {
            var loc4:*;
            var loc5:*=((loc4 = this).nextID + 1);
            loc4.nextID = loc5;
            var loc1:*=this.getIndexForPriority(arg4);
            var loc2:*=new frontend.components.map.URLRequestBufferItem(this, this.nextID, arg1, arg2, arg3, arg4, arg5);
            this.waitingList.splice(loc1, 0, loc2);
            var loc3:*=frontend.components.map.URLRequestBufferEvent.WAITING_REQUEST_ADDED;
            dispatchEvent(new frontend.components.map.URLRequestBufferEvent(loc3, false, false, loc2));
            this.loadNext();
            return loc2;
        }

        public function getWaitingItem(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            return this.waitingList[arg1];
        }

        public function getActiveItem(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            return this.activeList[arg1];
        }

        protected function getIndexForPriority(arg1:uint):uint
        {
            var loc1:*=this.countWaiting;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (arg1 > this.waitingList[loc2].priority) 
                {
                    return loc2;
                }
                ++loc2;
            }
            return loc1;
        }

        public function loadNext():void
        {
            if (this.countActive >= this.maxRequests || !this.countWaiting) 
            {
                return;
            }
            var loc1:*=this.firstWaitingReadyItem;
            if (!loc1) 
            {
                return;
            }
            this.removeWaitingById(loc1.id);
            this.createListeners(loc1.dispatcher);
            loc1.load();
            this.activeList.push(loc1);
            flash.utils.setTimeout(this.onTimeout, this.timeout, loc1.id);
            var loc2:*=frontend.components.map.URLRequestBufferEvent.ACTIVE_REQUEST_ADDED;
            dispatchEvent(new frontend.components.map.URLRequestBufferEvent(loc2, false, false, loc1));
            this.loadNext();
            return;
        }

        protected function createListeners(arg1:flash.events.EventDispatcher):void
        {
            arg1.addEventListener(flash.events.Event.COMPLETE, this.onComplete);
            arg1.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onIOError);
            return;
        }

        protected function removeListeners(arg1:flash.events.EventDispatcher):void
        {
            arg1.removeEventListener(flash.events.Event.COMPLETE, this.onComplete);
            arg1.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onIOError);
            return;
        }

        protected function onComplete(arg1:flash.events.Event):void
        {
            var loc1:*=frontend.components.map.URLRequestBufferItem.getLoader(arg1);
            var loc2:*=this.getActiveByLoader(loc1);
            if (loc2) 
            {
                this.removeActiveById(loc2.id);
            }
            this.loadNext();
            return;
        }

        protected function onIOError(arg1:flash.events.IOErrorEvent):void
        {
            var loc1:*=frontend.components.map.URLRequestBufferItem.getLoader(arg1);
            var loc2:*=this.getActiveByLoader(loc1);
            if (loc2) 
            {
                this.removeActiveById(loc2.id);
            }
            this.loadNext();
            return;
        }

        protected function onTimeout(arg1:uint):void
        {
            var loc1:*=this.getActiveById(arg1);
            if (!loc1) 
            {
                return;
            }
            this.removeActiveById(arg1);
            var loc2:*=frontend.components.map.URLRequestBufferEvent.REQUEST_TIMEOUT;
            dispatchEvent(new frontend.components.map.URLRequestBufferEvent(loc2, false, false, loc1));
            return;
        }

        public function getWaitingById(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.countWaiting;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this.waitingList[loc2].id == arg1) 
                {
                    return this.waitingList[loc2];
                }
                ++loc2;
            }
            return null;
        }

        public function getWaitingByLoader(arg1:flash.events.EventDispatcher):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.countWaiting;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this.waitingList[loc2].loader == arg1) 
                {
                    return this.waitingList[loc2];
                }
                ++loc2;
            }
            return null;
        }

        public function removeWaitingById(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.getWaitingById(arg1);
            if (!loc1) 
            {
                return null;
            }
            this.waitingList.splice(this.waitingList.indexOf(loc1), 1);
            var loc2:*=frontend.components.map.URLRequestBufferEvent.WAITING_REQUEST_REMOVED;
            dispatchEvent(new frontend.components.map.URLRequestBufferEvent(loc2, false, false, loc1));
            return loc1;
        }

        public function getActiveById(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.countActive;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this.activeList[loc2].id == arg1) 
                {
                    return this.activeList[loc2];
                }
                ++loc2;
            }
            return null;
        }

        public function getActiveByLoader(arg1:flash.events.EventDispatcher):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.countActive;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this.activeList[loc2].loader == arg1) 
                {
                    return this.activeList[loc2];
                }
                ++loc2;
            }
            return null;
        }

        public function removeActiveById(arg1:uint):frontend.components.map.URLRequestBufferItem
        {
            var loc1:*=this.getActiveById(arg1);
            if (!loc1) 
            {
                return null;
            }
            this.removeListeners(loc1.dispatcher);
            loc1.close();
            this.activeList.splice(this.activeList.indexOf(loc1), 1);
            var loc2:*=frontend.components.map.URLRequestBufferEvent.ACTIVE_REQUEST_REMOVED;
            dispatchEvent(new frontend.components.map.URLRequestBufferEvent(loc2, false, false, loc1));
            this.loadNext();
            return loc1;
        }

        internal var activeList:__AS3__.vec.Vector.<frontend.components.map.URLRequestBufferItem>;

        internal var maxRequests:uint=2;

        internal var nextID:uint=0;

        internal var timeout:uint;

        internal var waitingList:__AS3__.vec.Vector.<frontend.components.map.URLRequestBufferItem>;
    }
}


