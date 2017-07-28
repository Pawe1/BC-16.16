//class StringMultiSelectEditor
package frontend.components.menuList.editors.custom 
{
    import frontend.components.list.*;
    import frontend.components.menuList.editors.*;
    import starling.display.*;
    
    public class StringMultiSelectEditor extends frontend.components.menuList.editors.MultiSelectEditor
    {
        public function StringMultiSelectEditor()
        {
            super();
            maxVisibleRows = 3;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc1:*=super.getEditor() as frontend.components.list.CustomList;
            loc1.allowScrollingInPopUpMode = true;
            loc1.itemRendererType = frontend.components.menuList.editors.custom.StringMultiSelectItemRenderer;
            return loc1;
        }
    }
}


