//class SportprofileFavFunctionsCategory
package core.sportprofiles 
{
    import __AS3__.vec.*;
    import utils.*;
    
    public class SportprofileFavFunctionsCategory extends Object
    {
        public function SportprofileFavFunctionsCategory(arg1:*)
        {
            functions = new __AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>();
            super();
            categoryId = arg1;
            functions = new __AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>();
            return;
        }

        public function get categoryId():uint
        {
            return _categoryId;
        }

        public function set categoryId(arg1:uint):void
        {
            _categoryId = arg1;
            return;
        }

        public function get label():String
        {
            return utils.LanguageManager.getString("SPORTPROFILE_CATEGORY_" + _categoryId);
        }

        public function addFunction(arg1:core.sportprofiles.SportprofileFavFunctionObject):void
        {
            functions.push(arg1);
            return;
        }

        internal var _categoryId:uint;

        public var functions:__AS3__.vec.Vector.<core.sportprofiles.SportprofileFavFunctionObject>;

        internal var _label:String="";

        public var sort:uint=0;
    }
}


