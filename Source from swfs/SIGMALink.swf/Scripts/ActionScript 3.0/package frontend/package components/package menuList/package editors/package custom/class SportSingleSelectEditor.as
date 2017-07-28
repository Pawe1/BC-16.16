//class SportSingleSelectEditor
package frontend.components.menuList.editors.custom 
{
    import frontend.components.list.*;
    import frontend.components.menuList.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    
    public class SportSingleSelectEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function SportSingleSelectEditor()
        {
            super();
            orientation = ORIENTATION_CENTERED;
            this.maxVisibleRows = 4.5;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc1:*=0;
            this.list = new frontend.components.list.CustomList();
            this.list.allowScrollingInPopUpMode = true;
            this.list.itemRendererType = frontend.components.menuList.editors.custom.SportSingleSelectItemRenderer;
            this.list.clipContent = true;
            this.list.dataProvider = dataProvider;
            this.list.height = this.maxVisibleRows * frontend.components.menuList.MenuList.ROW_HEIGHT_SMALL;
            this.list.width = editorWidth - 2 * padding;
            this.list.addEventListener(starling.events.Event.CHANGE, this.onSpinnerValueChanged);
            this.list.allowMultipleSelection = false;
            if (dataProvider) 
            {
                loc1 = 0;
                while (loc1 < dataProvider.data.length) 
                {
                    if (dataProvider.data[loc1].data == rawValue) 
                    {
                        this.list.selectedIndex = loc1;
                    }
                    ++loc1;
                }
            }
            return this.list;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = rawValue;
            editorReturnObject.value = this.labelValue;
            super.saveValue();
            return;
        }

        internal function onSpinnerValueChanged(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as frontend.components.list.CustomList;
            rawValue = loc1.selectedItem.data;
            return;
        }

        protected var maxVisibleRows:Number=4;

        internal var initalSelectedIndex:int=-1;

        internal var labelValue:String="";

        internal var list:frontend.components.list.CustomList;
    }
}


