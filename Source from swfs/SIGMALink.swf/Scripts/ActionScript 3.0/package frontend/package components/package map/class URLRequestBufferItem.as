//class URLRequestBufferItem
package frontend.components.map 
{
    import flash.display.*;
    import flash.events.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    
    public class URLRequestBufferItem extends Object
    {
        public function URLRequestBufferItem(arg1:frontend.components.map.URLRequestBuffer, arg2:uint, arg3:flash.events.EventDispatcher, arg4:flash.net.URLRequest, arg5:flash.system.LoaderContext, arg6:uint, arg7:uint=0)
        {
            super();
            if (!(arg3 is flash.display.Loader || arg3 is flash.net.URLLoader)) 
            {
                throw new Error("loader must be instance of Loader or " + "URLLoader class");
            }
            this.buffer = arg1;
            this.id = arg2;
            this.loader = arg3;
            this.request = arg4;
            this.context = arg5;
            this.priority = arg6;
            this.delay = arg7;
            this._ready = arg7 ? false : true;
            if (arg7) 
            {
                flash.utils.setTimeout(this.onDelay, arg7);
            }
            return;
        }

        public function get dispatcher():flash.events.EventDispatcher
        {
            return this.loader is flash.display.Loader ? (this.loader as flash.display.Loader).contentLoaderInfo : this.loader as flash.net.URLLoader;
        }

        public function get ready():Boolean
        {
            return this._ready;
        }

        public function load():void
        {
            if (this.loader is flash.display.Loader) 
            {
                (this.loader as flash.display.Loader).load(this.request, this.context);
            }
            else if (this.loader is flash.net.URLLoader) 
            {
                (this.loader as flash.net.URLLoader).load(this.request);
            }
            return;
        }

        public function close():void
        {
            try 
            {
                if (this.loader is flash.display.Loader) 
                {
                    (this.loader as flash.display.Loader).close();
                }
                else if (this.loader is flash.net.URLLoader) 
                {
                    (this.loader as flash.net.URLLoader).close();
                }
            }
            catch (error:Error)
            {
            };
            return;
        }

        protected function onDelay(arg1:flash.events.TimerEvent):void
        {
            this._ready = true;
            this.buffer.loadNext();
            return;
        }

        public static function getLoader(arg1:flash.events.Event):flash.events.EventDispatcher
        {
            return arg1.target is flash.display.LoaderInfo ? (arg1.target as flash.display.LoaderInfo).loader : arg1.target as flash.net.URLLoader;
        }

        public var buffer:frontend.components.map.URLRequestBuffer;

        public var context:flash.system.LoaderContext;

        public var delay:uint;

        public var id:uint;

        public var loader:flash.events.EventDispatcher;

        public var priority:uint;

        protected var _ready:Boolean;

        public var request:flash.net.URLRequest;
    }
}


