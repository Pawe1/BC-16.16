//class ILayerUtils
package sk.yoz.ycanvas.utils 
{
    import __AS3__.vec.*;
    import sk.yoz.ycanvas.*;
    
    public class ILayerUtils extends Object
    {
        public function ILayerUtils()
        {
            super();
            return;
        }

        public static function disposeDeep(arg1:sk.yoz.ycanvas.AbstractYCanvas, arg2:uint=1):void
        {
            var loc3:*=0;
            var loc1:*=arg1.layers.concat();
            var loc2:*=Math.max(loc1.length - arg2, 0);
            loc3 = 0;
            while (loc3 < loc2) 
            {
                arg1.disposeLayer(loc1[loc3]);
                ++loc3;
            }
            return;
        }

        public static function disposeEmpty(arg1:sk.yoz.ycanvas.AbstractYCanvas):void
        {
            var loc3:*=0;
            var loc2:*=0;
            var loc1:*=arg1.layers.concat();
            loc3 = 0;
            loc2 = loc1.length;
            while (loc3 < loc2) 
            {
                if (!loc1[loc3].partitions.length) 
                {
                    arg1.disposeLayer(loc1[loc3]);
                }
                ++loc3;
            }
            return;
        }
    }
}


