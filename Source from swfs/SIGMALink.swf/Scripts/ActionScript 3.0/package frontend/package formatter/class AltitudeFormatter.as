//class AltitudeFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class AltitudeFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatter
    {
        public function AltitudeFormatter()
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

        public function get inputType():String
        {
            return this._inputType;
        }

        public function set inputType(arg1:String):void
        {
            this._inputType = arg1;
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
            var loc10:*=null;
            var loc1:*=0;
            var loc2:*=0;
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
                if (this.outputFeed) 
                {
                    arg1 = Math.round(arg1 as Number);
                }
                loc3 = new RegExp("M+");
                loc4 = new RegExp("C+");
                loc5 = loc4.exec(this.formatString);
                if (loc5 == null) 
                {
                    loc6 = int(arg1).toString();
                }
                else 
                {
                    loc10 = new frontend.formatter.NumberFormatter();
                    loc10.fractionalDigits = loc5[0].toString().length;
                    loc6 = loc10.format(arg1);
                }
                loc7 = loc6.split(",");
                loc8 = this.formatString;
                loc8 = loc8.replace(loc3, loc7[0]);
                if (loc7.length == 2) 
                {
                    loc8 = loc8.replace(loc4, loc7[1]);
                }
                this.useGrouping = true;
                this.groupingSeparator = String.fromCharCode(8201);
                this.groupingPattern = "3";
                this.fractionalDigits = 0;
                loc9 = super.format(loc8);
                return loc9;
            }
            return null;
        }

        public static const INPUT_FEET:String="ft";

        public static const INPUT_METER:String="m";

        internal var _formatString:String="M";

        internal var _inputType:String="m";

        public var outputFeed:Boolean=false;
    }
}


