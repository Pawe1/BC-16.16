//class TimeFormatter
package frontend.formatter 
{
    import utils.format.*;
    import utils.interfaces.*;
    
    public class TimeFormatter extends Object implements utils.interfaces.ICustomTimeFormatter
    {
        public function TimeFormatter(arg1:String=null)
        {
            super();
            if (arg1 != null) 
            {
                this.formatString = arg1;
            }
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

        public function format(arg1:Object):String
        {
            if (arg1 == null) 
            {
                return null;
            }
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=parseInt(arg1.toString());
            if (!isNaN(loc7)) 
            {
                if (this._inputType == INPUT_MILLISECONDS) 
                {
                    loc1 = loc7 % 10;
                    loc7 = loc7 - loc1;
                    loc7 = loc7 / 10;
                }
                if (this._inputType == INPUT_MILLISECONDS || this._inputType == INPUT_HUNDREDTHSSECONDS) 
                {
                    loc2 = loc7 % 10;
                    loc7 = loc7 - loc2;
                    loc7 = loc7 / 10;
                }
                if (this._inputType == INPUT_MILLISECONDS || this._inputType == INPUT_HUNDREDTHSSECONDS || this._inputType == INPUT_TENSECONDS) 
                {
                    loc3 = loc7 % 10;
                    loc7 = loc7 - loc3;
                    loc7 = loc7 / 10;
                }
                if (this._inputType == INPUT_MILLISECONDS || this._inputType == INPUT_HUNDREDTHSSECONDS || this._inputType == INPUT_TENSECONDS || this._inputType == INPUT_SECONDS) 
                {
                    loc4 = loc7 % 60;
                    loc7 = loc7 - loc4;
                    loc7 = loc7 / 60;
                }
                if (this._inputType == INPUT_MILLISECONDS || this._inputType == INPUT_HUNDREDTHSSECONDS || this._inputType == INPUT_TENSECONDS || this._inputType == INPUT_SECONDS || this._inputType == INPUT_MINUTES) 
                {
                    loc5 = loc7 % 60;
                    loc7 = loc7 - loc5;
                    loc7 = loc7 / 60;
                }
                if (this._inputType == INPUT_MILLISECONDS || this._inputType == INPUT_HUNDREDTHSSECONDS || this._inputType == INPUT_TENSECONDS || this._inputType == INPUT_SECONDS || this._inputType == INPUT_MINUTES || this._inputType == INPUT_HOURS) 
                {
                    loc6 = loc7;
                }
                return this.generateString(loc1, loc2, loc3, loc4, loc5, loc6);
            }
            return null;
        }

        internal function generateString(arg1:int, arg2:int, arg3:int, arg4:int, arg5:int, arg6:int):String
        {
            var loc1:*=arg1.toString();
            var loc2:*=arg2.toString();
            var loc3:*=arg3.toString();
            var loc4:*=arg4.toString();
            var loc5:*=arg5.toString();
            var loc6:*=arg6.toString();
            var loc7:*=new RegExp("m");
            var loc8:*=new RegExp("h");
            var loc9:*=new RegExp("t");
            var loc10:*=new RegExp("S+");
            var loc11:*=new RegExp("M+");
            var loc12:*=new RegExp("H+");
            var loc13:*=loc7.exec(this.formatString);
            var loc14:*=loc8.exec(this.formatString);
            var loc15:*=loc9.exec(this.formatString);
            var loc16:*=loc10.exec(this.formatString);
            var loc17:*=loc11.exec(this.formatString);
            var loc18:*=loc12.exec(this.formatString);
            if (!(loc17 == null) && loc17[0] == "MM" && arg5 < 10) 
            {
                loc5 = "0" + loc5;
            }
            if (!(loc16 == null) && loc16[0] == "SS" && arg4 < 10) 
            {
                loc4 = "0" + loc4;
            }
            if (!(loc18 == null) && loc18[0] == "HH" && arg6 < 10) 
            {
                loc6 = "0" + loc6;
            }
            var loc19:*=this.formatString;
            loc19 = loc19.replace(loc7, loc1);
            loc19 = loc19.replace(loc8, loc2);
            loc19 = loc19.replace(loc9, loc3);
            loc19 = loc19.replace(loc10, loc4);
            loc19 = loc19.replace(loc11, loc5);
            loc19 = loc19.replace(loc12, loc6);
            return loc19;
        }

        public static const INPUT_HOURS:String=utils.format.TimeFormatterConstants.INPUT_HOURS;

        public static const INPUT_HUNDREDTHSSECONDS:String=utils.format.TimeFormatterConstants.INPUT_HUNDREDTHSSECONDS;

        public static const INPUT_MILLISECONDS:String=utils.format.TimeFormatterConstants.INPUT_MILLISECONDS;

        public static const INPUT_MINUTES:String=utils.format.TimeFormatterConstants.INPUT_MINUTES;

        public static const INPUT_SECONDS:String=utils.format.TimeFormatterConstants.INPUT_SECONDS;

        public static const INPUT_TENSECONDS:String=utils.format.TimeFormatterConstants.INPUT_TENSECONDS;

        internal var _formatString:String="HH:MM:SS";

        internal var _inputType:String="hundredthsSecond";
    }
}


