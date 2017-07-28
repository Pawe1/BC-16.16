//class DescribeTypeCache
package feathers.binding.utils 
{
    import feathers.binding.*;
    import flash.utils.*;
    
    public class DescribeTypeCache extends Object
    {
        public function DescribeTypeCache()
        {
            super();
            return;
        }

        public static function describeType(arg1:*):feathers.binding.utils.DescribeTypeCacheRecord
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (arg1 is String) 
            {
                var loc5:*;
                loc1 = loc5 = arg1;
                loc2 = loc5;
            }
            else 
            {
                loc1 = loc5 = flash.utils.getQualifiedClassName(arg1);
                loc2 = loc5;
            }
            if (arg1 is Class) 
            {
                loc2 = loc2 + "$";
            }
            if (loc2 in typeCache) 
            {
                return typeCache[loc2];
            }
            if (arg1 is String) 
            {
                try 
                {
                    arg1 = flash.utils.getDefinitionByName(arg1);
                }
                catch (error:ReferenceError)
                {
                };
            }
            loc3 = flash.utils.describeType(arg1);
            loc4 = new feathers.binding.utils.DescribeTypeCacheRecord();
            loc4.typeDescription = loc3;
            loc4.typeName = loc1;
            typeCache[loc2] = loc4;
            return loc4;
        }

        public static function registerCacheHandler(arg1:String, arg2:Function):void
        {
            cacheHandlers[arg1] = arg2;
            return;
        }

        static function extractValue(arg1:String, arg2:feathers.binding.utils.DescribeTypeCacheRecord):*
        {
            if (arg1 in cacheHandlers) 
            {
                var loc1:*;
                return (loc1 = cacheHandlers)[arg1](arg2);
            }
            return undefined;
        }

        internal static function bindabilityInfoHandler(arg1:feathers.binding.utils.DescribeTypeCacheRecord):*
        {
            return new feathers.binding.BindabilityInfo(arg1.typeDescription);
        }

        
        {
            typeCache = {};
            cacheHandlers = {};
            registerCacheHandler("bindabilityInfo", bindabilityInfoHandler);
        }

        internal static var typeCache:Object;

        internal static var cacheHandlers:Object;
    }
}


