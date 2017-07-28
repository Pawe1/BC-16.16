//class BitmapFontTextFormat
package feathers.text 
{
    import starling.text.*;
    
    public class BitmapFontTextFormat extends Object
    {
        public function BitmapFontTextFormat(arg1:Object, arg2:Number=NaN, arg3:uint=16777215, arg4:String="left", arg5:Number=0)
        {
            super();
            if (arg1 is String) 
            {
                arg1 = starling.text.TextField.getBitmapFont(arg1 as String);
            }
            if (!(arg1 is starling.text.BitmapFont)) 
            {
                throw new ArgumentError("BitmapFontTextFormat font must be a BitmapFont instance or a String representing the name of a registered bitmap font.");
            }
            this.font = starling.text.BitmapFont(arg1);
            this.size = arg2;
            this.color = arg3;
            this.align = arg4;
            this.leading = arg5;
            return;
        }

        public function get fontName():String
        {
            return this.font ? this.font.name : null;
        }

        public var font:starling.text.BitmapFont;

        public var color:uint;

        public var size:Number;

        public var letterSpacing:Number=0;

        public var align:String="left";

        public var leading:Number;

        public var isKerningEnabled:Boolean=true;
    }
}


