//class Assets
package 
{
    import flash.filesystem.*;
    import flash.utils.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class Assets extends starling.utils.AssetManager
    {
        public function Assets(arg1:Number=1, arg2:Boolean=false)
        {
            this._atlases = new flash.utils.Dictionary();
            this._fonts = new flash.utils.Dictionary();
            this.appDir = flash.filesystem.File.applicationDirectory;
            super(arg1, arg2);
            return;
        }

        public function load():void
        {
            this.loadQueue(this.onProgress);
            return;
        }

        public function queueAssets():void
        {
            this.customQueue(this._atlases);
            this.customQueue(this._fonts);
            return;
        }

        public function addAtlas(arg1:String):void
        {
            if (this._atlases.hasOwnProperty(arg1)) 
            {
                trace("ERROR: Atlas already exists");
            }
            else 
            {
                this._atlases[arg1] = [arg1 + ".xml", arg1 + ".png"];
            }
            return;
        }

        public function addFont(arg1:String):void
        {
            if (this._fonts.hasOwnProperty(arg1)) 
            {
                trace("ERROR: Font already exists");
            }
            else 
            {
                this._fonts[arg1] = [arg1];
            }
            return;
        }

        public function onProgress(arg1:Number):void
        {
            var loc1:*=arg1 * 100;
            dispatchEvent(new starling.events.Event(EVENT_ASSETS_PROGRESS, false, loc1));
            if (arg1 == 1) 
            {
                dispatchEvent(new starling.events.Event(EVENT_ASSETS_LOADED));
            }
            return;
        }

        protected function init(arg1:Number=1):void
        {
            scaleFactor = arg1;
            return;
        }

        internal function customQueue(arg1:flash.utils.Dictionary):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=0;
            var loc4:*=0;
            var loc5:*=arg1;
            for (loc2 in loc5) 
            {
                loc3 = arg1[loc2];
                loc1 = 0;
                while (loc1 < loc3.length) 
                {
                    this.enqueue(this.appDir.resolvePath(loc3[loc1]));
                    ++loc1;
                }
            }
            return;
        }

        public static const EVENT_ASSETS_LOADED:String="EVENT_ASSETS_LOADED";

        public static const EVENT_ASSETS_PROGRESS:String="EVENT_ASSETS_PROGRESS";

        public var isInitialized:Boolean=false;

        internal var _atlases:flash.utils.Dictionary;

        internal var _fonts:flash.utils.Dictionary;

        internal var appDir:flash.filesystem.File;
    }
}


