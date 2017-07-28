//class SpeedFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class SpeedFormatter extends Object implements utils.interfaces.ICustomFormatter
    {
        public function SpeedFormatter()
        {
            super();
            return;
        }

        public function get formatString():String
        {
            return null;
        }

        public function set formatString(arg1:String):void
        {
            return;
        }

        public function format(arg1:Object):String
        {
            var loc1:*="";
            if (arg1 != null) 
            {
                loc1 = (arg1 as Number).toFixed(this.precision);
                loc1 = loc1.replace(".", this.decimalSeparator);
            }
            return loc1;
        }

        public var decimalSeparator:String=",";

        public var precision:int=2;
    }
}


