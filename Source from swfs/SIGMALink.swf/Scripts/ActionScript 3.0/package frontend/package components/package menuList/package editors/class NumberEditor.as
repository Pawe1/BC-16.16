//class NumberEditor
package frontend.components.menuList.editors 
{
    import core.general.*;
    import feathers.controls.*;
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.events.*;
    import flash.text.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    import utils.converter.*;
    import utils.interfaces.*;
    
    public class NumberEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function NumberEditor()
        {
            this.stageTextEditorFunc = function ():feathers.core.ITextEditor
            {
                var loc1:*=new feathers.controls.text.StageTextTextEditor();
                loc1.multiline = false;
                loc1.minHeight = 30 * SIGMALink.scaleFactor;
                loc1.softKeyboardType = flash.text.SoftKeyboardType.NUMBER;
                return loc1;
            }
            super();
            orientation = ORIENTATION_INLINE;
            useTween = false;
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            this.ti = new feathers.controls.TextInput();
            this.ti.addEventListener(starling.events.Event.CHANGE, this.onTextInputChange);
            this.ti.addEventListener(feathers.events.FeathersEventType.ENTER, this.onEnterPress);
            this.ti.addEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.onFocus);
            this.ti.styleName = "TEXTINPUT";
            this.ti.width = editorInputWidth;
            this.ti.backgroundSkin = new starling.display.Quad(1, 1, core.general.Colors.LIGHTGREY);
            this.ti.backgroundFocusedSkin = new starling.display.Quad(1, 1, core.general.Colors.WHITE);
            this.ti.alignPivot("right", "center");
            this.ti.textEditorFactory = this.stageTextEditorFunc;
            if (this.converter) 
            {
                loc2 = Object(this.converter).constructor;
                this.backConverter = new loc2();
                this.backConverter.inputFormat = this.converter.outputFormat;
                this.backConverter.outputFormat = this.converter.inputFormat;
                this.backConverter.toInt = this.converter.toInt;
                loc1 = this.converter.convert(rawValue);
            }
            else 
            {
                loc1 = rawValue;
            }
            if (this.formatter) 
            {
                loc3 = this.formatter.format(loc1);
                loc4 = String.fromCharCode(8201);
                loc3 = loc3.replace(loc4, "");
                this.ti.text = loc3;
            }
            else 
            {
                this.ti.text = loc1.toString();
            }
            this.ti.setFocus();
            this.ti.selectRange(0, this.ti.text.length);
            return this.ti;
        }

        internal function onFocus(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.TextInput;
            loc1.selectRange(0, loc1.text.length);
            return;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            editorReturnObject.rawValue = rawValue.toString();
            var loc1:*=parseFloat(rawValue.toString());
            if (this.converter) 
            {
                loc1 = this.converter.convert(loc1);
            }
            if (this.formatter) 
            {
                editorReturnObject.value = this.formatter.format(loc1);
            }
            else 
            {
                editorReturnObject.value = loc1.toString();
            }
            super.saveValue();
            return;
        }

        internal function onTextInputChange(arg1:starling.events.Event=null):void
        {
            var loc1:*=parseFloat(this.ti.text.replace(",", "."));
            if (this.backConverter) 
            {
                loc1 = this.backConverter.convert(loc1);
            }
            rawValue = this.validateMinMax(loc1);
            return;
        }

        internal function onEnterPress(arg1:starling.events.Event):void
        {
            this.ti.removeEventListener(starling.events.Event.CHANGE, this.onTextInputChange);
            this.ti.removeEventListener(feathers.events.FeathersEventType.ENTER, this.onEnterPress);
            this.saveValue();
            closeEditor();
            return;
        }

        internal function validateMinMax(arg1:Number):Number
        {
            if (!isNaN(this.maximum)) 
            {
                arg1 = Math.min(arg1, this.maximum);
            }
            if (!isNaN(this.minimum)) 
            {
                arg1 = Math.max(arg1, this.minimum);
            }
            return arg1;
        }

        public var converter:utils.converter.IConverter;

        public var formatter:utils.interfaces.ICustomFormatterBase;

        public var maximum:Number;

        public var minimum:Number;

        internal var backConverter:utils.converter.IConverter;

        internal var stageTextEditorFunc:Function;

        internal var ti:feathers.controls.TextInput;
    }
}


