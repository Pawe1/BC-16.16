//class TouchPhase
package starling.events 
{
    import starling.errors.*;
    
    public final class TouchPhase extends Object
    {
        public function TouchPhase()
        {
            super();
            throw new starling.errors.AbstractClassError();
        }

        public static const HOVER:String="hover";

        public static const BEGAN:String="began";

        public static const MOVED:String="moved";

        public static const STATIONARY:String="stationary";

        public static const ENDED:String="ended";
    }
}


