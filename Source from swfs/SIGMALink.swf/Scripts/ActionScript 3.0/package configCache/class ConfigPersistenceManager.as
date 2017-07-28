//class ConfigPersistenceManager
package configCache 
{
    import flash.net.*;
    
    public class ConfigPersistenceManager extends Object implements configCache.IPersistenceManager
    {
        public function ConfigPersistenceManager()
        {
            super();
            return;
        }

        public function load():Boolean
        {
            if (initialized) 
            {
                return true;
            }
            try 
            {
                so = flash.net.SharedObject.getLocal("ConfigAppCache");
                initialized = true;
            }
            catch (e:Error)
            {
            };
            return initialized;
        }

        public function setProperty(arg1:String, arg2:Object):void
        {
            if (!initialized) 
            {
                load();
            }
            if (so != null) 
            {
                so.data[arg1] = arg2;
            }
            return;
        }

        public function getProperty(arg1:String):Object
        {
            if (!initialized) 
            {
                load();
            }
            if (so != null) 
            {
                return so.data[arg1];
            }
            return null;
        }

        public function clear():void
        {
            if (!initialized) 
            {
                load();
            }
            if (so != null) 
            {
                so.clear();
            }
            return;
        }

        public function save():Boolean
        {
            try 
            {
                so.flush();
            }
            catch (e:Error)
            {
                var loc2:*=false;
                return loc2;
            }
            return true;
        }

        internal static const SHARED_OBJECT_NAME:String="ConfigAppCache";

        internal var initialized:Boolean=false;

        internal var so:flash.net.SharedObject;
    }
}


