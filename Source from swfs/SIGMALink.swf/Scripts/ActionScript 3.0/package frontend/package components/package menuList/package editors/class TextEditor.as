//class TextEditor
package frontend.components.menuList.editors 
{
    import feathers.controls.*;
    import feathers.controls.text.*;
    import feathers.core.*;
    import feathers.events.*;
    import frontend.components.menuList.editors.base.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class TextEditor extends frontend.components.menuList.editors.base.EditorBase
    {
        public function TextEditor()
        {
            this.stageTextEditorFunc = function ():feathers.core.ITextEditor
            {
                var loc1:*=new feathers.controls.text.StageTextTextEditor();
                loc1.autoCorrect = true;
                loc1.multiline = false;
                loc1.minHeight = 30 * SIGMALink.scaleFactor;
                return loc1;
            }
            super();
            orientation = ORIENTATION_INLINE;
            useTween = false;
            return;
        }

        public function get maxChars():uint
        {
            return this._maxChars;
        }

        public function set maxChars(arg1:uint):void
        {
            this._maxChars = arg1;
            if (this.ti != null) 
            {
                this.ti.maxChars = this.maxChars;
            }
            return;
        }

        protected override function getEditor():starling.display.DisplayObject
        {
            this.ti = new feathers.controls.TextInput();
            this.ti.addEventListener(starling.events.Event.CHANGE, this.onTextInputChange);
            this.ti.addEventListener(feathers.events.FeathersEventType.ENTER, this.onEnterPress);
            this.ti.addEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.onFocus);
            this.ti.styleName = "TEXTINPUT";
            this.ti.width = SIGMALink.appWidth - 2 * padding;
            this.ti.text = rawValue.toString();
            this.ti.textEditorFactory = this.stageTextEditorFunc;
            this.ti.setFocus();
            this.ti.selectRange(0, this.ti.text.length);
            this.ti.maxChars = this.maxChars;
            return this.ti;
        }

        protected override function saveValue():void
        {
            editorReturnObject = new frontend.components.menuList.editors.base.EditorReturnObject();
            var loc1:*=rawValue.toString();
            loc1 = starling.utils.StringUtil.trim(loc1);
            if (this.maxChars > 0) 
            {
                loc1 = loc1.slice(0, this.maxChars);
            }
            editorReturnObject.rawValue = loc1;
            editorReturnObject.value = loc1;
            super.saveValue();
            return;
        }

        internal function onFocus(arg1:starling.events.Event):void
        {
            var loc1:*=arg1.currentTarget as feathers.controls.TextInput;
            loc1.selectRange(0, loc1.text.length);
            return;
        }

        internal function onTextInputChange(arg1:starling.events.Event=null):void
        {
            rawValue = this.ti.text;
            return;
        }

        internal function onEnterPress(arg1:starling.events.Event):void
        {
            arg1.stopPropagation();
            this.ti.removeEventListener(starling.events.Event.CHANGE, this.onTextInputChange);
            this.ti.removeEventListener(feathers.events.FeathersEventType.ENTER, this.onEnterPress);
            this.ti.removeEventListener(feathers.events.FeathersEventType.FOCUS_IN, this.onFocus);
            this.ti.clearFocus();
            this.saveValue();
            closeEditor();
            return;
        }

        internal var _maxChars:uint=0;

        internal var stageTextEditorFunc:Function;

        internal var ti:feathers.controls.TextInput;
    }
}


