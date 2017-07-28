//class SpinnerEditor
package frontend.components.menuList.editors 
{
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import flash.utils.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    
    public class SpinnerEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function SpinnerEditor()
        {
            super();
            orientation = ORIENTATION_CENTERED;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc1:*=0;
            this.spinner = new feathers.controls.SpinnerList();
            this.spinner.dataProvider = dataProvider;
            this.spinner.pageThrowDuration = 0.25;
            this.spinner.itemRendererProperties.labelField = "label";
            this.spinner.width = editorWidth - 2 * padding;
            this.spinner.addEventListener(starling.events.Event.CHANGE, this.onSpinnerValueChanged);
            this.spinner.addEventListener(feathers.events.FeathersEventType.SCROLL_COMPLETE, this.onSpinnerScrollComplete);
            if (dataProvider) 
            {
                loc1 = 0;
                while (loc1 < dataProvider.data.length) 
                {
                    if (dataProvider.data[loc1].data == rawValue) 
                    {
                        this.spinner.selectedIndex = loc1;
                    }
                    ++loc1;
                }
            }
            return this.spinner;
        }

        protected override function saveValue():void
        {
            flash.utils.clearTimeout(this._saveTimeoutId);
            if (this.spinner.isScrolling) 
            {
                this._saveTimeoutId = flash.utils.setTimeout(this.saveValue, 100);
                return;
            }
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = rawValue;
            editorReturnObject.value = this.labelValue;
            editorReturnObject.selectedDataProviderItem = this.spinner.selectedItem;
            super.saveValue();
            return;
        }

        internal function onSpinnerValueChanged(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.SpinnerList;
            if (loc1.selectedItem) 
            {
                rawValue = loc1.selectedItem.data;
                this.labelValue = loc1.selectedItem.label;
            }
            return;
        }

        internal function onSpinnerScrollComplete(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.SpinnerList;
            var loc2:*=loc1.verticalScrollPosition / (loc1.layout as feathers.layout.VerticalSpinnerLayout).snapInterval % dataProvider.length;
            loc1.selectedIndex = loc2;
            return;
        }

        internal var _saveTimeoutId:uint=0;

        internal var initalSelectedIndex:int=-1;

        internal var labelValue:String="";

        internal var spinner:feathers.controls.SpinnerList;
    }
}


