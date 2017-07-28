//class PowerPerKGFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class PowerPerKGFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatterBase
    {
        public function PowerPerKGFormatter()
        {
            this.rounding = frontend.formatter.NumberBaseRoundType.NEAREST;
            super();
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc1:*=null;
            if (arg1 is String) 
            {
                arg1 = parseFloat(arg1 as String);
            }
            if (arg1 is Number) 
            {
                if (isNaN(arg1 as Number)) 
                {
                    arg1 = 0;
                }
                useGrouping = true;
                groupingSeparator = String.fromCharCode(8201);
                groupingPattern = "3";
                fractionalDigits = 1;
                loc1 = super.format(arg1);
                return loc1;
            }
            return null;
        }

        public var rounding:String;
    }
}


