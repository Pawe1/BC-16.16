//class FuelEconomyFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class FuelEconomyFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatter
    {
        public function FuelEconomyFormatter()
        {
            super();
            return;
        }

        public function get formatString():String
        {
            return this._formatString;
        }

        public function set formatString(arg1:String):void
        {
            this._formatString = arg1;
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc1:*=0;
            var loc2:*=0;
            if (arg1 is String) 
            {
                arg1 = (arg1 as String).replace(",", ".");
                arg1 = parseFloat(arg1 as String);
            }
            if (arg1 is Number) 
            {
                if (isNaN(arg1 as Number)) 
                {
                    arg1 = 0;
                }
                loc3 = new RegExp("B+");
                loc4 = new RegExp("A+");
                loc5 = loc4.exec(this.formatString);
                if (loc5 == null) 
                {
                    loc6 = (arg1 as Number).toFixed(0);
                }
                else 
                {
                    loc6 = (arg1 as Number).toFixed(loc5[0].toString().length);
                }
                this.useGrouping = true;
                this.groupingSeparator = String.fromCharCode(8201);
                this.groupingPattern = "3";
                this.fractionalDigits = 0;
                loc7 = loc6.split(".");
                loc8 = super.format(loc7[0]);
                if (loc8) 
                {
                    loc7[0] = loc8;
                }
                loc9 = this.formatString;
                loc9 = loc9.replace(loc3, loc7[0]);
                if (loc7.length == 2) 
                {
                    loc9 = loc9.replace(loc4, loc7[1]);
                }
                return loc9;
            }
            return null;
        }

        internal var _formatString:String="B,AA";
    }
}


