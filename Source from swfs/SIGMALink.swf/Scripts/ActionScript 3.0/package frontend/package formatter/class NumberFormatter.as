//class NumberFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class NumberFormatter extends Object implements utils.interfaces.ICustomFormatterBase
    {
        public function NumberFormatter()
        {
            super();
            return;
        }

        public function format(arg1:Object):String
        {
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=null;
            var loc5:*=null;
            if (arg1 == null) 
            {
                return null;
            }
            var loc1:*=Number(arg1);
            if (this.fractionalDigits > -1) 
            {
                loc2 = loc1.toFixed(this.fractionalDigits);
            }
            else 
            {
                loc2 = loc1.toString();
            }
            if (this.useGrouping) 
            {
                if (this.fractionalDigits > 0) 
                {
                    loc3 = (loc2.length - this.fractionalDigits - 1) % parseInt(this.groupingPattern);
                }
                else 
                {
                    loc3 = loc2.length % parseInt(this.groupingPattern);
                }
                loc4 = loc2.slice(0, loc3);
                loc5 = loc2.slice(loc3).replace(new RegExp("(\\d{3})(?=\\d)", "g"), "$1" + this.groupingSeparator);
                if (loc4 && loc5) 
                {
                    loc2 = loc4 + this.groupingSeparator + loc5;
                }
                else if (loc4) 
                {
                    loc2 = loc4;
                }
                else 
                {
                    loc2 = loc5;
                }
            }
            if (this.decimalSeparator != ".") 
            {
                loc2 = loc2.replace(".", this.decimalSeparator);
            }
            return loc2;
        }

        public var decimalSeparator:String;

        public var fractionalDigits:int=-1;

        public var groupingPattern:String;

        public var groupingSeparator:String;

        public var useGrouping:Boolean=false;
    }
}


