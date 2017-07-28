//class BaseTextRenderer
package feathers.controls.text 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.text.*;
    import starling.events.*;
    
    public class BaseTextRenderer extends feathers.core.FeathersControl implements feathers.core.IStateObserver
    {
        public function BaseTextRenderer()
        {
            super();
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            if (this._text == arg1) 
            {
                return;
            }
            this._text = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get stateContext():feathers.core.IStateContext
        {
            return this._stateContext;
        }

        public function set stateContext(arg1:feathers.core.IStateContext):void
        {
            if (this._stateContext === arg1) 
            {
                return;
            }
            if (this._stateContext) 
            {
                this._stateContext.removeEventListener(feathers.events.FeathersEventType.STATE_CHANGE, this.stateContext_stateChangeHandler);
            }
            this._stateContext = arg1;
            if (this._stateContext) 
            {
                this._stateContext.addEventListener(feathers.events.FeathersEventType.STATE_CHANGE, this.stateContext_stateChangeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_STATE);
            return;
        }

        public function get wordWrap():Boolean
        {
            return this._wordWrap;
        }

        public function set wordWrap(arg1:Boolean):void
        {
            if (this._wordWrap == arg1) 
            {
                return;
            }
            this._wordWrap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get fontStyles():feathers.text.FontStylesSet
        {
            return this._fontStyles;
        }

        public function set fontStyles(arg1:feathers.text.FontStylesSet):void
        {
            if (this._fontStyles === arg1) 
            {
                return;
            }
            if (this._fontStyles !== null) 
            {
                this._fontStyles.removeEventListener(starling.events.Event.CHANGE, this.fontStylesSet_changeHandler);
            }
            this._fontStyles = arg1;
            if (this._fontStyles !== null) 
            {
                this._fontStyles.addEventListener(starling.events.Event.CHANGE, this.fontStylesSet_changeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public override function dispose():void
        {
            this.stateContext = null;
            this.fontStyles = null;
            super.dispose();
            return;
        }

        protected function stateContext_stateChangeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STATE);
            return;
        }

        protected function fontStylesSet_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected var _text:String=null;

        protected var _stateContext:feathers.core.IStateContext;

        protected var _wordWrap:Boolean=false;

        protected var _fontStyles:feathers.text.FontStylesSet;
    }
}


