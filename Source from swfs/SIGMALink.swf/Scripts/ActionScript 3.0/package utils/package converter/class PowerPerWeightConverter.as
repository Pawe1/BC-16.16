//class PowerPerWeightConverter
package utils.converter 
{
    public class PowerPerWeightConverter extends Object implements utils.converter.IConverter
    {
        public function PowerPerWeightConverter(arg1:String="kg", arg2:String="lb")
        {
            super();
            inputFormat = arg1;
            _outputFormat = arg2;
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
            else if (inputFormat == "kg" && outputFormat == "lb") 
            {
                loc2 = loc1 / 2.20462262;
            }
            else 
            {
                loc2 = loc1;
            }
            return loc2;
        }

        public static const KG_TO_LB:Number=2.20462262;

        public static const LB_TO_G:Number=453.59237;

        internal var _inputFormat:String="kg";

        internal var _outputFormat:String="lb";

        internal var _toInt:Boolean=false;
    }
}


