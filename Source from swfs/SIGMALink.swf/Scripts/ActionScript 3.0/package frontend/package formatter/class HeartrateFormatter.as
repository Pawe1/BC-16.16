//class HeartrateFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class HeartrateFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatterBase
    {
        public function HeartrateFormatter()
        {
            this.rounding = frontend.formatter.NumberBaseRoundType.NEAREST;
            super();
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc2:*=null;
            var loc1:*=parseInt(arg1.toString());
            if (isNaN(loc1)) 
            {
                return "0";
            }
            var loc3:*=this.rounding;
            switch (loc3) 
            {
                case frontend.formatter.NumberBaseRoundType.DOWN:
                {
                    loc1 = Math.floor(loc1);
                    break;
                }
                case frontend.formatter.NumberBaseRoundType.UP:
                {
                    loc1 = Math.ceil(loc1);
                    break;
                }
                case frontend.formatter.NumberBaseRoundType.NEAREST:
                {
                    loc1 = Math.round(loc1);
                    break;
                }
            }
            this.useGrouping = true;
            this.groupingSeparator = SEPERATOR;
            this.groupingPattern = "3";
            this.fractionalDigits = 0;
            loc2 = super.format(loc1);
            return loc2;
        }

        public static const SEPERATOR:String=String.fromCharCode(8201);

        public var rounding:String;
    }
}


