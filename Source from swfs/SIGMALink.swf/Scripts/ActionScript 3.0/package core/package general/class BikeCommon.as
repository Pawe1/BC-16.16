//class BikeCommon
package core.general 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class BikeCommon extends Object
    {
        public function BikeCommon()
        {
            super();
            return;
        }

        
        {
            new __AS3__.vec.Vector.<Object>(4)[0] = {"label":utils.LanguageManager.getString("BIKE_1"), "data":"bike1"};
            new __AS3__.vec.Vector.<Object>(4)[1] = {"label":utils.LanguageManager.getString("BIKE_2"), "data":"bike2"};
            new __AS3__.vec.Vector.<Object>(4)[2] = {"label":utils.LanguageManager.getString("BIKE_3"), "data":"bike3"};
            new __AS3__.vec.Vector.<Object>(4)[3] = {"label":utils.LanguageManager.getString("BIKE_NO"), "data":"noBike"};
            dp = new __AS3__.vec.Vector.<Object>(4);
        }

        public static const BIKE1:String="bike1";

        public static const BIKE2:String="bike2";

        public static const BIKE3:String="bike3";

        public static const NO_BIKE:String="noBike";

        public static var dp:__AS3__.vec.Vector.<Object>;
    }
}


