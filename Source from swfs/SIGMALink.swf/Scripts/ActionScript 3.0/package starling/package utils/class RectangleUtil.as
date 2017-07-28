//class RectangleUtil
package starling.utils 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.errors.*;
    
    public class RectangleUtil extends Object
    {
        public function RectangleUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function intersect(arg1:flash.geom.Rectangle, arg2:flash.geom.Rectangle, arg3:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Rectangle();
            }
            var loc1:*=arg1.x > arg2.x ? arg1.x : arg2.x;
            var loc2:*=arg1.right < arg2.right ? arg1.right : arg2.right;
            var loc3:*=arg1.y > arg2.y ? arg1.y : arg2.y;
            var loc4:*=arg1.bottom < arg2.bottom ? arg1.bottom : arg2.bottom;
            if (loc1 > loc2 || loc3 > loc4) 
            {
                arg3.setEmpty();
            }
            else 
            {
                arg3.setTo(loc1, loc3, loc2 - loc1, loc4 - loc3);
            }
            return arg3;
        }

        public static function fit(arg1:flash.geom.Rectangle, arg2:flash.geom.Rectangle, arg3:String="showAll", arg4:Boolean=false, arg5:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (!starling.utils.ScaleMode.isValid(arg3)) 
            {
                throw new ArgumentError("Invalid scaleMode: " + arg3);
            }
            if (arg5 == null) 
            {
                arg5 = new flash.geom.Rectangle();
            }
            var loc1:*=arg1.width;
            var loc2:*=arg1.height;
            var loc3:*=arg2.width / loc1;
            var loc4:*=arg2.height / loc2;
            var loc5:*=1;
            if (arg3 != starling.utils.ScaleMode.SHOW_ALL) 
            {
                if (arg3 == starling.utils.ScaleMode.NO_BORDER) 
                {
                    loc5 = loc3 > loc4 ? loc3 : loc4;
                    if (arg4) 
                    {
                        loc5 = nextSuitableScaleFactor(loc5, true);
                    }
                }
            }
            else 
            {
                loc5 = loc3 < loc4 ? loc3 : loc4;
                if (arg4) 
                {
                    loc5 = nextSuitableScaleFactor(loc5, false);
                }
            }
            loc1 = loc1 * loc5;
            loc2 = loc2 * loc5;
            arg5.setTo(arg2.x + (arg2.width - loc1) / 2, arg2.y + (arg2.height - loc2) / 2, loc1, loc2);
            return arg5;
        }

        internal static function nextSuitableScaleFactor(arg1:Number, arg2:Boolean):Number
        {
            var loc1:*=1;
            if (arg2) 
            {
                if (arg1 >= 0.5) 
                {
                    return Math.ceil(arg1);
                }
                while (1 / (loc1 + 1) > arg1) 
                {
                    ++loc1;
                }
            }
            else 
            {
                if (arg1 >= 1) 
                {
                    return Math.floor(arg1);
                }
                while (1 / loc1 > arg1) 
                {
                    ++loc1;
                }
            }
            return 1 / loc1;
        }

        public static function normalize(arg1:flash.geom.Rectangle):void
        {
            if (arg1.width < 0) 
            {
                arg1.width = -arg1.width;
                arg1.x = arg1.x - arg1.width;
            }
            if (arg1.height < 0) 
            {
                arg1.height = -arg1.height;
                arg1.y = arg1.y - arg1.height;
            }
            return;
        }

        public static function extend(arg1:flash.geom.Rectangle, arg2:Number=0, arg3:Number=0, arg4:Number=0, arg5:Number=0):void
        {
            arg1.x = arg1.x - arg2;
            arg1.y = arg1.y - arg4;
            arg1.width = arg1.width + (arg2 + arg3);
            arg1.height = arg1.height + (arg4 + arg5);
            return;
        }

        public static function getBounds(arg1:flash.geom.Rectangle, arg2:flash.geom.Matrix, arg3:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            if (arg3 == null) 
            {
                arg3 = new flash.geom.Rectangle();
            }
            var loc1:*=Number.MAX_VALUE;
            var loc2:*=-Number.MAX_VALUE;
            var loc3:*=Number.MAX_VALUE;
            var loc4:*=-Number.MAX_VALUE;
            var loc5:*=getPositions(arg1, sPositions);
            var loc6:*=0;
            while (loc6 < 4) 
            {
                starling.utils.MatrixUtil.transformCoords(arg2, loc5[loc6].x, loc5[loc6].y, sPoint);
                if (loc1 > sPoint.x) 
                {
                    loc1 = sPoint.x;
                }
                if (loc2 < sPoint.x) 
                {
                    loc2 = sPoint.x;
                }
                if (loc3 > sPoint.y) 
                {
                    loc3 = sPoint.y;
                }
                if (loc4 < sPoint.y) 
                {
                    loc4 = sPoint.y;
                }
                ++loc6;
            }
            arg3.setTo(loc1, loc3, loc2 - loc1, loc4 - loc3);
            return arg3;
        }

        public static function getBoundsProjected(arg1:flash.geom.Rectangle, arg2:flash.geom.Matrix3D, arg3:flash.geom.Vector3D, arg4:flash.geom.Rectangle=null):flash.geom.Rectangle
        {
            var loc7:*=null;
            if (arg4 == null) 
            {
                arg4 = new flash.geom.Rectangle();
            }
            if (arg3 == null) 
            {
                throw new ArgumentError("camPos must not be null");
            }
            var loc1:*=Number.MAX_VALUE;
            var loc2:*=-Number.MAX_VALUE;
            var loc3:*=Number.MAX_VALUE;
            var loc4:*=-Number.MAX_VALUE;
            var loc5:*=getPositions(arg1, sPositions);
            var loc6:*=0;
            while (loc6 < 4) 
            {
                loc7 = loc5[loc6];
                if (arg2) 
                {
                    starling.utils.MatrixUtil.transformCoords3D(arg2, loc7.x, loc7.y, 0, sPoint3D);
                }
                else 
                {
                    sPoint3D.setTo(loc7.x, loc7.y, 0);
                }
                starling.utils.MathUtil.intersectLineWithXYPlane(arg3, sPoint3D, sPoint);
                if (loc1 > sPoint.x) 
                {
                    loc1 = sPoint.x;
                }
                if (loc2 < sPoint.x) 
                {
                    loc2 = sPoint.x;
                }
                if (loc3 > sPoint.y) 
                {
                    loc3 = sPoint.y;
                }
                if (loc4 < sPoint.y) 
                {
                    loc4 = sPoint.y;
                }
                ++loc6;
            }
            arg4.setTo(loc1, loc3, loc2 - loc1, loc4 - loc3);
            return arg4;
        }

        public static function getPositions(arg1:flash.geom.Rectangle, arg2:__AS3__.vec.Vector.<flash.geom.Point>=null):__AS3__.vec.Vector.<flash.geom.Point>
        {
            if (arg2 == null) 
            {
                arg2 = new Vector.<flash.geom.Point>(4, true);
            }
            var loc1:*=0;
            while (loc1 < 4) 
            {
                if (arg2[loc1] == null) 
                {
                    arg2[loc1] = new flash.geom.Point();
                }
                ++loc1;
            }
            arg2[0].x = arg1.left;
            arg2[0].y = arg1.top;
            arg2[1].x = arg1.right;
            arg2[1].y = arg1.top;
            arg2[2].x = arg1.left;
            arg2[2].y = arg1.bottom;
            arg2[3].x = arg1.right;
            arg2[3].y = arg1.bottom;
            return arg2;
        }

        public static function compare(arg1:flash.geom.Rectangle, arg2:flash.geom.Rectangle, arg3:Number=0.0001):Boolean
        {
            if (arg1 == null) 
            {
                return arg2 == null;
            }
            if (arg2 == null) 
            {
                return false;
            }
            return arg1.x > arg2.x - arg3 && arg1.x < arg2.x + arg3 && arg1.y > arg2.y - arg3 && arg1.y < arg2.y + arg3 && arg1.width > arg2.width - arg3 && arg1.width < arg2.width + arg3 && arg1.height > arg2.height - arg3 && arg1.height < arg2.height + arg3;
        }

        
        {
            new Vector.<flash.geom.Point>(4)[0] = new flash.geom.Point();
            new Vector.<flash.geom.Point>(4)[1] = new flash.geom.Point();
            new Vector.<flash.geom.Point>(4)[2] = new flash.geom.Point();
            new Vector.<flash.geom.Point>(4)[3] = new flash.geom.Point();
        }

        internal static const sPoint:flash.geom.Point=new flash.geom.Point();

        internal static const sPoint3D:flash.geom.Vector3D=new flash.geom.Vector3D();

        internal static const sPositions:__AS3__.vec.Vector.<flash.geom.Point>=new Vector.<flash.geom.Point>(4);
    }
}


