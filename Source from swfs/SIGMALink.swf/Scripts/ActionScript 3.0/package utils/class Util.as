//class Util
package utils 
{
    public class Util extends Object
    {
        public function Util()
        {
            super();
            return;
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


