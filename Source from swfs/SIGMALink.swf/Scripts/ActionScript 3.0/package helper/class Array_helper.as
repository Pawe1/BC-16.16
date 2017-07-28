//class Array_helper
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


