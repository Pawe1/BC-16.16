//class Image_helper
package helper 
{
    import flash.display.*;
    import flash.geom.*;
    import flash.utils.*;
    
    public final class Image_helper extends Object
    {
        public function Image_helper()
        {
            super();
            return;
        }

        public static function jpeg(arg1:flash.display.BitmapData):flash.utils.ByteArray
        {
            var loc2:*=null;
            var loc1:*=flash.utils.getTimer();
            loc2 = arg1.encode(new flash.geom.Rectangle(0, 0, arg1.width, arg1.height), new flash.display.JPEGEncoderOptions(80), loc2);
            return loc2;
        }

        public static function png(arg1:flash.display.BitmapData):flash.utils.ByteArray
        {
            var loc2:*=null;
            var loc1:*=flash.utils.getTimer();
            loc2 = arg1.encode(new flash.geom.Rectangle(0, 0, arg1.width, arg1.height), new flash.display.PNGEncoderOptions(true), loc2);
            return loc2;
        }

        internal static const DEFAULT_QUALITY:uint=80;
    }
}


