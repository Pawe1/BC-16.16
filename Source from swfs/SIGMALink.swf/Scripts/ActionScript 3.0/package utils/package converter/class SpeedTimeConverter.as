//class SpeedTimeConverter
package utils.converter 
{
    import utils.*;
    
    public class SpeedTimeConverter extends Object implements utils.converter.IConverter
    {
        public function SpeedTimeConverter()
        {
            super();
            return;
        }

        public function get inputFormat():String
        {
            return null;
        }

        public function set inputFormat(arg1:String):void
        {
            return;
        }

        public function get outputFormat():String
        {
            return null;
        }

        public function set outputFormat(arg1:String):void
        {
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
            return utils.Calculations.calculateSpeedTime(arg1 as Number) * 100;
        }

        internal var _toInt:Boolean=false;
    }
}


