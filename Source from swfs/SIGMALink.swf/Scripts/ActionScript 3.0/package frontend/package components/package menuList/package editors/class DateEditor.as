//class DateEditor
package frontend.components.menuList.editors 
{
    import backend.utils.*;
    import core.*;
    import core.general.*;
    import feathers.controls.*;
    import feathers.layout.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    import utils.interfaces.*;
    
    public class DateEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function DateEditor()
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
            loc3.locale = core.MeasurementConfig.language;
            if (!isNaN(this.minimum)) 
            {
                loc3.minimum = new Date(this.minimum);
            }
            if (!isNaN(this.maximum)) 
            {
                loc3.maximum = new Date(this.maximum);
            }
            loc3.value = rawValue as Date;
            loc3.editingMode = feathers.controls.DateTimeSpinner.EDITING_MODE_DATE;
            loc3.width = editorWidth - 2 * padding;
            loc3.addEventListener(starling.events.Event.CHANGE, this.onSpinnerValueChanged);
            this.labelValue = backend.utils.DataUtils.dateFormatter.format(loc3.value);
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
            var loc1:*=null;
            loc1 = arg1.currentTarget as feathers.controls.DateTimeSpinner;
            rawValue = loc1.value;
            this.labelValue = backend.utils.DataUtils.dateFormatter.format(loc1.value);
            return;
        }

        public var formatter:utils.interfaces.ICustomFormatterBase;

        public var maximum:Number;

        public var minimum:Number;

        internal var labelValue:String="";
    }
}


