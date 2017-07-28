//class Panel
package feathers.controls 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.skins.*;
    import feathers.utils.skins.*;
    import starling.display.*;
    import starling.events.*;
    
    public class Panel extends feathers.controls.ScrollContainer implements feathers.core.IFocusExtras
    {
        public function Panel()
        {
            this._focusExtrasBefore = new Vector.<starling.display.DisplayObject>(0);
            this._focusExtrasAfter = new Vector.<starling.display.DisplayObject>(0);
            super();
            return;
        }

        public function get focusExtrasAfter():__AS3__.vec.Vector.<starling.display.DisplayObject>
        {
            return this._focusExtrasAfter;
        }

        public function get outerPadding():Number
        {
            return this._outerPaddingTop;
        }

        public function set outerPadding(arg1:Number):void
        {
            this.outerPaddingTop = arg1;
            this.outerPaddingRight = arg1;
            this.outerPaddingBottom = arg1;
            this.outerPaddingLeft = arg1;
            return;
        }

        protected static function defaultHeaderFactory():feathers.core.IFeathersControl
        {
            return new feathers.controls.Header();
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.Panel.globalStyleProvider;
        }

        public function get outerPaddingTop():Number
        {
            return this._outerPaddingTop;
        }

        public function set outerPaddingTop(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._outerPaddingTop === arg1) 
            {
                return;
            }
            this._outerPaddingTop = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get outerPaddingRight():Number
        {
            return this._outerPaddingRight;
        }

        public function set outerPaddingRight(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._outerPaddingRight === arg1) 
            {
                return;
            }
            this._outerPaddingRight = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get outerPaddingBottom():Number
        {
            return this._outerPaddingBottom;
        }

        public function set headerFactory(arg1:Function):void
        {
            if (this._headerFactory == arg1) 
            {
                return;
            }
            this._headerFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_HEADER_FACTORY);
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function set outerPaddingBottom(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._outerPaddingBottom === arg1) 
            {
                return;
            }
            this._outerPaddingBottom = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get outerPaddingLeft():Number
        {
            return this._outerPaddingLeft;
        }

        public function set outerPaddingLeft(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._outerPaddingLeft === arg1) 
            {
                return;
            }
            this._outerPaddingLeft = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get title():String
        {
            return this._title;
        }

        public function set title(arg1:String):void
        {
            if (this._title == arg1) 
            {
                return;
            }
            this._title = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_HEADER_FACTORY);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_FOOTER_FACTORY);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            if (loc1) 
            {
                this.createHeader();
            }
            if (loc2) 
            {
                this.createFooter();
            }
            if (loc1 || loc3) 
            {
                this.refreshHeaderStyles();
            }
            if (loc2 || loc3) 
            {
                this.refreshFooterStyles();
            }
            super.draw();
            return;
        }

        public function get headerTitleField():String
        {
            return this._headerTitleField;
        }

        public function set headerTitleField(arg1:String):void
        {
            if (this._headerTitleField == arg1) 
            {
                return;
            }
            this._headerTitleField = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function autoSizeIfNeeded():Boolean
        {
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc13:*=NaN;
            if (this._autoSizeMode === feathers.controls.AutoSizeMode.STAGE) 
            {
                return super.autoSizeIfNeeded();
            }
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            feathers.utils.skins.resetFluidChildDimensionsForMeasurement(this.currentBackgroundSkin, this._explicitWidth, this._explicitHeight, this._explicitMinWidth, this._explicitMinHeight, this._explicitMaxWidth, this._explicitMaxHeight, this._explicitBackgroundWidth, this._explicitBackgroundHeight, this._explicitBackgroundMinWidth, this._explicitBackgroundMinHeight, this._explicitBackgroundMaxWidth, this._explicitBackgroundMaxHeight);
            var loc5:*=this.currentBackgroundSkin as feathers.core.IMeasureDisplayObject;
            if (this.currentBackgroundSkin is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.currentBackgroundSkin).validate();
            }
            var loc6:*=this._explicitWidth;
            var loc7:*=this._explicitHeight;
            var loc8:*=this._explicitMinWidth;
            var loc9:*=this._explicitMinHeight;
            if (loc1) 
            {
                if (this._measureViewPort) 
                {
                    loc6 = this._viewPort.visibleWidth;
                }
                else 
                {
                    loc6 = 0;
                }
                loc6 = loc6 + (this._rightViewPortOffset + this._leftViewPortOffset);
                loc10 = this.header.width + this._outerPaddingLeft + this._outerPaddingRight;
                if (loc10 > loc6) 
                {
                    loc6 = loc10;
                }
                if (this.footer !== null) 
                {
                    loc11 = this.footer.width + this._outerPaddingLeft + this._outerPaddingRight;
                    if (loc11 > loc6) 
                    {
                        loc6 = loc11;
                    }
                }
                if (!(this.currentBackgroundSkin === null) && this.currentBackgroundSkin.width > loc6) 
                {
                    loc6 = this.currentBackgroundSkin.width;
                }
            }
            if (loc2) 
            {
                if (this._measureViewPort) 
                {
                    loc7 = this._viewPort.visibleHeight;
                }
                else 
                {
                    loc7 = 0;
                }
                loc7 = loc7 + (this._bottomViewPortOffset + this._topViewPortOffset);
                if (!(this.currentBackgroundSkin === null) && this.currentBackgroundSkin.height > loc7) 
                {
                    loc7 = this.currentBackgroundSkin.height;
                }
            }
            if (loc3) 
            {
                if (this._measureViewPort) 
                {
                    loc8 = this._viewPort.minVisibleWidth;
                }
                else 
                {
                    loc8 = 0;
                }
                loc8 = loc8 + (this._rightViewPortOffset + this._leftViewPortOffset);
                loc12 = this.header.minWidth + this._outerPaddingLeft + this._outerPaddingRight;
                if (loc12 > loc8) 
                {
                    loc8 = loc12;
                }
                if (this.footer !== null) 
                {
                    loc13 = this.footer.minWidth + this._outerPaddingLeft + this._outerPaddingRight;
                    if (loc13 > loc8) 
                    {
                        loc8 = loc13;
                    }
                }
                if (this.currentBackgroundSkin !== null) 
                {
                    if (loc5 === null) 
                    {
                        if (this._explicitBackgroundMinWidth > loc8) 
                        {
                            loc8 = this._explicitBackgroundMinWidth;
                        }
                    }
                    else if (loc5.minWidth > loc8) 
                    {
                        loc8 = loc5.minWidth;
                    }
                }
            }
            if (loc4) 
            {
                if (this._measureViewPort) 
                {
                    loc9 = this._viewPort.minVisibleHeight;
                }
                else 
                {
                    loc9 = 0;
                }
                loc9 = loc9 + (this._bottomViewPortOffset + this._topViewPortOffset);
                if (this.currentBackgroundSkin !== null) 
                {
                    if (loc5 === null) 
                    {
                        if (this._explicitBackgroundMinHeight > loc9) 
                        {
                            loc9 = this._explicitBackgroundMinHeight;
                        }
                    }
                    else if (loc5.minHeight > loc9) 
                    {
                        loc9 = loc5.minHeight;
                    }
                }
            }
            return this.saveMeasurements(loc6, loc7, loc8, loc9);
        }

        public function get headerFactory():Function
        {
            return this._headerFactory;
        }

        protected function createHeader():void
        {
            var loc3:*=null;
            if (this.header !== null) 
            {
                this.header.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.header_resizeHandler);
                loc3 = starling.display.DisplayObject(this.header);
                this._focusExtrasBefore.splice(this._focusExtrasBefore.indexOf(loc3), 1);
                this.removeRawChild(loc3, true);
                this.header = null;
            }
            var loc1:*=this._headerFactory == null ? defaultHeaderFactory : this._headerFactory;
            var loc2:*=this._customHeaderStyleName == null ? this.headerStyleName : this._customHeaderStyleName;
            this.header = feathers.core.IFeathersControl(loc1());
            this.header.styleNameList.add(loc2);
            loc3 = starling.display.DisplayObject(this.header);
            this.addRawChild(loc3);
            this._focusExtrasBefore.push(loc3);
            this.header.addEventListener(feathers.events.FeathersEventType.RESIZE, this.header_resizeHandler);
            this.header.initializeNow();
            this._explicitHeaderWidth = this.header.explicitWidth;
            this._explicitHeaderHeight = this.header.explicitHeight;
            this._explicitHeaderMinWidth = this.header.explicitMinWidth;
            this._explicitHeaderMinHeight = this.header.explicitMinHeight;
            return;
        }

        protected function createFooter():void
        {
            var loc2:*=null;
            if (this.footer !== null) 
            {
                this.footer.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.footer_resizeHandler);
                loc2 = starling.display.DisplayObject(this.footer);
                this._focusExtrasAfter.splice(this._focusExtrasAfter.indexOf(loc2), 1);
                this.removeRawChild(loc2, true);
                this.footer = null;
            }
            if (this._footerFactory === null) 
            {
                return;
            }
            var loc1:*=this._customFooterStyleName == null ? this.footerStyleName : this._customFooterStyleName;
            this.footer = feathers.core.IFeathersControl(this._footerFactory());
            this.footer.styleNameList.add(loc1);
            this.footer.addEventListener(feathers.events.FeathersEventType.RESIZE, this.footer_resizeHandler);
            loc2 = starling.display.DisplayObject(this.footer);
            this.addRawChild(loc2);
            this._focusExtrasAfter.push(loc2);
            this.footer.initializeNow();
            this._explicitFooterWidth = this.footer.explicitWidth;
            this._explicitFooterHeight = this.footer.explicitHeight;
            this._explicitFooterMinWidth = this.footer.explicitMinWidth;
            this._explicitFooterMinHeight = this.footer.explicitMinHeight;
            return;
        }

        public function get customHeaderStyleName():String
        {
            return this._customHeaderStyleName;
        }

        public function set customHeaderStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customHeaderStyleName === arg1) 
            {
                return;
            }
            this._customHeaderStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_HEADER_FACTORY);
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected function refreshHeaderStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (Object(this.header).hasOwnProperty(this._headerTitleField)) 
            {
                this.header[this._headerTitleField] = this._title;
            }
            var loc3:*=0;
            var loc4:*=this._headerProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._headerProperties[loc1];
                this.header[loc1] = loc2;
            }
            return;
        }

        public function get headerProperties():Object
        {
            if (!this._headerProperties) 
            {
                this._headerProperties = new feathers.core.PropertyProxy(childProperties_onChange);
            }
            return this._headerProperties;
        }

        public function set headerProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._headerProperties == arg1) 
            {
                return;
            }
            if (!arg1) 
            {
                arg1 = new feathers.core.PropertyProxy();
            }
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                loc1 = new feathers.core.PropertyProxy();
                var loc3:*=0;
                var loc4:*=arg1;
                for (loc2 in loc4) 
                {
                    loc1[loc2] = arg1[loc2];
                }
                arg1 = loc1;
            }
            if (this._headerProperties) 
            {
                this._headerProperties.removeOnChangeCallback(childProperties_onChange);
            }
            this._headerProperties = feathers.core.PropertyProxy(arg1);
            if (this._headerProperties) 
            {
                this._headerProperties.addOnChangeCallback(childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshFooterStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._footerProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._footerProperties[loc1];
                this.footer[loc1] = loc2;
            }
            return;
        }

        public function get footerFactory():Function
        {
            return this._footerFactory;
        }

        public function set footerFactory(arg1:Function):void
        {
            if (this._footerFactory == arg1) 
            {
                return;
            }
            this._footerFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_FOOTER_FACTORY);
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected override function calculateViewPortOffsets(arg1:Boolean=false, arg2:Boolean=false):void
        {
            var loc2:*=false;
            super.calculateViewPortOffsets(arg1);
            this._leftViewPortOffset = this._leftViewPortOffset + this._outerPaddingLeft;
            this._rightViewPortOffset = this._rightViewPortOffset + this._outerPaddingRight;
            var loc1:*=this._ignoreHeaderResizing;
            this._ignoreHeaderResizing = true;
            if (arg2) 
            {
                this.header.width = this.actualWidth - this._outerPaddingLeft - this._outerPaddingRight;
                this.header.minWidth = this.actualMinWidth - this._outerPaddingLeft - this._outerPaddingRight;
            }
            else 
            {
                this.header.width = this._explicitWidth - this._outerPaddingLeft - this._outerPaddingRight;
                this.header.minWidth = this._explicitMinWidth - this._outerPaddingLeft - this._outerPaddingRight;
            }
            this.header.maxWidth = this._explicitMaxWidth - this._outerPaddingLeft - this._outerPaddingRight;
            this.header.height = this._explicitHeaderHeight;
            this.header.minHeight = this._explicitHeaderMinHeight;
            this.header.validate();
            this._topViewPortOffset = this._topViewPortOffset + (this.header.height + this._outerPaddingTop);
            this._ignoreHeaderResizing = loc1;
            if (this.footer === null) 
            {
                this._bottomViewPortOffset = this._bottomViewPortOffset + this._outerPaddingBottom;
            }
            else 
            {
                loc2 = this._ignoreFooterResizing;
                this._ignoreFooterResizing = true;
                if (arg2) 
                {
                    this.footer.width = this.actualWidth - this._outerPaddingLeft - this._outerPaddingRight;
                    this.footer.minWidth = this.actualMinWidth - this._outerPaddingLeft - this._outerPaddingRight;
                }
                else 
                {
                    this.footer.width = this._explicitWidth - this._outerPaddingLeft - this._outerPaddingRight;
                    this.footer.minWidth = this._explicitMinWidth - this._outerPaddingLeft - this._outerPaddingRight;
                }
                this.footer.maxWidth = this._explicitMaxWidth - this._outerPaddingLeft - this._outerPaddingRight;
                this.footer.height = this._explicitFooterHeight;
                this.footer.minHeight = this._explicitFooterMinHeight;
                this.footer.validate();
                this._bottomViewPortOffset = this._bottomViewPortOffset + (this.footer.height + this._outerPaddingBottom);
                this._ignoreFooterResizing = loc2;
            }
            return;
        }

        public function get customFooterStyleName():String
        {
            return this._customFooterStyleName;
        }

        public function set customFooterStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customFooterStyleName === arg1) 
            {
                return;
            }
            this._customFooterStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_FOOTER_FACTORY);
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected override function layoutChildren():void
        {
            var loc2:*=false;
            super.layoutChildren();
            var loc1:*=this._ignoreHeaderResizing;
            this._ignoreHeaderResizing = true;
            this.header.x = this._outerPaddingLeft;
            this.header.y = this._outerPaddingTop;
            this.header.width = this.actualWidth - this._outerPaddingLeft - this._outerPaddingRight;
            this.header.height = this._explicitHeaderHeight;
            this.header.validate();
            this._ignoreHeaderResizing = loc1;
            if (this.footer !== null) 
            {
                loc2 = this._ignoreFooterResizing;
                this._ignoreFooterResizing = true;
                this.footer.x = this._outerPaddingLeft;
                this.footer.width = this.actualWidth - this._outerPaddingLeft - this._outerPaddingRight;
                this.footer.height = this._explicitFooterHeight;
                this.footer.validate();
                this.footer.y = this.actualHeight - this.footer.height - this._outerPaddingBottom;
                this._ignoreFooterResizing = loc2;
            }
            return;
        }

        public function get footerProperties():Object
        {
            if (!this._footerProperties) 
            {
                this._footerProperties = new feathers.core.PropertyProxy(childProperties_onChange);
            }
            return this._footerProperties;
        }

        public function set footerProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._footerProperties == arg1) 
            {
                return;
            }
            if (!arg1) 
            {
                arg1 = new feathers.core.PropertyProxy();
            }
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                loc1 = new feathers.core.PropertyProxy();
                var loc3:*=0;
                var loc4:*=arg1;
                for (loc2 in loc4) 
                {
                    loc1[loc2] = arg1[loc2];
                }
                arg1 = loc1;
            }
            if (this._footerProperties) 
            {
                this._footerProperties.removeOnChangeCallback(childProperties_onChange);
            }
            this._footerProperties = feathers.core.PropertyProxy(arg1);
            if (this._footerProperties) 
            {
                this._footerProperties.addOnChangeCallback(childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function header_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreHeaderResizing) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get focusExtrasBefore():__AS3__.vec.Vector.<starling.display.DisplayObject>
        {
            return this._focusExtrasBefore;
        }

        protected function footer_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreFooterResizing) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public static const DECELERATION_RATE_FAST:Number=0.99;

        public static const SCROLL_POLICY_OFF:String="off";

        public static const DEFAULT_CHILD_STYLE_NAME_FOOTER:String="feathers-panel-footer";

        public static const SCROLL_POLICY_AUTO:String="auto";

        public static const SCROLL_POLICY_ON:String="on";

        public static const SCROLL_BAR_DISPLAY_MODE_FLOAT:String="float";

        public static const SCROLL_BAR_DISPLAY_MODE_FIXED:String="fixed";

        public static const SCROLL_BAR_DISPLAY_MODE_NONE:String="none";

        public static const VERTICAL_SCROLL_BAR_POSITION_RIGHT:String="right";

        public static const VERTICAL_SCROLL_BAR_POSITION_LEFT:String="left";

        public static const INTERACTION_MODE_TOUCH:String="touch";

        public static const DEFAULT_CHILD_STYLE_NAME_HEADER:String="feathers-panel-header";

        public static const INTERACTION_MODE_TOUCH_AND_SCROLL_BARS:String="touchAndScrollBars";

        public static const MOUSE_WHEEL_SCROLL_DIRECTION_VERTICAL:String="vertical";

        public static const MOUSE_WHEEL_SCROLL_DIRECTION_HORIZONTAL:String="horizontal";

        public static const DECELERATION_RATE_NORMAL:Number=0.998;

        public static const AUTO_SIZE_MODE_STAGE:String="stage";

        public static const AUTO_SIZE_MODE_CONTENT:String="content";

        protected static const INVALIDATION_FLAG_HEADER_FACTORY:String="headerFactory";

        protected static const INVALIDATION_FLAG_FOOTER_FACTORY:String="footerFactory";

        public static const INTERACTION_MODE_MOUSE:String="mouse";

        internal var _focusExtrasAfter:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var _outerPaddingTop:Number=0;

        protected var _outerPaddingRight:Number=0;

        protected var _outerPaddingBottom:Number=0;

        protected var _explicitHeaderMinWidth:Number;

        protected var _ignoreFooterResizing:Boolean=false;

        protected var _outerPaddingLeft:Number=0;

        protected var header:feathers.core.IFeathersControl;

        protected var footer:feathers.core.IFeathersControl;

        protected var headerStyleName:String="feathers-panel-header";

        protected var _ignoreHeaderResizing:Boolean=false;

        protected var footerStyleName:String="feathers-panel-footer";

        protected var _explicitHeaderWidth:Number;

        protected var _explicitHeaderHeight:Number;

        protected var _explicitHeaderMinHeight:Number;

        protected var _explicitFooterWidth:Number;

        protected var _explicitFooterMinWidth:Number;

        protected var _explicitFooterMinHeight:Number;

        protected var _title:String=null;

        protected var _headerTitleField:String="title";

        protected var _headerFactory:Function;

        protected var _explicitFooterHeight:Number;

        protected var _footerProperties:feathers.core.PropertyProxy;

        protected var _customHeaderStyleName:String;

        protected var _headerProperties:feathers.core.PropertyProxy;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var _footerFactory:Function;

        protected var _customFooterStyleName:String;

        internal var _focusExtrasBefore:__AS3__.vec.Vector.<starling.display.DisplayObject>;
    }
}


