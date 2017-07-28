//class LoaderOptimizer
package frontend.components.map 
{
    import com.adobe.images.*;
    import flash.display.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.net.*;
    import flash.system.*;
    import flash.utils.*;
    import helper.*;
    
    public class LoaderOptimizer extends Object
    {
        public function LoaderOptimizer(arg1:frontend.components.map.URLRequestBuffer=null)
        {
            this.created = new flash.utils.Dictionary(true);
            this.released = new flash.utils.Dictionary(true);
            super();
            this.buffer = arg1 ? arg1 : new frontend.components.map.URLRequestBuffer(6, 15000);
            helper.File_helper.createDirIfNotExist(frontend.components.map.MapLayerOptions.CACHE_DIRECTORY);
            return;
        }

        internal function xyzByUrlString(arg1:String):frontend.components.map.MapXyzPartition
        {
            if (arg1 == null || arg1.length <= 0) 
            {
                return null;
            }
            var loc1:*=arg1;
            var loc2:*=loc1.replace(frontend.components.map.MapLayerOptions.URL_MAP, "");
            var loc3:*=loc2.split("/");
            var loc4:*=loc3.pop();
            var loc5:*=loc3.pop();
            var loc6:*=loc3.pop();
            return new frontend.components.map.MapXyzPartition(loc6, loc5, loc4);
        }

        public function load(arg1:flash.net.URLRequest, arg2:flash.system.LoaderContext):flash.display.Loader
        {
            var loc2:*=null;
            var loc3:*=null;
            if (frontend.components.map.MapLayerOptions.CACHING_ENABLED) 
            {
                loc2 = this.xyzByUrlString(arg1.url);
                if (loc2) 
                {
                    loc3 = new flash.filesystem.File(frontend.components.map.MapLayerOptions.CACHE_DIRECTORY + loc2.getPath());
                    if (loc3.exists) 
                    {
                        arg1.url = loc3.url;
                    }
                }
            }
            var loc1:*=this.createLoader();
            this.buffer.push(loc1, arg1, arg2);
            return loc1;
        }

        public function release(arg1:flash.display.Loader):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            if (frontend.components.map.MapLayerOptions.CACHING_ENABLED) 
            {
                loc2 = arg1.contentLoaderInfo.url;
                if (loc2 && loc2.substr(0, 4) == "http") 
                {
                    loc3 = this.xyzByUrlString(loc2);
                    if (loc3) 
                    {
                        loc4 = new flash.filesystem.File(frontend.components.map.MapLayerOptions.CACHE_DIRECTORY + loc3.getPath());
                        if (!loc4.exists) 
                        {
                            loc5 = com.adobe.images.PNGEncoder.encode((arg1.contentLoaderInfo.content as flash.display.Bitmap).bitmapData);
                            loc6 = new flash.filesystem.FileStream();
                            loc6.open(loc4, flash.filesystem.FileMode.WRITE);
                            loc6.writeBytes(loc5, 0, loc5.length);
                            loc6.close();
                        }
                    }
                }
            }
            loc1 = this.buffer.getWaitingByLoader(arg1);
            if (loc1) 
            {
                this.buffer.removeWaitingById(loc1.id);
            }
            loc1 = this.buffer.getActiveByLoader(arg1);
            if (loc1) 
            {
                this.buffer.removeActiveById(loc1.id);
            }
            else if (this.released) 
            {
                this.removeLoaderListeners(arg1);
                this.released[arg1] = true;
            }
            return;
        }

        public function dispose():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this.created;
            for (loc1 in loc4) 
            {
                loc2 = loc1 as flash.display.Loader;
                this.release(loc2);
                this.removeLoaderListeners(loc2);
                loc2.unloadAndStop(true);
            }
            this.created = null;
            this.released = null;
            this.buffer = null;
            return;
        }

        internal function removeLoaderListeners(arg1:flash.display.Loader):void
        {
            arg1.contentLoaderInfo.removeEventListener(flash.events.Event.COMPLETE, this.onLoaderComplete, false);
            arg1.contentLoaderInfo.removeEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onLoaderIOError, false);
            return;
        }

        internal function addLoaderListeners(arg1:flash.display.Loader):void
        {
            arg1.contentLoaderInfo.addEventListener(flash.events.Event.COMPLETE, this.onLoaderComplete, false, -10, true);
            arg1.contentLoaderInfo.addEventListener(flash.events.IOErrorEvent.IO_ERROR, this.onLoaderIOError, false, -10, true);
            return;
        }

        internal function createLoader():flash.display.Loader
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this.released;
            for (loc2 in loc4) 
            {
                loc1 = loc2 as flash.display.Loader;
                delete this.released[loc1];
                break;
            }
            if (!loc1) 
            {
                loc1 = new flash.display.Loader();
                this.created[loc1] = true;
            }
            this.addLoaderListeners(loc1);
            return loc1;
        }

        internal function onLoaderComplete(arg1:flash.events.Event):void
        {
            this.release(flash.display.LoaderInfo(arg1.target).loader);
            return;
        }

        internal function onLoaderIOError(arg1:flash.events.IOErrorEvent):void
        {
            this.release(flash.display.LoaderInfo(arg1.target).loader);
            return;
        }

        internal var buffer:frontend.components.map.URLRequestBuffer;

        internal var created:flash.utils.Dictionary;

        internal var released:flash.utils.Dictionary;
    }
}


