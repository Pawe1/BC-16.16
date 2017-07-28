//class XMLNotifier
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

