//package promotion
//  class PromotionConfig
package core.promotion 
{
    public class PromotionConfig extends Object
    {
        public function PromotionConfig()
        {
            super();
            return;
        }

        public static function generateURL(arg1:String, arg2:String, arg3:String, arg4:String, arg5:String, arg6:String, arg7:Boolean=false, arg8:Boolean=false):String
        {
            return "https://promotion.sigma-dc-control.com/?language=" + arg1 + "&app=" + arg2 + "&version=" + arg3 + "&demo=" + arg8 + "&beta=" + arg7 + "&devices=" + arg5 + "&GUID=" + arg4 + "&system=" + arg6;
        }

        public static const PROMOTION_DC:String="dc";

        public static const PROMOTION_LINKC:String="link";

        public static const PROMOTION_SKRIPT_URL:String="https://promotion.sigma-dc-control.com";
    }
}


