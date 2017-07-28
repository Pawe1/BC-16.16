//class Object_helper
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


