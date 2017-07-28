//class TextCallout
package feathers.controls 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import feathers.skins.*;
    import feathers.text.*;
    import flash.ui.*;
    import starling.display.*;
    import starling.events.*;
    import starling.text.*;
    
    public class TextCallout extends feathers.controls.Callout implements feathers.core.IToolTip
    {
        public function TextCallout()
        {
            super();
            this.isQuickHitAreaEnabled = true;
            if (this._fontStylesSet === null) 
            {
                this._fontStylesSet = new feathers.text.FontStylesSet();
                this._fontStylesSet.addEventListener(starling.events.Event.CHANGE, this.fontStyles_changeHandler);
            }
            return;
        }

        protected function refreshTextRendererStyles():void
        {
            this.textRenderer.wordWrap = this._wordWrap;
            this.textRenderer.fontStyles = this._fontStylesSet;
            return;
        }

        protected override function callout_enterFrameHandler(arg1:starling.events.EnterFrameEvent):void
        {
            if (this.isCreated) 
            {
                this.positionRelativeToOrigin();
            }
            return;
        }

        protected function fontStyles_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get text():String
        {
            return this._text;
        }

        public function set text(arg1:String):void
        {
            if (this._text === arg1) 
            {
                return;
            }
            this._text = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public static function defaultCalloutFactory():feathers.controls.TextCallout
        {
            var loc1:*=new TextCallout();
            loc1.closeOnTouchBeganOutside = true;
            loc1.closeOnTouchEndedOutside = true;
            new Vector.<uint>(2)[0] = flash.ui.Keyboard.BACK;
            new Vector.<uint>(2)[1] = flash.ui.Keyboard.ESCAPE;
            loc1.closeOnKeys = new Vector.<uint>(2);
            return loc1;
        }

        public function get wordWrap():Boolean
        {
            return this._wordWrap;
        }

        public function set wordWrap(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._wordWrap === arg1) 
            {
                return;
            }
            this._wordWrap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public static function show(arg1:String, arg2:starling.display.DisplayObject, arg3:__AS3__.vec.Vector.<String>=null, arg4:Boolean=true, arg5:Function=null, arg6:Function=null):feathers.controls.TextCallout
        {
            if (!arg2.stage) 
            {
                throw new ArgumentError("TextCallout origin must be added to the stage.");
            }
            var loc1:*=arg5;
            if (loc1 === null) 
            {
                loc1 = calloutFactory;
                if (loc1 === null) 
                {
                    loc1 = defaultCalloutFactory;
                }
            }
            var loc2:*=TextCallout(loc1());
            loc2.text = arg1;
            loc2.supportedPositions = arg3;
            loc2.origin = arg2;
            loc1 = arg6;
            if (loc1 == null) 
            {
                loc1 = calloutOverlayFactory;
                if (loc1 == null) 
                {
                    loc1 = feathers.core.PopUpManager.defaultOverlayFactory;
                }
            }
            feathers.core.PopUpManager.addPopUp(loc2, arg4, false, loc1);
            loc2.validate();
            return loc2;
        }

        public function get fontStyles():starling.text.TextFormat
        {
            return this._fontStylesSet.format;
        }

        public function set fontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._fontStylesSet.format = arg1;
            return;
        }

        public function get disabledFontStyles():starling.text.TextFormat
        {
            return this._fontStylesSet.disabledFormat;
        }

        public function set disabledFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._fontStylesSet.disabledFormat = arg1;
            return;
        }

        
        {
            calloutFactory = defaultCalloutFactory;
        }

        public function get textRendererFactory():Function
        {
            return this._textRendererFactory;
        }

        public function set textRendererFactory(arg1:Function):void
        {
            if (this._textRendererFactory == arg1) 
            {
                return;
            }
            this._textRendererFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        public function get customTextRendererStyleName():String
        {
            return this._customTextRendererStyleName;
        }

        public function set customTextRendererStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customTextRendererStyleName === arg1) 
            {
                return;
            }
            this._customTextRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            if (feathers.controls.TextCallout.globalStyleProvider !== null) 
            {
                return feathers.controls.TextCallout.globalStyleProvider;
            }
            return feathers.controls.Callout.globalStyleProvider;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_TEXT_RENDERER);
            if (loc4) 
            {
                this.createTextRenderer();
            }
            if (loc4 || loc1 || loc2) 
            {
                this.refreshTextRendererData();
            }
            if (loc4 || loc3) 
            {
                this.refreshTextRendererStyles();
            }
            super.draw();
            return;
        }

        protected function createTextRenderer():void
        {
            if (this.textRenderer !== null) 
            {
                this.removeChild(starling.display.DisplayObject(this.textRenderer), true);
                this.textRenderer = null;
            }
            var loc1:*=this._textRendererFactory == null ? feathers.core.FeathersControl.defaultTextRendererFactory : this._textRendererFactory;
            this.textRenderer = feathers.core.ITextRenderer(loc1());
            var loc2:*=this._customTextRendererStyleName === null ? this.textRendererStyleName : this._customTextRendererStyleName;
            this.textRenderer.styleNameList.add(loc2);
            this.content = starling.display.DisplayObject(this.textRenderer);
            return;
        }

        protected function refreshTextRendererData():void
        {
            this.textRenderer.text = this._text;
            this.textRenderer.visible = this._text && this._text.length > 0;
            return;
        }

        public static const DEFAULT_CHILD_STYLE_NAME_TEXT_RENDERER:String="feathers-text-callout-text-renderer";

        protected var textRenderer:feathers.core.ITextRenderer;

        protected var textRendererStyleName:String="feathers-text-callout-text-renderer";

        protected var _text:String;

        protected var _wordWrap:Boolean=true;

        protected var _fontStylesSet:feathers.text.FontStylesSet;

        protected var _textRendererFactory:Function;

        public static var calloutFactory:Function;

        protected var _customTextRendererStyleName:String;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


