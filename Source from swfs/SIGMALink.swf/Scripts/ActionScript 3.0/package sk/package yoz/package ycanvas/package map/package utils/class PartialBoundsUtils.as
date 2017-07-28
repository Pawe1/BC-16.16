//class PartialBoundsUtils
package sk.yoz.ycanvas.map.utils 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import sk.yoz.ycanvas.map.valueObjects.*;
    
    public class PartialBoundsUtils extends Object
    {
        public function PartialBoundsUtils()
        {
            super();
            return;
        }

        public static function mergeListToRectangle(arg1:__AS3__.vec.Vector.<sk.yoz.ycanvas.map.valueObjects.PartialBounds>):flash.geom.Rectangle
        {
            var loc7:*=0;
            var loc6:*=0;
            var loc1:*=arg1[0];
            var loc8:*;
            var loc3:*=(loc8 = loc1.rectangle).x;
            var loc2:*=loc8.y;
            var loc5:*=loc8.x + loc8.width;
            var loc4:*=loc8.y + loc8.height;
            loc7 = 1;
            loc6 = arg1.length;
            while (loc7 < loc6) 
            {
                loc1 = arg1[loc7];
                if ((loc8 = loc1.rectangle).x < loc3) 
                {
                    loc3 = loc8.x;
                }
                if (loc8.y < loc2) 
                {
                    loc2 = loc8.y;
                }
                if (loc8.x + loc8.width > loc5) 
                {
                    loc5 = loc8.x + loc8.width;
                }
                if (loc8.y + loc8.height > loc4) 
                {
                    loc4 = loc8.y + loc8.height;
                }
                ++loc7;
            }
            return new flash.geom.Rectangle(loc3, loc2, loc5 - loc3, loc4 - loc2);
        }
    }
}


