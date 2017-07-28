//class SizeConverter
package utils.converter 
{
    public class SizeConverter extends Object implements utils.converter.IConverter
    {
        public function SizeConverter(arg1:String="centimeter", arg2:String="inch")
        {
            super();
            inputFormat = arg1;
            outputFormat = arg2;
            return;
        }

        public function get inputFormat():String
        {
            return _inputFormat;
        }

        public function set inputFormat(arg1:String):void
        {
            _inputFormat = arg1;
            return;
        }

        public function get outputFormat():String
        {
            return _outputFormat;
        }

        public function set outputFormat(arg1:String):void
        {
            _outputFormat = arg1;
            return;
        }

        public function set toInt(arg1:Boolean):void
        {
            _toInt = arg1;
            return;
        }

        public function get toInt():Boolean
        {
            return _toInt;
        }

        public function convert(arg1:Object):Number
        {
            var loc2:*=0;
            var loc1:*=0;
            if (arg1 is String) 
            {
                loc1 = parseFloat(arg1.toString());
            }
            if (arg1 is Number) 
            {
                loc1 = arg1 as Number;
            }
            if (inputFormat == outputFormat) 
            {
                loc2 = loc1;
            }
            else if (inputFormat == "centimeter" && outputFormat == "inch") 
            {
                loc2 = loc1 * 0.393700787;
            }
            else if (inputFormat == "inch" && outputFormat == "centimeter") 
            {
                loc2 = loc1 / 0.393700787;
            }
            return loc2;
        }

        public static const CM_TO_INCH:Number=0.393700787;

        internal var _inputFormat:String="centimeter";

        internal var _outputFormat:String="inch";

        internal var _toInt:Boolean=false;
    }
}


