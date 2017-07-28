//class TransformationUtils
package sk.yoz.ycanvas.utils 
{
    import flash.geom.*;
    import sk.yoz.math.*;
    import sk.yoz.ycanvas.*;
    
    public class TransformationUtils extends Object
    {
        public function TransformationUtils()
        {
            super();
            return;
        }

        public static function moveTo(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:flash.geom.Point):void
        {
            arg1.center = arg2;
            return;
        }

        public static function scaleTo(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:Number, arg3:flash.geom.Point=null):void
        {
            if (!arg3) 
            {
                arg3 = arg1.center;
            }
            var loc1:*=1 - arg1.scale / arg2;
            arg1.center = new flash.geom.Point(arg1.center.x + (arg3.x - arg1.center.x) * loc1, arg1.center.y + (arg3.y - arg1.center.y) * loc1);
            arg1.scale = arg2;
            return;
        }

        public static function rotateTo(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:Number, arg3:flash.geom.Point=null):void
        {
            if (!arg3) 
            {
                arg3 = arg1.center;
            }
            var loc1:*=arg1.rotation - arg2;
            arg1.center = sk.yoz.math.GeometryMath.rotatePointByRadians(arg1.center, arg3, loc1);
            arg1.rotation = arg2;
            return;
        }

        public static function moveRotateTo(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:flash.geom.Point, arg3:Number):void
        {
            arg1.center = arg2;
            arg1.rotation = arg3;
            return;
        }

        public static function rotateScaleTo(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:Number, arg3:Number, arg4:flash.geom.Point=null):void
        {
            if (!arg4) 
            {
                arg4 = arg1.center;
            }
            var loc3:*=arg1.rotation - arg2;
            var loc2:*=sk.yoz.math.GeometryMath.rotatePointByRadians(arg1.center, arg4, loc3);
            var loc1:*=1 - arg1.scale / arg3;
            loc2.x = loc2.x + (arg4.x - loc2.x) * loc1;
            loc2.y = loc2.y + (arg4.y - loc2.y) * loc1;
            arg1.center = loc2;
            arg1.rotation = arg2;
            arg1.scale = arg3;
            return;
        }
    }
}


