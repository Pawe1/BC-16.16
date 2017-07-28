//class CaloriesFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class CaloriesFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatterBase
    {
        public function CaloriesFormatter()
        {
            this.rounding = frontend.formatter.NumberBaseRoundType.NEAREST;
            super();
            return;
        }

        public override function format(arg1:Object):String
        {
            if (arg1 == null) 
            {
                return "0";
            }
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
            this.groupingSeparator = String.fromCharCode(8201);
            this.groupingPattern = "3";
            this.fractionalDigits = 0;
            var loc2:*=super.format(loc1);
            return loc2;
        }

        public var rounding:String;
    }
}


