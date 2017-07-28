//class BCDEncoder
package decoder 
{
    public class BCDEncoder extends Object
    {
        public function BCDEncoder()
        {
            super();
            return;
        }

        public static function encode(arg1:Object, arg2:Array=null):Array
        {
            var loc3:*=0;
            var loc5:*=0;
            var loc4:*=0;
            if (!(arg1 is String)) 
            {
                return arg2;
            }
            var loc1:*=[];
            var loc2:*=arg1 as String;
            loc3 = 0;
            while (loc3 < loc2.length) 
            {
                loc5 = parseInt(loc2.charAt(loc3)) as uint;
                loc1.push(isNaN(loc5) ? 0 : loc5);
                ++loc3;
            }
            if (arg2 == null) 
            {
                return loc1;
            }
            loc1 = loc1.reverse();
            loc4 = 0;
            while (loc4 < arg2.length) 
            {
                arg2[loc4] = loc4 < loc1.length ? loc1[loc4] : 0;
                ++loc4;
            }
            return arg2.reverse();
        }
    }
}


