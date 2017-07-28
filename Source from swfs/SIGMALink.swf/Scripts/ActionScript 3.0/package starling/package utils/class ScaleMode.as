//class ScaleMode
package starling.utils 
{
    import starling.errors.*;
    
    public class ScaleMode extends Object
    {
        public function ScaleMode()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static function isValid(arg1:String):Boolean
        {
            return arg1 == NONE || arg1 == NO_BORDER || arg1 == SHOW_ALL;
        }

        public static const NONE:String="none";

        public static const NO_BORDER:String="noBorder";

        public static const SHOW_ALL:String="showAll";
    }
}


