//package utils
//  class PathSimplify
package sk.yoz.utils 
{
    import __AS3__.vec.*;
    
    public class PathSimplify extends Object
    {
        public function PathSimplify()
        {
            super();
            return;
        }

        public static function getSquareSegmentDistance(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number):Number
        {
            var loc2:*=NaN;
            var loc4:*=arg3;
            var loc5:*=arg4;
            var loc1:*=arg5 - loc4;
            var loc3:*=arg6 - loc5;
            if (!(loc1 === 0) || !(loc3 === 0)) 
            {
                if ((loc2 = ((arg1 - loc4) * loc1 + (arg2 - loc5) * loc3) / (loc1 * loc1 + loc3 * loc3)) > 1) 
                {
                    loc4 = arg5;
                    loc5 = arg6;
                }
                else if (loc2 > 0) 
                {
                    loc4 = loc4 + loc1 * loc2;
                    loc5 = loc5 + loc3 * loc2;
                }
            }
            loc1 = arg1 - loc4;
            loc3 = arg2 - loc5;
            return loc1 * loc1 + loc3 * loc3;
        }

        public static function simplifyRadialDistance(arg1:__AS3__.vec.Vector.<Number>, arg2:Number):__AS3__.vec.Vector.<Number>
        {
            var loc4:*=NaN;
            var loc1:*=NaN;
            var loc8:*=0;
            var loc9:*=0;
            var loc2:*=0;
            var loc3:*=NaN;
            var loc5:*=NaN;
            var loc7:*=arg1[0];
            var loc10:*=arg1[1];
            var loc6:*=__AS3__.vec.Vector.<Number>([loc7, loc10]);
            loc8 = 2;
            loc9 = 3;
            loc2 = arg1.length;
            while (loc8 < loc2) 
            {
                loc1 = arg1[loc8];
                loc4 = arg1[loc9];
                loc3 = loc1 - loc7;
                loc5 = loc4 - loc10;
                if (loc3 * loc3 + loc5 * loc5 > arg2) 
                {
                    loc6.push(loc1, loc4);
                    loc7 = loc1;
                    loc10 = loc4;
                }
                loc8 = loc8 + 2;
                loc9 = loc9 + 2;
            }
            if (!(loc7 == loc1) || !(loc10 == loc4)) 
            {
                loc6.push(loc1, loc4);
            }
            return loc6;
        }

        public static function simplifyDouglasPeucker(arg1:__AS3__.vec.Vector.<Number>, arg2:Number):__AS3__.vec.Vector.<Number>
        {
            var loc3:*=0;
            var loc7:*=NaN;
            var loc5:*=NaN;
            var loc4:*=0;
            var loc6:*=arg1.length;
            var loc10:*=new __AS3__.vec.Vector.<Boolean>(loc6);
            var loc11:*=0;
            var loc1:*=loc6 - 2;
            var loc9:*=new __AS3__.vec.Vector.<uint>();
            var loc2:*=new __AS3__.vec.Vector.<uint>();
            var loc8:*=new __AS3__.vec.Vector.<Number>();
            var loc12:*;
            loc10[loc1] = loc12 = true;
            loc10[loc11] = loc12;
            for (;;) 
            {
                loc7 = 0;
                loc3 = loc11 + 2;
                while (loc3 < loc1) 
                {
                    if ((loc5 = getSquareSegmentDistance(arg1[loc3], arg1[loc3 + 1], arg1[loc11], arg1[loc11 + 1], arg1[loc1], arg1[loc1 + 1])) > loc7) 
                    {
                        loc4 = loc3;
                        loc7 = loc5;
                    }
                    loc3 = loc3 + 2;
                }
                if (loc7 > arg2) 
                {
                    loc10[loc4] = true;
                    loc9.push(loc11, loc4);
                    loc2.push(loc4, loc1);
                }
                if (!loc2.length) 
                {
                    break;
                }
                loc11 = loc9.pop();
                loc1 = loc2.pop();
            }
            loc3 = 0;
            while (loc3 < loc6) 
            {
                if (loc10[loc3]) 
                {
                    loc8.push(arg1[loc3], arg1[loc3 + 1]);
                }
                loc3 = loc3 + 2;
            }
            return loc8;
        }

        public static function simplify(arg1:__AS3__.vec.Vector.<Number>, arg2:Number=1, arg3:Boolean=false):__AS3__.vec.Vector.<Number>
        {
            var loc1:*=arg2 * arg2;
            if (!arg3) 
            {
                arg1 = simplifyRadialDistance(arg1, loc1);
            }
            return simplifyDouglasPeucker(arg1, loc1);
        }
    }
}


