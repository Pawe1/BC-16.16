//package math
//  class FastCollisions
package sk.yoz.math 
{
    public class FastCollisions extends Object
    {
        public function FastCollisions()
        {
            super();
            return;
        }

        public static function rectangles(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number, arg9:Number, arg10:Number, arg11:Number, arg12:Number, arg13:Number, arg14:Number, arg15:Number, arg16:Number):Boolean
        {
            if (!isProjectedAxisCollision(arg1, arg2, arg3, arg4, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)) 
            {
                return false;
            }
            if (!isProjectedAxisCollision(arg3, arg4, arg5, arg6, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16)) 
            {
                return false;
            }
            if (!isProjectedAxisCollision(arg9, arg10, arg11, arg12, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)) 
            {
                return false;
            }
            if (!isProjectedAxisCollision(arg11, arg12, arg13, arg14, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8)) 
            {
                return false;
            }
            return true;
        }

        public static function isProjectedAxisCollision(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number, arg9:Number, arg10:Number, arg11:Number, arg12:Number):Boolean
        {
            var loc6:*=NaN;
            var loc8:*=NaN;
            var loc10:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc7:*=NaN;
            var loc9:*=NaN;
            var loc2:*=NaN;
            var loc1:*=NaN;
            var loc3:*=NaN;
            var loc11:*=NaN;
            var loc12:*=NaN;
            if (arg1 == arg3) 
            {
                loc4 = loc6 = loc8 = loc10 = arg1;
                loc2 = arg6;
                loc5 = arg8;
                loc7 = arg10;
                loc9 = arg12;
                if (arg2 > arg4) 
                {
                    if (loc2 > arg2 && loc5 > arg2 && loc7 > arg2 && loc9 > arg2 || loc2 < arg4 && loc5 < arg4 && loc7 < arg4 && loc9 < arg4) 
                    {
                        return false;
                    }
                }
                else if (loc2 > arg4 && loc5 > arg4 && loc7 > arg4 && loc9 > arg4 || loc2 < arg2 && loc5 < arg2 && loc7 < arg2 && loc9 < arg2) 
                {
                    return false;
                }
                return true;
            }
            if (arg2 != arg4) 
            {
                loc1 = (arg2 - arg4) / (arg1 - arg3);
                loc3 = 1 / loc1;
                loc11 = arg3 * loc1 - arg4;
                loc12 = 1 / (loc1 + loc3);
                loc4 = (arg6 + loc11 + arg5 * loc3) * loc12;
                loc6 = (arg8 + loc11 + arg7 * loc3) * loc12;
                loc8 = (arg10 + loc11 + arg9 * loc3) * loc12;
                loc10 = (arg12 + loc11 + arg11 * loc3) * loc12;
                loc2 = arg6 + (arg5 - loc4) * loc3;
                loc5 = arg8 + (arg7 - loc6) * loc3;
                loc7 = arg10 + (arg9 - loc8) * loc3;
                loc9 = arg12 + (arg11 - loc10) * loc3;
            }
            else 
            {
                loc4 = arg5;
                loc6 = arg7;
                loc8 = arg9;
                loc10 = arg11;
                loc2 = loc5 = loc7 = loc9 = arg2;
            }
            if (arg1 > arg3) 
            {
                if (loc4 > arg1 && loc6 > arg1 && loc8 > arg1 && loc10 > arg1 || loc4 < arg3 && loc6 < arg3 && loc8 < arg3 && loc10 < arg3) 
                {
                    return false;
                }
            }
            else if (loc4 > arg3 && loc6 > arg3 && loc8 > arg3 && loc10 > arg3 || loc4 < arg1 && loc6 < arg1 && loc8 < arg1 && loc10 < arg1) 
            {
                return false;
            }
            return true;
        }

        public static function pointInRectangle(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number, arg9:Number, arg10:Number):Boolean
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc1:*=NaN;
            if (arg3 != arg5) 
            {
                if (arg4 != arg6) 
                {
                    loc1 = (arg4 - arg6) / (arg3 - arg5);
                    loc2 = (arg2 - arg6 + arg5 * loc1 + arg1 / loc1) / (loc1 + 1 / loc1);
                    loc3 = arg2 + (arg1 - loc2) / loc1;
                }
                else 
                {
                    loc2 = arg1;
                    loc3 = arg4;
                }
            }
            else 
            {
                loc2 = arg3;
                loc3 = arg2;
                if (loc3 > (arg4 > arg6 ? arg4 : arg6)) 
                {
                    return false;
                }
                if (loc3 < (arg4 < arg6 ? arg4 : arg6)) 
                {
                    return false;
                }
            }
            if (loc2 > (arg3 > arg5 ? arg3 : arg5)) 
            {
                return false;
            }
            if (loc2 < (arg3 < arg5 ? arg3 : arg5)) 
            {
                return false;
            }
            if (arg5 != arg7) 
            {
                if (arg6 != arg8) 
                {
                    loc1 = (arg6 - arg8) / (arg5 - arg7);
                    loc2 = (arg2 - arg8 + arg7 * loc1 + arg1 / loc1) / (loc1 + 1 / loc1);
                    loc3 = arg2 + (arg1 - loc2) / loc1;
                }
                else 
                {
                    loc2 = arg1;
                    loc3 = arg6;
                }
            }
            else 
            {
                loc2 = arg5;
                loc3 = arg2;
                if (loc3 > (arg6 > arg8 ? arg6 : arg8)) 
                {
                    return false;
                }
                if (loc3 < (arg6 < arg8 ? arg6 : arg8)) 
                {
                    return false;
                }
            }
            if (loc2 > (arg5 > arg7 ? arg5 : arg7)) 
            {
                return false;
            }
            if (loc2 < (arg5 < arg7 ? arg5 : arg7)) 
            {
                return false;
            }
            return true;
        }

        public static function pointInTriangle(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number, arg7:Number, arg8:Number):Boolean
        {
            var loc2:*=arg1 - arg3;
            var loc3:*=arg2 - arg4;
            var loc1:*=(arg5 - arg3) * loc3 - (arg6 - arg4) * loc2 > 0;
            if ((arg7 - arg3) * loc3 - (arg8 - arg4) * loc2 > 0 == loc1) 
            {
                return false;
            }
            if ((arg7 - arg5) * (arg2 - arg6) - (arg8 - arg6) * (arg1 - arg5) > 0 != loc1) 
            {
                return false;
            }
            return true;
        }
    }
}


//  class GeometryMath
package sk.yoz.math 
{
    import flash.geom.*;
    
    public class GeometryMath extends Object
    {
        public function GeometryMath()
        {
            super();
            return;
        }

        public static function degreesToRadians(arg1:Number):Number
        {
            return arg1 * 0.0174532925199;
        }

        public static function radiansToDegrees(arg1:Number):Number
        {
            return arg1 * 57.2957795131;
        }

        public static function isLine(arg1:flash.geom.Point, arg2:flash.geom.Point, arg3:flash.geom.Point, arg4:Boolean=true):Boolean
        {
            var loc2:*=arg1.x - arg2.x;
            var loc4:*=arg2.x - arg3.x;
            var loc1:*=arg1.y - arg2.y;
            var loc3:*=arg2.y - arg3.y;
            if (arg4 && (loc2 > 0 && loc4 < 0 || loc2 < 0 && loc4 > 0 || loc1 < 0 && loc3 > 0 || loc1 < 0 && loc3 > 0)) 
            {
                return false;
            }
            if (!loc3) 
            {
                return !loc1;
            }
            if (!loc4) 
            {
                return !loc2;
            }
            return loc2 / loc4 == loc1 / loc3;
        }

        public static function rotatePoint(arg1:flash.geom.Point, arg2:flash.geom.Point, arg3:Number):flash.geom.Point
        {
            return rotatePointByRadians(arg1, arg2, arg3 * 0.0174532925199);
        }

        public static function rotatePointByRadians(arg1:flash.geom.Point, arg2:flash.geom.Point, arg3:Number):flash.geom.Point
        {
            var loc1:*=arg1.x - arg2.x;
            var loc4:*=arg1.y - arg2.y;
            var loc2:*=Math.sqrt(loc1 * loc1 + loc4 * loc4);
            var loc3:*=arg3 + Math.atan2(loc1, -loc4);
            return new flash.geom.Point(Math.sin(loc3) * loc2 + arg2.x, (-Math.cos(loc3)) * loc2 + arg2.y);
        }

        public static function angleOf3Points(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number, arg6:Number):Number
        {
            var loc1:*=Math.sqrt((arg1 - arg3) * (arg1 - arg3) + (arg2 - arg4) * (arg2 - arg4));
            var loc2:*=Math.sqrt((arg3 - arg5) * (arg3 - arg5) + (arg4 - arg6) * (arg4 - arg6));
            var loc3:*=Math.sqrt((arg5 - arg1) * (arg5 - arg1) + (arg6 - arg2) * (arg6 - arg2));
            return Math.acos((loc1 * loc1 + loc3 * loc3 - loc2 * loc2) / (2 * loc1 * loc3));
        }

        public static const TO_RADIANS:Number=0.0174532925199;

        public static const TO_DEGREEES:Number=57.2957795131;
    }
}


