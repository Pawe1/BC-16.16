//class MatrixUtil
package starling.utils 
{
    import __AS3__.vec.*;
    import flash.geom.*;
    import starling.errors.*;
    
    public class MatrixUtil extends Object
    {
        public function MatrixUtil()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function convertTo3D(arg1:flash.geom.Matrix, arg2:flash.geom.Matrix3D=null):flash.geom.Matrix3D
        {
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Matrix3D();
            }
            sRawData[0] = arg1.a;
            sRawData[1] = arg1.b;
            sRawData[4] = arg1.c;
            sRawData[5] = arg1.d;
            sRawData[12] = arg1.tx;
            sRawData[13] = arg1.ty;
            arg2.copyRawDataFrom(sRawData);
            return arg2;
        }

        public static function convertTo2D(arg1:flash.geom.Matrix3D, arg2:flash.geom.Matrix=null):flash.geom.Matrix
        {
            if (arg2 == null) 
            {
                arg2 = new flash.geom.Matrix();
            }
            arg1.copyRawDataTo(sRawData2);
            arg2.a = sRawData2[0];
            arg2.b = sRawData2[1];
            arg2.c = sRawData2[4];
            arg2.d = sRawData2[5];
            arg2.tx = sRawData2[12];
            arg2.ty = sRawData2[13];
            return arg2;
        }

        public static function isIdentity(arg1:flash.geom.Matrix):Boolean
        {
            return arg1.a == 1 && arg1.b == 0 && arg1.c == 0 && arg1.d == 1 && arg1.tx == 0 && arg1.ty == 0;
        }

        public static function isIdentity3D(arg1:flash.geom.Matrix3D):Boolean
        {
            var loc1:*=sRawData2;
            arg1.copyRawDataTo(loc1);
            return loc1[0] == 1 && loc1[1] == 0 && loc1[2] == 0 && loc1[3] == 0 && loc1[4] == 0 && loc1[5] == 1 && loc1[6] == 0 && loc1[7] == 0 && loc1[8] == 0 && loc1[9] == 0 && loc1[10] == 1 && loc1[11] == 0 && loc1[12] == 0 && loc1[13] == 0 && loc1[14] == 0 && loc1[15] == 1;
        }

        public static function transformPoint(arg1:flash.geom.Matrix, arg2:flash.geom.Point, arg3:flash.geom.Point=null):flash.geom.Point
        {
            return transformCoords(arg1, arg2.x, arg2.y, arg3);
        }

        public static function transformPoint3D(arg1:flash.geom.Matrix3D, arg2:flash.geom.Vector3D, arg3:flash.geom.Vector3D=null):flash.geom.Vector3D
        {
            return transformCoords3D(arg1, arg2.x, arg2.y, arg2.z, arg3);
        }

        public static function transformCoords(arg1:flash.geom.Matrix, arg2:Number, arg3:Number, arg4:flash.geom.Point=null):flash.geom.Point
        {
            if (arg4 == null) 
            {
                arg4 = new flash.geom.Point();
            }
            arg4.x = arg1.a * arg2 + arg1.c * arg3 + arg1.tx;
            arg4.y = arg1.d * arg3 + arg1.b * arg2 + arg1.ty;
            return arg4;
        }

        public static function transformCoords3D(arg1:flash.geom.Matrix3D, arg2:Number, arg3:Number, arg4:Number, arg5:flash.geom.Vector3D=null):flash.geom.Vector3D
        {
            if (arg5 == null) 
            {
                arg5 = new flash.geom.Vector3D();
            }
            arg1.copyRawDataTo(sRawData2);
            arg5.x = arg2 * sRawData2[0] + arg3 * sRawData2[4] + arg4 * sRawData2[8] + sRawData2[12];
            arg5.y = arg2 * sRawData2[1] + arg3 * sRawData2[5] + arg4 * sRawData2[9] + sRawData2[13];
            arg5.z = arg2 * sRawData2[2] + arg3 * sRawData2[6] + arg4 * sRawData2[10] + sRawData2[14];
            arg5.w = arg2 * sRawData2[3] + arg3 * sRawData2[7] + arg4 * sRawData2[11] + sRawData2[15];
            return arg5;
        }

        public static function skew(arg1:flash.geom.Matrix, arg2:Number, arg3:Number):void
        {
            var loc1:*=Math.sin(arg2);
            var loc2:*=Math.cos(arg2);
            var loc3:*=Math.sin(arg3);
            var loc4:*=Math.cos(arg3);
            arg1.setTo(arg1.a * loc4 - arg1.b * loc1, arg1.a * loc3 + arg1.b * loc2, arg1.c * loc4 - arg1.d * loc1, arg1.c * loc3 + arg1.d * loc2, arg1.tx * loc4 - arg1.ty * loc1, arg1.tx * loc3 + arg1.ty * loc2);
            return;
        }

        public static function prependMatrix(arg1:flash.geom.Matrix, arg2:flash.geom.Matrix):void
        {
            arg1.setTo(arg1.a * arg2.a + arg1.c * arg2.b, arg1.b * arg2.a + arg1.d * arg2.b, arg1.a * arg2.c + arg1.c * arg2.d, arg1.b * arg2.c + arg1.d * arg2.d, arg1.tx + arg1.a * arg2.tx + arg1.c * arg2.ty, arg1.ty + arg1.b * arg2.tx + arg1.d * arg2.ty);
            return;
        }

        public static function prependTranslation(arg1:flash.geom.Matrix, arg2:Number, arg3:Number):void
        {
            arg1.tx = arg1.tx + (arg1.a * arg2 + arg1.c * arg3);
            arg1.ty = arg1.ty + (arg1.b * arg2 + arg1.d * arg3);
            return;
        }

        public static function prependScale(arg1:flash.geom.Matrix, arg2:Number, arg3:Number):void
        {
            arg1.setTo(arg1.a * arg2, arg1.b * arg2, arg1.c * arg3, arg1.d * arg3, arg1.tx, arg1.ty);
            return;
        }

        public static function prependRotation(arg1:flash.geom.Matrix, arg2:Number):void
        {
            var loc1:*=Math.sin(arg2);
            var loc2:*=Math.cos(arg2);
            arg1.setTo(arg1.a * loc2 + arg1.c * loc1, arg1.b * loc2 + arg1.d * loc1, arg1.c * loc2 - arg1.a * loc1, arg1.d * loc2 - arg1.b * loc1, arg1.tx, arg1.ty);
            return;
        }

        public static function prependSkew(arg1:flash.geom.Matrix, arg2:Number, arg3:Number):void
        {
            var loc1:*=Math.sin(arg2);
            var loc2:*=Math.cos(arg2);
            var loc3:*=Math.sin(arg3);
            var loc4:*=Math.cos(arg3);
            arg1.setTo(arg1.a * loc4 + arg1.c * loc3, arg1.b * loc4 + arg1.d * loc3, arg1.c * loc2 - arg1.a * loc1, arg1.d * loc2 - arg1.b * loc1, arg1.tx, arg1.ty);
            return;
        }

        public static function toString3D(arg1:flash.geom.Matrix3D, arg2:Boolean=true, arg3:int=3):String
        {
            if (arg2) 
            {
                arg1.transpose();
            }
            arg1.copyRawDataTo(sRawData2);
            if (arg2) 
            {
                arg1.transpose();
            }
            return "[Matrix3D rawData=\n" + formatRawData(sRawData2, 4, 4, arg3) + "\n]";
        }

        public static function toString(arg1:flash.geom.Matrix, arg2:int=3):String
        {
            sRawData2[0] = arg1.a;
            sRawData2[1] = arg1.c;
            sRawData2[2] = arg1.tx;
            sRawData2[3] = arg1.b;
            sRawData2[4] = arg1.d;
            sRawData2[5] = arg1.ty;
            return "[Matrix rawData=\n" + formatRawData(sRawData2, 3, 2, arg2) + "\n]";
        }

        internal static function formatRawData(arg1:__AS3__.vec.Vector.<Number>, arg2:int, arg3:int, arg4:int, arg5:String="  "):String
        {
            var loc4:*=null;
            var loc5:*=NaN;
            var loc9:*=0;
            var loc1:*=arg5;
            var loc2:*=arg2 * arg3;
            var loc3:*=0;
            var loc6:*=0;
            while (loc6 < loc2) 
            {
                loc5 = Math.abs(arg1[loc6]);
                if (loc5 > loc3) 
                {
                    loc3 = loc5;
                }
                ++loc6;
            }
            var loc7:*=loc3.toFixed(arg4).length + 1;
            var loc8:*=0;
            while (loc8 < arg3) 
            {
                loc9 = 0;
                while (loc9 < arg2) 
                {
                    loc5 = arg1[arg2 * loc8 + loc9];
                    loc4 = loc5.toFixed(arg4);
                    while (loc4.length < loc7) 
                    {
                        loc4 = " " + loc4;
                    }
                    loc1 = loc1 + loc4;
                    if (loc9 != (arg2 - 1)) 
                    {
                        loc1 = loc1 + ", ";
                    }
                    ++loc9;
                }
                if (loc8 != (arg3 - 1)) 
                {
                    loc1 = loc1 + ("\n" + arg5);
                }
                ++loc8;
            }
            return loc1;
        }

        public static function snapToPixels(arg1:flash.geom.Matrix, arg2:Number):void
        {
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc1:*=0.0001;
            var loc2:*=false;
            if (arg1.b + loc1 > 0 && arg1.b - loc1 < 0 && arg1.c + loc1 > 0 && arg1.c - loc1 < 0) 
            {
                loc3 = arg1.a * arg1.a;
                loc6 = arg1.d * arg1.d;
                loc2 = loc3 + loc1 > 1 && loc3 - loc1 < 1 && loc6 + loc1 > 1 && loc6 - loc1 < 1;
            }
            else if (arg1.a + loc1 > 0 && arg1.a - loc1 < 0 && arg1.d + loc1 > 0 && arg1.d - loc1 < 0) 
            {
                loc4 = arg1.b * arg1.b;
                loc5 = arg1.c * arg1.c;
                loc2 = loc4 + loc1 > 1 && loc4 - loc1 < 1 && loc5 + loc1 > 1 && loc5 - loc1 < 1;
            }
            if (loc2) 
            {
                arg1.tx = Math.round(arg1.tx / arg2) * arg2;
                arg1.ty = Math.round(arg1.ty / arg2) * arg2;
            }
            return;
        }

        public static function createPerspectiveProjectionMatrix(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:Number=0, arg6:Number=0, arg7:flash.geom.Vector3D=null, arg8:flash.geom.Matrix3D=null):flash.geom.Matrix3D
        {
            var loc1:*=NaN;
            if (arg8 == null) 
            {
                arg8 = new flash.geom.Matrix3D();
            }
            if (arg5 <= 0) 
            {
                arg5 = arg3;
            }
            if (arg6 <= 0) 
            {
                arg6 = arg4;
            }
            if (arg7 == null) 
            {
                arg7 = sPoint3D;
                arg7.setTo(arg5 / 2, arg6 / 2, arg5 / Math.tan(0.5) * 0.5);
            }
            loc1 = Math.abs(arg7.z);
            var loc2:*=arg7.x - arg5 / 2;
            var loc3:*=arg7.y - arg6 / 2;
            var loc4:*=loc1 * 20;
            var loc5:*=1;
            var loc6:*=arg5 / arg3;
            var loc7:*=arg6 / arg4;
            sMatrixData[0] = 2 * loc1 / arg5;
            sMatrixData[5] = -2 * loc1 / arg6;
            sMatrixData[10] = loc4 / (loc4 - loc5);
            sMatrixData[14] = (-loc4) * loc5 / (loc4 - loc5);
            sMatrixData[11] = 1;
            sMatrixData[0] = sMatrixData[0] * loc6;
            sMatrixData[5] = sMatrixData[5] * loc7;
            sMatrixData[8] = (loc6 - 1) - 2 * loc6 * (arg1 - loc2) / arg5;
            sMatrixData[9] = -loc7 + 1 + 2 * loc7 * (arg2 - loc3) / arg6;
            arg8.copyRawDataFrom(sMatrixData);
            arg8.prependTranslation((-arg5) / 2 - loc2, (-arg6) / 2 - loc3, loc1);
            return arg8;
        }

        public static function createOrthographicProjectionMatrix(arg1:Number, arg2:Number, arg3:Number, arg4:Number, arg5:flash.geom.Matrix=null):flash.geom.Matrix
        {
            if (arg5 == null) 
            {
                arg5 = new flash.geom.Matrix();
            }
            arg5.setTo(2 / arg3, 0, 0, -2 / arg4, (-(2 * arg1 + arg3)) / arg3, (2 * arg2 + arg4) / arg4);
            return arg5;
        }

        
        {
            new Vector.<Number>(16)[0] = 1;
            new Vector.<Number>(16)[1] = 0;
            new Vector.<Number>(16)[2] = 0;
            new Vector.<Number>(16)[3] = 0;
            new Vector.<Number>(16)[4] = 0;
            new Vector.<Number>(16)[5] = 1;
            new Vector.<Number>(16)[6] = 0;
            new Vector.<Number>(16)[7] = 0;
            new Vector.<Number>(16)[8] = 0;
            new Vector.<Number>(16)[9] = 0;
            new Vector.<Number>(16)[10] = 1;
            new Vector.<Number>(16)[11] = 0;
            new Vector.<Number>(16)[12] = 0;
            new Vector.<Number>(16)[13] = 0;
            new Vector.<Number>(16)[14] = 0;
            new Vector.<Number>(16)[15] = 1;
            sRawData = new Vector.<Number>(16);
            sRawData2 = new Vector.<Number>(16, true);
            sPoint3D = new flash.geom.Vector3D();
            new Vector.<Number>(16)[0] = 0;
            new Vector.<Number>(16)[1] = 0;
            new Vector.<Number>(16)[2] = 0;
            new Vector.<Number>(16)[3] = 0;
            new Vector.<Number>(16)[4] = 0;
            new Vector.<Number>(16)[5] = 0;
            new Vector.<Number>(16)[6] = 0;
            new Vector.<Number>(16)[7] = 0;
            new Vector.<Number>(16)[8] = 0;
            new Vector.<Number>(16)[9] = 0;
            new Vector.<Number>(16)[10] = 0;
            new Vector.<Number>(16)[11] = 0;
            new Vector.<Number>(16)[12] = 0;
            new Vector.<Number>(16)[13] = 0;
            new Vector.<Number>(16)[14] = 0;
            new Vector.<Number>(16)[15] = 0;
            sMatrixData = new Vector.<Number>(16);
        }

        internal static var sRawData:__AS3__.vec.Vector.<Number>;

        internal static var sRawData2:__AS3__.vec.Vector.<Number>;

        internal static var sPoint3D:flash.geom.Vector3D;

        internal static var sMatrixData:__AS3__.vec.Vector.<Number>;
    }
}


