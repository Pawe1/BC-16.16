//class GVFacebookAppEvent
package com.milkmangames.nativeextensions 
{
    public class GVFacebookAppEvent extends Object
    {
        public function GVFacebookAppEvent(arg1:String)
        {
            super();
            this.eventName = arg1;
            this.valueToSum = NaN;
            this.params = null;
            return;
        }

        public function setValueToSum(arg1:Number):void
        {
            this.valueToSum = arg1;
            return;
        }

        public function setParameter(arg1:String, arg2:String):void
        {
            this.applyParam(arg1, arg2);
            return;
        }

        internal function applyParam(arg1:String, arg2:String):void
        {
            if (!this.params) 
            {
                this.params = {};
            }
            this.params[arg1] = arg2;
            return;
        }

        public static const EVENT_PARAM_DESCRIPTION:String="fb_description";

        public static const EVENT_PARAM_VALUE_YES:String="1";

        public static const EVENT_PARAM_VALUE_NO:String="0";

        public static const EVENT_NAME_ACTIVATED_APP:String="fb_mobile_activate_app";

        public static const EVENT_NAME_COMPLETED_REGISTRATION:String="fb_mobile_complete_registration";

        public static const EVENT_NAME_VIEWED_CONTENT:String="fb_mobile_content_view";

        public static const EVENT_NAME_SEARCHED:String="fb_mobile_search";

        public static const EVENT_NAME_RATED:String="fb_mobile_rate";

        public static const EVENT_NAME_COMPLETED_TUTORIAL:String="fb_mobile_tutorial_completion";

        public static const EVENT_NAME_ADDED_TO_CART:String="fb_mobile_add_to_cart";

        public static const EVENT_NAME_ADDED_TO_WISHLIST:String="fb_mobile_add_to_wishlist";

        public static const EVENT_NAME_INITIATED_CHECKOUT:String="fb_mobile_initiated_checkout";

        public static const EVENT_NAME_ADDED_PAYMENT_INFO:String="fb_mobile_add_payment_info";

        public static const EVENT_NAME_PURCHASED:String="fb_mobile_purchase";

        public static const EVENT_NAME_ACHIEVED_LEVEL:String="fb_mobile_level_achieved";

        public static const EVENT_NAME_UNLOCKED_ACHIEVEMENT:String="fb_mobile_achievement_unlocked";

        public static const EVENT_NAME_SPENT_CREDITS:String="fb_mobile_spent_credits";

        public static const EVENT_PARAM_CURRENCY:String="fb_currency";

        public static const EVENT_PARAM_REGISTRATION_METHOD:String="fb_registration_method";

        public static const EVENT_PARAM_CONTENT_TYPE:String="fb_content_type";

        public static const EVENT_PARAM_CONTENT_ID:String="fb_content_id";

        public static const EVENT_PARAM_SEARCH_STRING:String="fb_search_string";

        public static const EVENT_PARAM_SUCCESS:String="fb_success";

        public static const EVENT_PARAM_MAX_RATING_VALUE:String="fb_max_rating_value";

        public static const EVENT_PARAM_PAYMENT_INFO_AVAILABLE:String="fb_payment_info_available";

        public static const EVENT_PARAM_NUM_ITEMS:String="fb_num_items";

        public static const EVENT_PARAM_LEVEL:String="fb_level";

        var params:Object;

        var valueToSum:Number;

        var eventName:String;
    }
}


