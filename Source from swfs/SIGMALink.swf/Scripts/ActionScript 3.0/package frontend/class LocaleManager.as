//class LocaleManager
package frontend 
{
    import com.adobe.utils.*;
    import debug.*;
    import flash.events.*;
    import flash.filesystem.*;
    import flash.utils.*;
    
    public class LocaleManager extends Object
    {
        public function LocaleManager()
        {
            super();
            this._localeChain = new Array();
            this._requiredBundlesReady = true;
            this.bundles = new flash.utils.Dictionary();
            this.loadingQueue = new Array();
            return;
        }

        public function get loadingQueue():Array
        {
            return this._loadingQueue;
        }

        public function set loadingQueue(arg1:Array):void
        {
            this._loadingQueue = arg1;
            return;
        }

        public function get localeChain():Array
        {
            return this._localeChain;
        }

        public function set localeChain(arg1:Array):void
        {
            this._localeChain = arg1;
            return;
        }

        public function get requiredBundlesReady():Boolean
        {
            return this._requiredBundlesReady;
        }

        public function addRequiredBundles(arg1:Array, arg2:Function=null):void
        {
            var bundles:Array;
            var onRequiredComplete:Function=null;
            var i:int;
            var successForAll:Boolean;
            var onComplete:Function;

            var loc1:*;
            successForAll = false;
            onComplete = null;
            bundles = arg1;
            onRequiredComplete = arg2;
            onComplete = function (arg1:String, arg2:String, arg3:Boolean):void
            {
                var loc1:*=0;
                var loc2:*=0;
                if (onRequiredComplete is Function) 
                {
                    if (!arg3) 
                    {
                        successForAll = false;
                    }
                    loc1 = loadingQueue.length;
                    loc2 = 0;
                    while (loc2 < loc1) 
                    {
                        if (loadingQueue[loc2].onComplete === onComplete) 
                        {
                            return;
                        }
                        ++loc2;
                    }
                    if (successForAll) 
                    {
                        _requiredBundlesReady = true;
                    }
                    onRequiredComplete(successForAll);
                }
                return;
            }
            this._requiredBundlesReady = false;
            i = (bundles.length - 1);
            while (i >= 0) 
            {
                this.loadingQueue.unshift({"locale":bundles[i].locale, "bundleName":bundles[i].bundleName, "useLinebreak":bundles[i].useLinebreak, "onComplete":onComplete});
                if (this.localeChain.indexOf(bundles[i].locale) < 0) 
                {
                    this.localeChain.push(bundles[i].locale);
                }
                --i;
            }
            successForAll = true;
            if (this.loadingQueue.length == bundles.length) 
            {
                this.loadBundle();
            }
            return;
        }

        public function addBundle(arg1:String, arg2:String, arg3:Boolean=false, arg4:Function=null):void
        {
            debug.Debug.info("adding bundle to the queue (duplicate check done before loading)");
            this.loadingQueue.push({"locale":arg1, "bundleName":arg2, "useLinebreak":arg3, "onComplete":arg4});
            if (this.localeChain.indexOf(arg1) < 0) 
            {
                this.localeChain.push(arg1);
            }
            if (this.loadingQueue.length == 1) 
            {
                this.loadBundle();
            }
            return;
        }

        public function getString(arg1:String, arg2:String, arg3:Array=null, arg4:String=null):String
        {
            var loc3:*=null;
            var loc1:*=this._localeChain.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                if (this._localeChain[loc2] in this.bundles && arg1 in this.bundles[this._localeChain[loc2]] && arg2 in this.bundles[this._localeChain[loc2]][arg1]) 
                {
                    loc3 = this.bundles[this._localeChain[loc2]][arg1][arg2];
                    return loc3;
                }
                ++loc2;
            }
            debug.Debug.error("getString(" + arg1 + ", " + arg2 + "): No matching resource found.");
            return "";
        }

        internal function unqueueFirst(arg1:Boolean):void
        {
            var loc1:*=this.loadingQueue.shift();
            if (loc1.onComplete is Function) 
            {
                loc1.onComplete(loc1.locale, loc1.bundleName, arg1);
            }
            this.timeoutID = flash.utils.setTimeout(this.loadBundle, 1);
            return;
        }

        internal function loadBundle():void
        {
            var identifier:Object;
            var file:flash.filesystem.File;
            var fileStream:flash.filesystem.FileStream;
            var onComplete:Function;

            var loc1:*;
            identifier = null;
            fileStream = null;
            onComplete = null;
            onComplete = function (arg1:flash.events.Event):void
            {
                var event:flash.events.Event;
                var success:Boolean;

                var loc1:*;
                event = arg1;
                success = false;
                try 
                {
                    parseBundle(identifier.locale, identifier.bundleName, fileStream.readUTFBytes(fileStream.bytesAvailable), identifier.useLinebreak);
                    success = true;
                }
                catch (e:Error)
                {
                    debug.Debug.error("Could not read/parse FileStream. Error: " + e.toString());
                }
                finally
                {
                    fileStream.close();
                    unqueueFirst(success);
                }
                return;
            }
            if (this.timeoutID) 
            {
                flash.utils.clearTimeout(this.timeoutID);
            }
            if (this.loadingQueue.length < 1) 
            {
                return;
            }
            identifier = this.loadingQueue[0];
            if (identifier.locale in this.bundles && identifier.bundleName in this.bundles[identifier.locale]) 
            {
                debug.Debug.debug("loadBundle: Bundle " + identifier.locale + "/" + identifier.bundleName + " is already available.");
                this.unqueueFirst(true);
                return;
            }
            file = flash.filesystem.File.applicationDirectory.resolvePath("locale/" + identifier.locale + "/" + identifier.bundleName + ".txt");
            debug.Debug.info("Locale file: " + file.toString());
            if (!file.exists) 
            {
                debug.Debug.error("File locale/" + identifier.locale + "/" + identifier.bundleName + ".txt does not exist.");
                this.unqueueFirst(false);
                return;
            }
            fileStream = new flash.filesystem.FileStream();
            fileStream.addEventListener(flash.events.Event.COMPLETE, onComplete);
            try 
            {
                debug.Debug.info("Loading resource bundle " + identifier.locale + "/" + identifier.bundleName + ".");
                fileStream.openAsync(file, flash.filesystem.FileMode.READ);
            }
            catch (e:Error)
            {
                debug.Debug.error("Could not open FileStream. Error: " + e.toString());
                unqueueFirst(false);
            }
            return;
        }

        internal function parseBundle(arg1:String, arg2:String, arg3:String, arg4:Boolean=false):void
        {
            var loc3:*=null;
            if (!(arg1 in this.bundles)) 
            {
                this.bundles[arg1] = new flash.utils.Dictionary();
            }
            this.bundles[arg1][arg2] = new flash.utils.Dictionary();
            var loc1:*=arg3.split("\r");
            var loc2:*=loc1.length;
            var loc4:*=0;
            while (loc4 < loc2) 
            {
                loc3 = loc1[loc4].split("=", 2);
                if (!(loc3.length < 2)) 
                {
                    if (arg4) 
                    {
                        loc3[1] = loc3[1].split("\\r").join("\r");
                    }
                    this.bundles[arg1][arg2][com.adobe.utils.StringUtil.trim(loc3[0])] = com.adobe.utils.StringUtil.trim(loc3[1]);
                }
                ++loc4;
            }
            return;
        }

        internal var _loadingQueue:Array;

        internal var _localeChain:Array;

        internal var _requiredBundlesReady:Boolean;

        internal var bundles:flash.utils.Dictionary;

        internal var timeoutID:uint;
    }
}


