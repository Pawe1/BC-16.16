//class DateTimeEditor
package frontend.components.menuList.editors 
{
    import backend.utils.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    
    public class DateTimeEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function DateTimeEditor()
        {
            super();
            orientation = ORIENTATION_CENTERED;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc2:*=null;
            var loc1:*=new feathers.layout.HorizontalLayout();
            loc1.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            loc1.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            loc1.gap = 8 * SIGMALink.scaleFactor;
            loc2 = new feathers.controls.LayoutGroup();
            loc2.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            loc2.layout = loc1;
            loc2.layoutData = new feathers.layout.HorizontalLayoutData(100, 100);
            var loc3:*=new feathers.controls.DateTimeSpinner();
            loc3.value = rawValue as Date;
            loc3.editingMode = feathers.controls.DateTimeSpinner.EDITING_MODE_TIME;
            loc3.width = editorWidth - 2 * padding;
            loc3.addEventListener(starling.events.Event.CHANGE, this.onSpinnerValueChanged);
            this.labelValue = backend.utils.DataUtils.dateTimeFormatter.format(loc3.value);
            loc2.addChild(loc3);
            return loc2;
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
            var loc1:*=arg1.currentTarget as feathers.controls.DateTimeSpinner;
            rawValue = loc1.value;
            this.labelValue = backend.utils.DataUtils.dateTimeFormatter.format(loc1.value);
            return;
        }

        internal var labelValue:String="";
    }
}


