//class EditorClasses
package frontend.components.menuList.editors.base 
{
    import flash.utils.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.*;
    import frontend.components.menuList.editors.custom.*;
    
    public class EditorClasses extends Object
    {
        public function EditorClasses()
        {
            super();
            return;
        }

        internal static function initEditorClasses():void
        {
            editorClasses = new flash.utils.Dictionary();
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TEXTFIELD] = frontend.components.menuList.editors.TextEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_AREA] = frontend.components.menuList.editors.TextAreaEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_RADIO] = frontend.components.menuList.editors.RadioEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_RATING] = frontend.components.menuList.editors.RatingEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_CHECKBOX_MULTI] = frontend.components.menuList.editors.CheckBoxMultiEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATE] = frontend.components.menuList.editors.DateEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_TIME] = frontend.components.menuList.editors.TimeEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_DATEIME] = frontend.components.menuList.editors.DateTimeEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPINNER] = frontend.components.menuList.editors.SpinnerEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_SPORT] = frontend.components.menuList.editors.custom.SportMultiSelectEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SINGLE_SELECT_SPORT] = frontend.components.menuList.editors.custom.SportSingleSelectEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_SPORT_AND_NAME] = frontend.components.menuList.editors.custom.SportAndNameEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_UNIT_SELECTOR] = frontend.components.menuList.editors.custom.UnitEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_MULTI_SELECT_STRING] = frontend.components.menuList.editors.custom.StringMultiSelectEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_NUMBER] = frontend.components.menuList.editors.NumberEditor;
            editorClasses[frontend.components.menuList.MenuListItemTypes.ITEM_TYPE_ZONE] = frontend.components.menuList.editors.ZoneEditor;
            return;
        }

        public static function getEditor(arg1:String):*
        {
            if (editorClasses == null) 
            {
                initEditorClasses();
            }
            if (editorClasses.hasOwnProperty(arg1)) 
            {
                return editorClasses[arg1];
            }
            return null;
        }

        internal static var editorClasses:flash.utils.Dictionary;
    }
}


