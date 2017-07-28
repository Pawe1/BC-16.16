//class FlexBitmap
package mx.core 
{
    import flash.display.*;
    import mx.utils.*;
    
    use namespace mx_internal;
    
    public class FlexBitmap extends flash.display.Bitmap
    {
        public function FlexBitmap(arg1:flash.display.BitmapData=null, arg2:String="auto", arg3:Boolean=false)
        {
            super(arg1, arg2, arg3);
            try 
            {
                name = mx.utils.NameUtil.createUniqueName(this);
            }
            catch (e:Error)
            {
            };
            return;
        }

        public override function toString():String
        {
            return mx.utils.NameUtil.displayObjectToString(this);
        }

        
        {
            mx_internal::VERSION = "4.14.0.0";
        }

        mx_internal static const VERSION:String="4.14.0.0";
    }
}


