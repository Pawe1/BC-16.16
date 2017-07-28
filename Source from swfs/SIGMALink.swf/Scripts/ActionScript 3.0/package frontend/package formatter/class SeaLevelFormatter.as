//class SeaLevelFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class SeaLevelFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatterBase
    {
        public function SeaLevelFormatter()
        {
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
                this.useGrouping = true;
                this.groupingSeparator = String.fromCharCode(8201);
                this.groupingPattern = "3";
                this.fractionalDigits = 1;
                loc1 = super.format(arg1);
                if (decimalSeparator != ".") 
                {
                    loc1 = loc1.replace(".", decimalSeparator);
                }
                return loc1;
            }
            return null;
        }
    }
}


