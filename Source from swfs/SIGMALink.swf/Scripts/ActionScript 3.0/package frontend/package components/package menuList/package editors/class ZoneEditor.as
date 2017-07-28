//class ZoneEditor
package frontend.components.menuList.editors 
{
    import feathers.controls.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.themes.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    import utils.interfaces.*;
    
    public class ZoneEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function ZoneEditor()
        {
            super();
            orientation = ORIENTATION_CENTERED;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc2:*=null;
            var loc1:*=editorInputWidth / 2 - gap;
            loc2 = this.getValues();
            this.ti1 = new feathers.controls.TextInput();
            this.ti1.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.onTextInput1Change);
            this.ti1.addEventListener(feathers.events.FeathersEventType.ENTER, this.onInput1EnterPress);
            this.ti1.styleName = "TEXTINPUT";
            this.ti1.width = loc1;
            this.showValue(this.ti1, loc2[0]);
            this.ti2 = new feathers.controls.TextInput();
            this.ti2.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.onTextInput2Change);
            this.ti2.addEventListener(feathers.events.FeathersEventType.ENTER, this.onInput2EnterPress);
            this.ti2.styleName = "TEXTINPUT";
            this.ti2.width = loc1;
            this.showValue(this.ti2, loc2[1]);
            var loc3:*=new feathers.controls.Label();
            loc3.text = this.delimiter;
            loc3.styleName = feathers.themes.CustomSIGMATheme.TEXT_STYLE_WHITELABEL;
            var loc4:*=new feathers.layout.HorizontalLayout();
            loc4.verticalAlign = "middle";
            loc4.gap = 8 * SIGMALink.scaleFactor;
            var loc5:*=new feathers.controls.LayoutGroup();
            loc5.addChild(this.ti1);
            loc5.addChild(loc3);
            loc5.addChild(this.ti2);
            return loc5;
        }

        internal function onTextInput1Change(arg1:starling.events.Event=null):void
        {
            var loc1:*=this.getValues();
            loc1[0] = parseFloat(this.ti1.text.replace(",", "."));
            loc1[0] = Math.max(this.minimum, loc1[0]);
            loc1[0] = Math.min(loc1[1] - this.minimumDifference, loc1[0]);
            this.setValues(loc1);
            this.showValue(this.ti1, loc1[0]);
            return;
        }

        internal function onTextInput2Change(arg1:starling.events.Event=null):void
        {
            var loc1:*=this.getValues();
            loc1[1] = parseFloat(this.ti2.text.replace(",", "."));
            loc1[1] = Math.max(loc1[0] + this.minimumDifference, loc1[1]);
            loc1[1] = Math.min(this.maximum, loc1[1]);
            this.setValues(loc1);
            this.showValue(this.ti2, loc1[1]);
            return;
        }

        internal function getValues():Array
        {
            return [rawValue.start, rawValue.end];
        }

        internal function setValues(arg1:Array):void
        {
            rawValue = new Object();
            rawValue.start = arg1[0];
            rawValue.end = arg1[1];
            return;
        }

        internal function showValue(arg1:feathers.controls.TextInput, arg2:Number, arg3:Boolean=false):void
        {
            var loc2:*=null;
            var loc1:*=String.fromCharCode(8201);
            if (this.formatter) 
            {
                loc2 = this.formatter.format(arg2);
                loc2 = loc2.replace(loc1, "");
                arg1.text = loc2;
            }
            else 
            {
                arg1.text = arg2.toString();
            }
            arg1.selectRange(0, arg1.text.length);
            if (arg3) 
            {
                arg1.setFocus();
            }
            return;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = rawValue;
            super.saveValue();
            return;
        }

        internal function onInput1EnterPress(arg1:starling.events.Event):void
        {
            this.ti1.removeEventListener(starling.events.Event.CHANGE, this.onTextInput1Change);
            this.ti1.removeEventListener(feathers.events.FeathersEventType.ENTER, this.onInput1EnterPress);
            this.onTextInput1Change();
            this.saveValue();
            closeEditor();
            return;
        }

        internal function onInput2EnterPress(arg1:starling.events.Event):void
        {
            this.ti2.removeEventListener(starling.events.Event.CHANGE, this.onTextInput2Change);
            this.ti2.removeEventListener(feathers.events.FeathersEventType.ENTER, this.onInput2EnterPress);
            this.onTextInput2Change();
            this.saveValue();
            closeEditor();
            return;
        }

        public var delimiter:String=" - ";

        public var formatter:utils.interfaces.ICustomFormatterBase;

        public var maximum:Number=100;

        public var minimum:Number=0;

        public var minimumDifference:Number=1;

        public var postfix:String="";

        public var prefix:String="";

        internal var ti1:feathers.controls.TextInput;

        internal var ti2:feathers.controls.TextInput;
    }
}


