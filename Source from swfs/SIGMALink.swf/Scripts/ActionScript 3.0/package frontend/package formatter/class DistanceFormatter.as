//class DistanceFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class DistanceFormatter extends Object implements utils.interfaces.ICustomFormatter
    {
        public function DistanceFormatter()
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

        public function format(arg1:Object):String
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            if (arg1 is String) 
            {
                arg1 = (arg1 as String).replace(",", ".");
                arg1 = parseFloat(arg1 as String);
            }
            if (arg1 is Number) 
            {
                loc1 = new RegExp("M+");
                loc2 = new RegExp("K+");
                loc3 = loc1.exec(this.formatString);
                loc5 = 0;
                if (loc3 == null) 
                {
                    loc4 = (arg1 as Number).toFixed(0);
                }
                else 
                {
                    loc5 = loc3[0].toString().length;
                    loc4 = new RegExp("[-]*\\d+\\.*\\d{0," + loc5 + "}|[-]*\\d+").exec(arg1 + "")[0] + "";
                }
                loc6 = loc4.split(".");
                loc7 = this.formatString;
                loc7 = loc7.replace(loc2, loc6[0]);
                loc8 = "";
                if (loc6[1] != null) 
                {
                    loc8 = loc6[1];
                }
                while (loc5 > loc8.length) 
                {
                    loc8 = loc8 + "0";
                }
                loc7 = loc7.replace(loc1, loc8);
                return loc7;
            }
            return null;
        }

        internal var _formatString:String="K,MM";
    }
}


