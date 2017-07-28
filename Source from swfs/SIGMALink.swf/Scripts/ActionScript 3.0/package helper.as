//package helper
//  class Array_helper
package helper 
{
    import flash.utils.*;
    
    public final class Array_helper extends Object
    {
        public function Array_helper()
        {
            super();
            return;
        }

        public static function flatten(arg1:Array):Array
        {
            var loc2:*=0;
            var loc1:*=[];
            loc2 = 0;
            while (loc2 < arg1.length) 
            {
                loc1 = loc1.concat(arg1[loc2]);
                ++loc2;
            }
            return loc1;
        }

        public static function fillArray(arg1:uint):Array
        {
            var loc1:*=new Array(arg1);
            var loc2:*=0;
            while (loc2 < arg1) 
            {
                loc1[loc2] = 0;
                ++loc2;
            }
            return loc1;
        }

        public static function merge(arg1:Array):Array
        {
            var loc2:*=0;
            var loc1:*=[];
            loc2 = 0;
            while (loc2 < arg1.length) 
            {
                loc1 = loc1.concat(arg1[loc2]);
                ++loc2;
            }
            return loc1;
        }

        public static function mergeInto(arg1:Array, arg2:Array, arg3:uint=0, arg4:uint=0):void
        {
            var loc1:*=0;
            if (arg4 == 0 || arg4 > arg1.length) 
            {
                arg4 = arg1.length;
            }
            while (loc1 < arg4) 
            {
                arg2[arg3 + loc1] = arg1[loc1];
                ++loc1;
            }
            return;
        }

        public static function push_from_object(arg1:Object, arg2:Array):Array
        {
            var loc1:*=null;
            if (!arg1) 
            {
                return arg2;
            }
            var loc4:*=0;
            var loc3:*=arg1;
            for each (var loc2:* in loc3) 
            {
                loc1 = {"i":arg1[loc2]};
                arg2.push(loc1);
            }
            return arg2;
        }

        public static function fromByteArray(arg1:flash.utils.ByteArray):Array
        {
            var loc1:*=[];
            var loc2:*=0;
            arg1.position = 0;
            while (arg1.bytesAvailable) 
            {
                loc2 = arg1.readUnsignedByte();
                loc1.push(loc2);
            }
            return loc1;
        }

        public static function toByteArray(arg1:Array):flash.utils.ByteArray
        {
            var loc1:*=0;
            var loc2:*=new flash.utils.ByteArray();
            if (arg1 != null) 
            {
                loc1 = 0;
                while (loc1 < arg1.length) 
                {
                    loc2.writeByte(arg1[loc1]);
                    ++loc1;
                }
            }
            loc2.position = 0;
            return loc2;
        }

        public static function inArray(arg1:Array, arg2:*):Boolean
        {
            return arg1.indexOf(arg2) >= 0;
        }

        public static function hexArrayToIntArray(arg1:Array):Array
        {
            var loc1:*=0;
            var loc2:*=[];
            loc1 = 0;
            while (loc1 < arg1.length) 
            {
                loc2.push(parseInt(arg1[loc1], 16));
                ++loc1;
            }
            return loc2;
        }

        public static function intArraytoHexArray(arg1:Array):Array
        {
            var loc2:*=0;
            var loc1:*=[];
            var loc3:*="";
            loc2 = 0;
            while (loc2 < arg1.length) 
            {
                if ((loc3 = (arg1[loc2] as int).toString(16)).length == 1) 
                {
                    loc3 = "0" + loc3;
                }
                loc1.push(loc3.toUpperCase());
                ++loc2;
            }
            return loc1;
        }

        public static function toArray(arg1:*):Array
        {
            var loc1:*=[];
            var loc4:*=0;
            var loc3:*=arg1;
            for each (var loc2:* in loc3) 
            {
                loc1.push(loc2);
            }
            return loc1;
        }
    }
}


//  class ByteArray_helper
package helper 
{
    import flash.utils.*;
    
    public class ByteArray_helper extends Object
    {
        public function ByteArray_helper()
        {
            super();
            return;
        }

        public static function toArray(arg1:flash.utils.ByteArray):Array
        {
            var loc1:*=[];
            var loc2:*=0;
            arg1.position = 0;
            while (arg1.bytesAvailable) 
            {
                loc2 = arg1.readUnsignedByte();
                loc1.push(loc2);
            }
            return loc1;
        }

        public static function fromDelimitedString(arg1:String, arg2:String=" "):flash.utils.ByteArray
        {
            return fromArray(arg1.split(arg2));
        }

        public static function fromArray(arg1:Array):flash.utils.ByteArray
        {
            var loc3:*=new flash.utils.ByteArray();
            var loc1:*=arg1.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3.writeByte(arg1[loc2]);
                ++loc2;
            }
            return loc3;
        }
    }
}


//  class Capabilities_helper
package helper 
{
    import flash.system.*;
    
    public final class Capabilities_helper extends Object
    {
        public function Capabilities_helper()
        {
            super();
            return;
        }

        public static function get APPNAME():String
        {
            if (_appname == null) 
            {
                _appname = appXml.ns::name;
            }
            return _appname;
        }

        public static function get APPVERSION():String
        {
            if (_appversion == null) 
            {
                _appversion = appXml.ns::versionNumber;
            }
            return _appversion;
        }

        public static function get DEVICE():String
        {
            if (_platform.indexOf("ios") > -1) 
            {
                return "IOS";
            }
            if (_platform.indexOf("and") > -1) 
            {
                return "ANDROID";
            }
            if (_platform.indexOf("win") > -1) 
            {
                return "WINDOWS";
            }
            if (_platform.indexOf("mac") > -1) 
            {
                return "MACOSX";
            }
            return "UNDEFINED";
        }

        public static function set appXML(arg1:XML):void
        {
            _appxml = arg1;
            return;
        }

        internal static function get appXml():XML
        {
            return _appxml;
        }

        internal static function get ns():Namespace
        {
            if (_ns == null) 
            {
                _ns = appXml.namespace();
            }
            return _ns;
        }

        public static function isAndroid():Boolean
        {
            return DEVICE == "ANDROID";
        }

        public static function isWindows():Boolean
        {
            return DEVICE == "WINDOWS";
        }

        public static function isMobile():Boolean
        {
            return DEVICE == "ANDROID" || DEVICE == "IOS";
        }

        public static function isMac():Boolean
        {
            return DEVICE == "MACOSX";
        }

        public static function isIOS():Boolean
        {
            return DEVICE == "IOS";
        }

        public static function isDesktop():Boolean
        {
            return isWindows() || isMac();
        }

        public static function isSimulator():Boolean
        {
            return isMobile() && (!(_operatingSystem.indexOf("windows") == -1) || !(_operatingSystem.indexOf("mac os") == -1));
        }

        
        {
            _operatingSystem = flash.system.Capabilities.os.toLowerCase();
            _platform = flash.system.Capabilities.version.toLowerCase();
        }

        public static const DEVICE_ANDROID:String="ANDROID";

        public static const DEVICE_IOS:String="IOS";

        public static const DEVICE_OSX:String="MACOSX";

        public static const DEVICE_UNDEFINED:String="UNDEFINED";

        public static const DEVICE_WINDOWS:String="WINDOWS";

        internal static var _appname:String;

        internal static var _appversion:String;

        internal static var _appxml:XML;

        internal static var _operatingSystem:String;

        internal static var _platform:String;

        internal static var _ns:Namespace;
    }
}


//  class File_helper
package helper 
{
    import flash.filesystem.*;
    
    public class File_helper extends Object
    {
        public function File_helper()
        {
            super();
            return;
        }

        public static function createDirIfNotExist(arg1:String):void
        {
            var loc1:*=new flash.filesystem.File(arg1);
            if (!loc1.exists) 
            {
                loc1.createDirectory();
            }
            return;
        }

        public static function directoryExists(arg1:String):Boolean
        {
            var loc1:*=new flash.filesystem.File(arg1);
            return loc1.exists;
        }

        public static function directorySize(arg1:String):Number
        {
            var loc1:*=new flash.filesystem.File(arg1);
            if (!loc1.exists) 
            {
                return 0;
            }
            return getFileSize(loc1);
        }

        public static function deleteDirectory(arg1:String):void
        {
            var loc1:*=new flash.filesystem.File(arg1);
            if (loc1.exists) 
            {
                loc1.deleteDirectoryAsync(true);
            }
            return;
        }

        public static function getFileSize(arg1:flash.filesystem.File):Number
        {
            var loc3:*=null;
            var loc1:*=0;
            if (arg1 == null || arg1.exists == false) 
            {
                return 0;
            }
            if (arg1.isDirectory) 
            {
                loc3 = arg1.getDirectoryListing();
                var loc5:*=0;
                var loc4:*=loc3;
                for each (var loc2:* in loc4) 
                {
                    if (loc2.isDirectory) 
                    {
                        loc1 = loc1 + getFileSize(loc2);
                        continue;
                    }
                    loc1 = loc1 + loc2.size;
                }
            }
            else 
            {
                return arg1.size;
            }
            return loc1;
        }
    }
}


//  class Image_helper
package helper 
{
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    
    public final class Image_helper extends Object
    {
        public function Image_helper()
        {
            super();
            return;
        }

        public static function jpeg(arg1:flash.display.BitmapData):flash.utils.ByteArray
        {
            var loc2:*=null;
            var loc1:*=flash.utils.getTimer();
            loc2 = arg1.encode(new flash.geom.Rectangle(0, 0, arg1.width, arg1.height), new flash.display.JPEGEncoderOptions(80), loc2);
            return loc2;
        }

        public static function png(arg1:flash.display.BitmapData):flash.utils.ByteArray
        {
            var loc2:*=null;
            var loc1:*=flash.utils.getTimer();
            loc2 = arg1.encode(new flash.geom.Rectangle(0, 0, arg1.width, arg1.height), new flash.display.PNGEncoderOptions(true), loc2);
            return loc2;
        }

        internal static const DEFAULT_QUALITY:uint=80;
    }
}


//  class Math_helper
package helper 
{
    public class Math_helper extends Object
    {
        public function Math_helper()
        {
            super();
            return;
        }

        public static function deg2rad(arg1:*):Number
        {
            return arg1 * 3.14159265359 / 180;
        }
    }
}


//  class Object_helper
package helper 
{
    import flash.utils.*;
    
    public class Object_helper extends Object
    {
        public function Object_helper()
        {
            super();
            return;
        }

        public static function clone(arg1:Object):*
        {
            var loc1:*=new flash.utils.ByteArray();
            loc1.writeObject(arg1);
            loc1.position = 0;
            return loc1.readObject();
        }

        public static function clone2(arg1:Object):Object
        {
            var loc1:*=null;
            if (arg1) 
            {
                loc1 = createEmptyClass(arg1);
                if (loc1) 
                {
                    copyData(arg1, loc1);
                }
            }
            return loc1;
        }

        public static function createEmptyClass(arg1:Object):*
        {
            var loc2:*=undefined;
            var loc1:*=null;
            if (arg1) 
            {
                try 
                {
                    loc1 = flash.utils.getDefinitionByName(flash.utils.getQualifiedClassName(arg1)) as Class;
                    loc2 = new loc1();
                }
                catch (error:Error)
                {
                    trace("ObjectHelper ERROR !!! failed to create new empty class[type:" + loc1 + "] out of object.[object:" + arg1 + "]");
                }
            }
            return loc2;
        }

        public static function copyData(arg1:Object, arg2:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1 && arg2) 
            {
                try 
                {
                    loc1 = flash.utils.describeType(arg1);
                    loc5 = 0;
                    var loc4:*=loc1.variable;
                    for each (loc2 in loc4) 
                    {
                        if (!arg2.hasOwnProperty(loc2.@name)) 
                        {
                            continue;
                        }
                        arg2[loc2.@name] = arg1[loc2.@name];
                    }
                    var loc7:*=0;
                    var loc6:*=loc1.accessor;
                    for each (loc2 in loc6) 
                    {
                        if (!(loc2.@access == "readwrite")) 
                        {
                            continue;
                        }
                        if (!arg2.hasOwnProperty(loc2.@name)) 
                        {
                            continue;
                        }
                        arg2[loc2.@name] = arg1[loc2.@name];
                    }
                }
                catch (error:Error)
                {
                    trace("ObjectHelper ERROR !!! failed to copy data from[" + arg1 + "] to [" + arg2 + "]. error:" + error);
                }
            }
            return;
        }

        public static function getTraceString(arg1:Object, arg2:*=false):String
        {
            return traceObject(arg1, "", arg2);
        }

        internal static function traceObject(arg1:Object, arg2:String, arg3:Boolean):String
        {
            var loc1:*=false;
            var loc3:*="";
            if (arg1 is String) 
            {
                loc3 = arg1 as String;
            }
            else if (arg1 is Boolean || arg1 is int || arg1 is uint || arg1 is Number) 
            {
                loc3 = arg1.toString();
            }
            else 
            {
                loc3 = loc3 + "{";
                loc1 = true;
                var loc5:*=0;
                var loc4:*=arg1;
                for (var loc2:* in loc4) 
                {
                    if (loc1) 
                    {
                        loc1 = false;
                    }
                    else 
                    {
                        loc3 = loc3 + ", ";
                    }
                    loc3 = loc3 + (loc2 + ":" + traceObject(arg1[loc2], arg2, arg3));
                }
                loc3 = loc3 + "}";
            }
            return loc3;
        }
    }
}


//  class Vector_helper
package helper 
{
    import __AS3__.vec.*;
    import flash.utils.*;
    
    public final class Vector_helper extends Object
    {
        public function Vector_helper()
        {
            super();
            return;
        }

        public static function stringify(arg1:__AS3__.vec.Vector.<int>, arg2:*="|"):String
        {
            if (!arg1) 
            {
                return "";
            }
            var loc1:*="";
            var loc3:*=0;
            var loc2:*=arg1.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc1 = loc1 + arg1[loc3];
                if (loc3 + 1 < loc2) 
                {
                    loc1 = loc1 + "|";
                }
                ++loc3;
            }
            return loc1;
        }

        public static function unstringify(arg1:String, arg2:*="|"):__AS3__.vec.Vector.<int>
        {
            if (!arg1) 
            {
                return new __AS3__.vec.Vector.<int>();
            }
            var loc4:*=new __AS3__.vec.Vector.<int>();
            var loc1:*=arg1.split(arg2);
            var loc3:*=0;
            var loc2:*=loc1.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc4.push(loc1[loc3]);
                ++loc3;
            }
            return loc4;
        }

        public static function getIndicesByFilter(arg1:String, arg2:String, arg3:*="|"):__AS3__.vec.Vector.<int>
        {
            if (!arg1) 
            {
                return new __AS3__.vec.Vector.<int>();
            }
            var loc4:*=new __AS3__.vec.Vector.<int>();
            var loc1:*=arg1.split(arg3);
            var loc3:*=0;
            var loc2:*=loc1.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                if (loc1[loc3] == arg2) 
                {
                    loc4.push(loc3);
                }
                ++loc3;
            }
            return loc4;
        }

        public static function isVector(arg1:*):Boolean
        {
            var loc1:*=flash.utils.getQualifiedClassName(arg1);
            return loc1.indexOf("__AS3__.vec::Vector.") >= 0;
        }

        public static function sortVector(arg1:*, arg2:String):void
        {
            var loc1:*=[];
            while (arg1.length > 0) 
            {
                loc1.push(arg1.pop());
            }
            loc1.sortOn(arg2, 16 | 2);
            while (loc1.length > 0) 
            {
                arg1.push(loc1.pop());
            }
            return;
        }

        public static const DEFAULT_DELIMITER:String="|";

        internal static const VECTOR_PREFIX:String="__AS3__.vec::Vector.";
    }
}


