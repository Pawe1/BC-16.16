//class GhostDistanceDecoderFormatter
package frontend.formatter 
{
    import utils.interfaces.*;
    
    public class GhostDistanceDecoderFormatter extends frontend.formatter.NumberFormatter implements utils.interfaces.ICustomFormatterBase
    {
        public function GhostDistanceDecoderFormatter()
        {
            super();
            return;
        }

        public override function format(arg1:Object):String
        {
            var loc1:*=NaN;
            if (arg1 == null) 
            {
                return "0";
            }
            loc1 = parseInt(arg1.toString());
            if (isNaN(loc1)) 
            {
                return "0";
            }
            loc1 = Math.round(loc1);
            this.useGrouping = false;
            this.fractionalDigits = 2;
            var loc2:*=super.format(loc1);
            return loc2;
        }
    }
}


