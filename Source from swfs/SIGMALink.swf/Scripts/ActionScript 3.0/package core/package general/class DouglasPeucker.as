//class DouglasPeucker
package core.general 
{
    import __AS3__.vec.*;
    
    public class DouglasPeucker extends Object
    {
        public function DouglasPeucker()
        {
            super();
            return;
        }

        public static function getSquareDistance(arg1:Object, arg2:Object, arg3:String, arg4:String):Number
        {
            var loc1:*=arg1[arg3] - arg2[arg3];
            var loc2:*=arg1[arg4] - arg2[arg4];
            return loc1 * loc1 + loc2 * loc2;
        }

        public static function getSquareSegmentDistance(arg1:Object, arg2:Object, arg3:Object, arg4:String, arg5:String):Number
        {
            var loc2:*=NaN;
            var loc4:*=arg2[arg4];
            var loc5:*=arg2[arg5];
            var loc1:*=arg3[arg4] - loc4;
            var loc3:*=arg3[arg5] - loc5;
            if (!(loc1 === 0) || !(loc3 === 0)) 
            {
                if ((loc2 = ((arg1[arg4] - loc4) * loc1 + (arg1[arg5] - loc5) * loc3) / (loc1 * loc1 + loc3 * loc3)) > 1) 
                {
                    loc4 = arg3[arg4];
                    loc5 = arg3[arg5];
                }
                else if (loc2 > 0) 
                {
                    loc4 = loc4 + loc1 * loc2;
                    loc5 = loc5 + loc3 * loc2;
                }
            }
            loc1 = arg1[arg4] - loc4;
            loc3 = arg1[arg5] - loc5;
            return loc1 * loc1 + loc3 * loc3;
        }

        public static function simplifyRadialDistance(arg1:__AS3__.vec.Vector.<Object>, arg2:Number, arg3:String, arg4:String):__AS3__.vec.Vector.<Object>
        {
            var loc3:*=0;
            var loc4:*=null;
            var loc1:*=arg1.length;
            var loc5:*=arg1[0];
            var loc2:*=null;
            loc2 = __AS3__.vec.Vector.<Object>([loc5]);
            loc3 = 1;
            while (loc3 < loc1) 
            {
                loc4 = arg1[loc3];
                if (getSquareDistance(loc4, loc5, arg3, arg4) > arg2) 
                {
                    loc2.push(loc4);
                    loc5 = loc4;
                }
                ++loc3;
            }
            if (loc5 !== loc4) 
            {
                loc2.push(loc4);
            }
            return loc2;
        }

        public static function simplifyDouglasPeucker(arg1:__AS3__.vec.Vector.<Object>, arg2:Number, arg3:String, arg4:String):__AS3__.vec.Vector.<Object>
        {
            var loc3:*=0;
            var loc7:*=NaN;
            var loc5:*=NaN;
            var loc4:*=0;
            var loc6:*=arg1.length;
            var loc10:*=null;
            loc10 = new __AS3__.vec.Vector.<int>(loc6);
            var loc11:*=0;
            var loc1:*;
            --loc1;
            var loc9:*=null;
            loc9 = new __AS3__.vec.Vector.<int>();
            var loc2:*=null;
            loc2 = new __AS3__.vec.Vector.<int>();
            var loc8:*=null;
            loc8 = new __AS3__.vec.Vector.<Object>();
            var loc12:*;
            loc10[loc1] = loc12 = 1;
            loc10[loc11] = loc12;
            while (loc1) 
            {
                loc7 = 0;
                loc3 = loc11 + 1;
                while (loc3 < loc1) 
                {
                    if ((loc5 = getSquareSegmentDistance(arg1[loc3], arg1[loc11], arg1[loc1], arg3, arg4)) > loc7) 
                    {
                        loc4 = loc3;
                        loc7 = loc5;
                    }
                    ++loc3;
                }
                if (loc7 > arg2) 
                {
                    loc10[loc4] = 1;
                    loc9.push(loc11);
                    loc2.push(loc4);
                    loc9.push(loc4);
                    loc2.push(loc1);
                }
                loc11 = loc9.pop();
                loc1 = loc2.pop();
            }
            loc3 = 0;
            while (loc3 < loc6) 
            {
                if (loc10[loc3]) 
                {
                    loc8.push(arg1[loc3]);
                }
                ++loc3;
            }
            return loc8;
        }

        public static function simplify(arg1:__AS3__.vec.Vector.<Object>, arg2:String="distanceAbsolute", arg3:String="altitude", arg4:Number=1, arg5:Boolean=false):__AS3__.vec.Vector.<Object>
        {
            var loc1:*=arg4 * arg4;
            if (!arg5) 
            {
                arg1 = simplifyRadialDistance(arg1, loc1, arg2, arg3);
            }
            arg1 = simplifyDouglasPeucker(arg1, loc1, arg2, arg3);
            return arg1;
        }
    }
}


