//class FavSetLayoutsConfig
package frontend.screen.mydevices.sportprofiles.favsets.layouts 
{
    public class FavSetLayoutsConfig extends Object
    {
        public function FavSetLayoutsConfig()
        {
            super();
            return;
        }

        public static function getTemplateById(arg1:uint):Class
        {
            var loc1:*=0;
            while (loc1 < templates.length) 
            {
                if (templates[loc1][ATTR_NAME_TEMPLATE_ID] == arg1) 
                {
                    return templates[loc1];
                }
                ++loc1;
            }
            return null;
        }

        public static function getIndexByClass(arg1:Class):int
        {
            var loc1:*=0;
            while (loc1 < templates.length) 
            {
                if (templates[loc1] == arg1) 
                {
                    return loc1;
                }
                ++loc1;
            }
            return -1;
        }

        public static function getTemplateIdByIndex(arg1:uint):int
        {
            if (templates.hasOwnProperty(arg1)) 
            {
                return templates[arg1][ATTR_NAME_TEMPLATE_ID];
            }
            return 0;
        }

        public static function templateIdExists(arg1:uint):Boolean
        {
            return templates.hasOwnProperty(arg1);
        }

        public static const ATTR_NAME_TEMPLATE_ID:String="TEMPLATE_ID";

        public static const templates:Array=[frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout1, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout2, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout3, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout4, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout7, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout8, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout9, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout11, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout12, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout13, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout14, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout15, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout16, frontend.screen.mydevices.sportprofiles.favsets.layouts.FavSetLayout17];
    }
}


