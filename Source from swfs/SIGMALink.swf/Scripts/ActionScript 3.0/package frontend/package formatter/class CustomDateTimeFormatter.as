//class CustomDateTimeFormatter
package frontend.formatter 
{
    import backend.utils.*;
    import core.*;
    import flash.globalization.*;
    import utils.format.*;
    import utils.formatter.*;
    import utils.interfaces.*;
    
    public class CustomDateTimeFormatter extends Object implements utils.interfaces.ICustomDateTimeFormatter
    {
        public function CustomDateTimeFormatter()
        {
            super();
            this._dateFormatter = new utils.formatter.DateFormatterMx();
            return;
        }

        public function get dateStyle():String
        {
            return this._dateStyle;
        }

        public function set dateStyle(arg1:String):void
        {
            this._dateStyle = arg1;
            return;
        }

        public function get timeStyle():String
        {
            return this._timeStyle;
        }

        public function set timeStyle(arg1:String):void
        {
            this._timeStyle = arg1;
            return;
        }

        public function setStyle(arg1:String, arg2:*):void
        {
            return;
        }

        public function format(arg1:Object):String
        {
            var loc1:*=null;
            if (this.dateStyle == flash.globalization.DateTimeStyle.SHORT) 
            {
                if (core.MeasurementConfig.dateFormat != utils.format.DateFormat.EUROPEAN) 
                {
                    loc1 = utils.formatter.DateFormatterMx.US_FORMAT;
                }
                else 
                {
                    loc1 = utils.formatter.DateFormatterMx.EU_FORMAT;
                }
            }
            if (this.timeStyle == flash.globalization.DateTimeStyle.SHORT) 
            {
                if (loc1 != "") 
                {
                    loc1 = loc1 + " - ";
                }
                loc1 = loc1 + backend.utils.DataUtils.clockFormat;
            }
            this._dateFormatter.formatString = loc1;
            return this._dateFormatter.format(arg1);
        }

        internal var _dateStyle:String="none";

        internal var _timeStyle:String="none";

        internal var _dateFormatter:utils.formatter.DateFormatterMx;
    }
}


