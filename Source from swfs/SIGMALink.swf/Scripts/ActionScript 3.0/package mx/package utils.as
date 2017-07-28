//package utils
//  class IXMLNotifiable
package mx.utils 
{
    public interface IXMLNotifiable
    {
        function xmlNotification(arg1:Object, arg2:String, arg3:Object, arg4:Object, arg5:Object):void;
    }
}


//  class NameUtil
package mx.utils 
{
    import flash.display.*;
    import flash.utils.*;
    import mx.core.*;
    
    use namespace mx_internal;
    
    public class NameUtil extends Object
    {
        public function NameUtil()
        {
            super();
            return;
        }

        public static function createUniqueName(arg1:Object):String
        {
            if (!arg1) 
            {
                return null;
            }
            var loc1:*=flash.utils.getQualifiedClassName(arg1);
            var loc2:*=loc1.indexOf("::");
            if (loc2 != -1) 
            {
                loc1 = loc1.substr(loc2 + 2);
            }
            var loc3:*=loc1.charCodeAt((loc1.length - 1));
            if (loc3 >= 48 && loc3 <= 57) 
            {
                loc1 = loc1 + "_";
            }
            var loc4:*;
            return loc1 + counter++;
        }

        public static function displayObjectToString(arg1:flash.display.DisplayObject):String
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            try 
            {
                loc2 = arg1;
                while (loc2 != null) 
                {
                    if (!(loc2.parent && loc2.stage && loc2.parent == loc2.stage)) 
                    {
                    };
                    loc3 = "id" in loc2 && loc2["id"] ? loc2["id"] : loc2.name;
                    if (loc2 is mx.core.IRepeaterClient) 
                    {
                        loc4 = mx.core.IRepeaterClient(loc2).instanceIndices;
                        if (loc4) 
                        {
                            loc3 = loc3 + ("[" + loc4.join("][") + "]");
                        }
                    }
                    loc1 = loc1 != null ? loc3 + "." + loc1 : loc3;
                    loc2 = loc2.parent;
                }
            }
            catch (e:SecurityError)
            {
            };
            return loc1;
        }

        public static function getUnqualifiedClassName(arg1:Object):String
        {
            var loc1:*=null;
            if (arg1 is String) 
            {
                loc1 = arg1 as String;
            }
            else 
            {
                loc1 = flash.utils.getQualifiedClassName(arg1);
            }
            var loc2:*=loc1.indexOf("::");
            if (loc2 != -1) 
            {
                loc1 = loc1.substr(loc2 + 2);
            }
            return loc1;
        }

        
        {
            mx_internal::VERSION = "4.14.0.0";
            counter = 0;
        }

        mx_internal static const VERSION:String="4.14.0.0";

        internal static var counter:int=0;
    }
}


//  class StringUtil
package mx.utils 
{
    import mx.core.*;
    
    use namespace mx_internal;
    
    public class StringUtil extends Object
    {
        public function StringUtil()
        {
            super();
            return;
        }

        public static function trim(arg1:String):String
        {
            if (arg1 == null) 
            {
                return "";
            }
            var loc1:*=0;
            while (isWhitespace(arg1.charAt(loc1))) 
            {
                ++loc1;
            }
            var loc2:*=(arg1.length - 1);
            while (isWhitespace(arg1.charAt(loc2))) 
            {
                --loc2;
            }
            if (loc2 >= loc1) 
            {
                return arg1.slice(loc1, loc2 + 1);
            }
            return "";
        }

        public static function trimArrayElements(arg1:String, arg2:String):String
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=0;
            if (!(arg1 == "") && !(arg1 == null)) 
            {
                loc1 = arg1.split(arg2);
                loc2 = loc1.length;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    loc1[loc3] = mx.utils.StringUtil.trim(loc1[loc3]);
                    ++loc3;
                }
                if (loc2 > 0) 
                {
                    arg1 = loc1.join(arg2);
                }
            }
            return arg1;
        }

        public static function isWhitespace(arg1:String):Boolean
        {
            var loc1:*=arg1;
            switch (loc1) 
            {
                case " ":
                case "\t":
                case "\r":
                case "\n":
                case "":
                {
                    return true;
                }
                default:
                {
                    return false;
                }
            }
        }

        public static function substitute(arg1:String, ... rest):String
        {
            var loc2:*=null;
            if (arg1 == null) 
            {
                return "";
            }
            var loc1:*=rest.length;
            if (loc1 == 1 && rest[0] is Array) 
            {
                loc2 = rest[0] as Array;
                loc1 = loc2.length;
            }
            else 
            {
                loc2 = rest;
            }
            var loc3:*=0;
            while (loc3 < loc1) 
            {
                arg1 = arg1.replace(new RegExp("\\{" + loc3 + "\\}", "g"), loc2[loc3]);
                ++loc3;
            }
            return arg1;
        }

        public static function repeat(arg1:String, arg2:int):String
        {
            if (arg2 == 0) 
            {
                return "";
            }
            var loc1:*=arg1;
            var loc2:*=1;
            while (loc2 < arg2) 
            {
                loc1 = loc1 + arg1;
                ++loc2;
            }
            return loc1;
        }

        public static function restrict(arg1:String, arg2:String):String
        {
            var loc4:*=0;
            if (arg2 == null) 
            {
                return arg1;
            }
            if (arg2 == "") 
            {
                return "";
            }
            var loc1:*=[];
            var loc2:*=arg1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = arg1.charCodeAt(loc3);
                if (testCharacter(loc4, arg2)) 
                {
                    loc1.push(loc4);
                }
                ++loc3;
            }
            return String.fromCharCode.apply(null, loc1);
        }

        internal static function testCharacter(arg1:uint, arg2:String):Boolean
        {
            var loc7:*=0;
            var loc9:*=false;
            var loc1:*=false;
            var loc2:*=false;
            var loc3:*=false;
            var loc4:*=true;
            var loc5:*=0;
            var loc6:*=arg2.length;
            if (loc6 > 0) 
            {
                loc7 = arg2.charCodeAt(0);
                if (loc7 == 94) 
                {
                    loc1 = true;
                }
            }
            var loc8:*=0;
            while (loc8 < loc6) 
            {
                loc7 = arg2.charCodeAt(loc8);
                loc9 = false;
                if (loc2) 
                {
                    loc9 = true;
                    loc2 = false;
                }
                else if (loc7 != 45) 
                {
                    if (loc7 != 94) 
                    {
                        if (loc7 != 92) 
                        {
                            loc9 = true;
                        }
                        else 
                        {
                            loc2 = true;
                        }
                    }
                    else 
                    {
                        loc4 = !loc4;
                    }
                }
                else 
                {
                    loc3 = true;
                }
                if (loc9) 
                {
                    if (loc3) 
                    {
                        if (loc5 <= arg1 && arg1 <= loc7) 
                        {
                            loc1 = loc4;
                        }
                        loc3 = false;
                        loc5 = 0;
                    }
                    else 
                    {
                        if (arg1 == loc7) 
                        {
                            loc1 = loc4;
                        }
                        loc5 = loc7;
                    }
                }
                ++loc8;
            }
            return loc1;
        }

        
        {
            mx_internal::VERSION = "4.6.0.23201";
        }

        mx_internal static const VERSION:String="4.6.0.23201";
    }
}


//  class XMLNotifier
package mx.utils 
{
    import flash.utils.*;
    import mx.core.*;
    
    use namespace mx_internal;
    
    public class XMLNotifier extends Object
    {
        public function XMLNotifier(arg1:XMLNotifierSingleton)
        {
            super();
            return;
        }

        public function watchXML(arg1:Object, arg2:mx.utils.IXMLNotifiable, arg3:String=null):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (arg1 is XMLList && arg1.length() > 1) 
            {
                var loc5:*=0;
                var loc6:*=arg1;
                for each (loc1 in loc6) 
                {
                    this.watchXML(loc1, arg2, arg3);
                }
            }
            else 
            {
                loc2 = XML(arg1);
                loc3 = loc2.notification();
                if (!(loc3 is Function)) 
                {
                    loc3 = mx_internal::initializeXMLForNotification();
                    loc2.setNotification(loc3 as Function);
                    if (arg3 && loc3["uid"] == null) 
                    {
                        loc3["uid"] = arg3;
                    }
                }
                if (loc3["watched"] != undefined) 
                {
                    loc4 = loc3["watched"];
                }
                else 
                {
                    loc4 = loc5 = new flash.utils.Dictionary(true);
                    loc3["watched"] = loc5;
                }
                loc4[arg2] = true;
            }
            return;
        }

        public function unwatchXML(arg1:Object, arg2:mx.utils.IXMLNotifiable):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (arg1 is XMLList && arg1.length() > 1) 
            {
                var loc5:*=0;
                var loc6:*=arg1;
                for each (loc1 in loc6) 
                {
                    this.unwatchXML(loc1, arg2);
                }
            }
            else 
            {
                loc2 = XML(arg1);
                loc3 = loc2.notification();
                if (!(loc3 is Function)) 
                {
                    return;
                }
                if (loc3["watched"] != undefined) 
                {
                    loc4 = loc3["watched"];
                    delete loc4[arg2];
                }
            }
            return;
        }

        public static function getInstance():mx.utils.XMLNotifier
        {
            if (!instance) 
            {
                instance = new XMLNotifier(new XMLNotifierSingleton());
            }
            return instance;
        }

        mx_internal static function initializeXMLForNotification():Function
        {
            var notificationFunction:Function;

            var loc1:*;
            notificationFunction = function (arg1:Object, arg2:String, arg3:Object, arg4:Object, arg5:Object):void
            {
                var loc2:*=null;
                var loc1:*=arguments.callee.watched;
                if (loc1 != null) 
                {
                    var loc3:*=0;
                    var loc4:*=loc1;
                    for (loc2 in loc4) 
                    {
                        mx.utils.IXMLNotifiable(loc2).xmlNotification(arg1, arg2, arg3, arg4, arg5);
                    }
                }
                return;
            }
            return notificationFunction;
        }

        
        {
            mx_internal::VERSION = "4.6.0.23201";
        }

        mx_internal static const VERSION:String="4.6.0.23201";

        internal static var instance:mx.utils.XMLNotifier;
    }
}


class XMLNotifierSingleton extends Object
{
    public function XMLNotifierSingleton()
    {
        super();
        return;
    }
}

