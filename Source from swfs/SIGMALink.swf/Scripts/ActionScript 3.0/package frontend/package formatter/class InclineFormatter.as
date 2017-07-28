//class InclineFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class InclineFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatterBase
    {
        public function InclineFormatter()
        {
            this.rounding = frontend.formatter.NumberBaseRoundType.NEAREST;
            super();
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc1:*=parseInt(super.format(arg1));
            if (isNaN(loc1)) 
            {
                return "0";
            }
            var loc2:*=this.rounding;
            switch (loc2) 
            {
                case frontend.formatter.NumberBaseRoundType.DOWN:
                {
                    loc1 = Math.floor(loc1);
                    break;
                }
                case frontend.formatter.NumberBaseRoundType.UP:
                {
                    loc1 = Math.ceil(loc1);
                    break;
                }
                case frontend.formatter.NumberBaseRoundType.NEAREST:
                {
                    loc1 = Math.round(loc1);
                    break;
                }
            }
            return loc1.toString();
        }

        public var rounding:String;
    }
}


