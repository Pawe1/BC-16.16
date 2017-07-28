//class TextEditorIMEClient
package feathers.utils.text 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.text.ime.*;
    import starling.core.*;
    import starling.display.*;
    
    public class TextEditorIMEClient extends flash.display.Sprite implements flash.text.ime.IIMEClient
    {
        public function TextEditorIMEClient(arg1:feathers.core.IIMETextEditor, arg2:Function, arg3:Function, arg4:Function)
        {
            super();
            this._textEditor = arg1;
            this._startCallback = arg2;
            this._updateCallback = arg3;
            this._confirmCallback = arg4;
            this.addEventListener(flash.events.IMEEvent.IME_START_COMPOSITION, this.imeStartCompositionHandler);
            return;
        }

        public function get verticalTextLayout():Boolean
        {
            return false;
        }

        public function get compositionStartIndex():int
        {
            return this._compositionStartIndex;
        }

        public function get compositionEndIndex():int
        {
            return this._compositionEndIndex;
        }

        public function get selectionAnchorIndex():int
        {
            return this._textEditor.selectionAnchorIndex;
        }

        public function get selectionActiveIndex():int
        {
            return this._textEditor.selectionActiveIndex;
        }

        public function getTextBounds(arg1:int, arg2:int):flash.geom.Rectangle
        {
            var loc1:*=this._textEditor.stage;
            if (loc1 === null) 
            {
                return new flash.geom.Rectangle();
            }
            var loc2:*=this._textEditor.getBounds(loc1);
            var loc3:*=this._textEditor.stage === null ? starling.core.Starling.current : this._textEditor.stage.starling;
            var loc4:*=1;
            if (loc3.supportHighResolutions) 
            {
                loc4 = loc3.nativeStage.contentsScaleFactor;
            }
            var loc5:*=loc3.contentScaleFactor / loc4;
            loc2.x = loc2.x * loc5;
            loc2.y = loc2.y * loc5;
            loc2.width = loc2.width * loc5;
            loc2.height = loc2.height * loc5;
            var loc6:*=loc3.viewPort;
            loc2.x = loc2.x + loc6.x;
            loc2.y = loc2.y + loc6.y;
            return loc2;
        }

        public function confirmComposition(arg1:String=null, arg2:Boolean=false):void
        {
            this._confirmCallback(arg1, arg2);
            return;
        }

        public function updateComposition(arg1:String, arg2:__AS3__.vec.Vector.<flash.text.ime.CompositionAttributeRange>, arg3:int, arg4:int):void
        {
            this._compositionStartIndex = arg3;
            this._compositionEndIndex = arg4;
            this._updateCallback(arg1, arg2, arg3, arg4);
            return;
        }

        public function selectRange(arg1:int, arg2:int):void
        {
            return this._textEditor.selectRange(arg1, arg2);
        }

        public function getTextInRange(arg1:int, arg2:int):String
        {
            return this._textEditor.text.substring(arg1, arg2);
        }

        protected function imeStartCompositionHandler(arg1:flash.events.IMEEvent):void
        {
            arg1.imeClient = this;
            this._startCallback();
            return;
        }

        protected var _textEditor:feathers.core.IIMETextEditor;

        protected var _startCallback:Function;

        protected var _updateCallback:Function;

        protected var _confirmCallback:Function;

        protected var _compositionStartIndex:int=-1;

        protected var _compositionEndIndex:int=-1;
    }
}


