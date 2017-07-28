//class SportprofileFavFunctionObject
package core.sportprofiles 
{
    import utils.*;
    
    public class SportprofileFavFunctionObject extends Object
    {
        public function SportprofileFavFunctionObject(arg1:Array, arg2:uint, arg3:uint, arg4:uint=0, arg5:Array=null)
        {
            var loc2:*=0;
            allowedBoxFormats = [0];
            allowedViews = [];
            super();
            allowedViews = arg1;
            categoryId = arg2;
            functionId = arg3;
            sort = arg4;
            if (arg5 != null) 
            {
                allowedBoxFormats = [];
                loc2 = 0;
                var loc1:*=arg5.length;
                while (loc2 < loc1) 
                {
                    if (BOX_FORMATS.indexOf(arg5[loc2] >= 0)) 
                    {
                        allowedBoxFormats.push(arg5[loc2]);
                    }
                    ++loc2;
                }
            }
            return;
        }

        public function get functionLabel():String
        {
            return utils.LanguageManager.getString("SPORTPROFILE_FUNCTION_" + functionId);
        }

        public static const ALLOWED_BOX_FORMAT_ALL:uint=0;

        public static const ALLOWED_BOX_FORMAT_BIG:uint=10;

        public static const ALLOWED_BOX_FORMAT_SMALL:uint=20;

        public static const AUTO_LAP_VIEW:uint=3;

        public static const BOX_FORMATS:Array=[0, 10, 20];

        public static const LAP_VIEW:uint=2;

        public static const TRAINING_VIEW:uint=1;

        public var allowedBoxFormats:Array;

        public var allowedViews:Array;

        public var categoryId:uint;

        public var functionId:uint;

        internal var _functionLabel:String;

        public var selected:Boolean=false;

        public var sort:uint;
    }
}


