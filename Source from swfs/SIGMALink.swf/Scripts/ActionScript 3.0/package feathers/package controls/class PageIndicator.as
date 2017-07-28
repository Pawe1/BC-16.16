//class PageIndicator
package feathers.controls 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class PageIndicator extends feathers.core.FeathersControl
    {
        public function PageIndicator()
        {
            this.cache = new Vector.<starling.display.DisplayObject>(0);
            this.unselectedSymbols = new Vector.<starling.display.DisplayObject>(0);
            this.symbols = new Vector.<starling.display.DisplayObject>(0);
            this._normalSymbolFactory = defaultNormalSymbolFactory;
            this._selectedSymbolFactory = defaultSelectedSymbolFactory;
            super();
            this.isQuickHitAreaEnabled = true;
            this.addEventListener(starling.events.TouchEvent.TOUCH, this.touchHandler);
            return;
        }

        public function set paddingRight(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingRight === arg1) 
            {
                return;
            }
            this._paddingRight = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get paddingBottom():Number
        {
            return this._paddingBottom;
        }

        public function set paddingBottom(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingBottom === arg1) 
            {
                return;
            }
            this._paddingBottom = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get paddingLeft():Number
        {
            return this._paddingLeft;
        }

        public function get normalSymbolFactory():Function
        {
            return this._normalSymbolFactory;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return PageIndicator.globalStyleProvider;
        }

        public function set normalSymbolFactory(arg1:Function):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._normalSymbolFactory === arg1) 
            {
                return;
            }
            this._normalSymbolFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get pageCount():int
        {
            return this._pageCount;
        }

        public function set pageCount(arg1:int):void
        {
            if (this._pageCount == arg1) 
            {
                return;
            }
            this._pageCount = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get selectedSymbolFactory():Function
        {
            return this._selectedSymbolFactory;
        }

        public function get selectedIndex():int
        {
            return this._selectedIndex;
        }

        public function set selectedIndex(arg1:int):void
        {
            arg1 = Math.max(0, Math.min(arg1, (this._pageCount - 1)));
            if (this._selectedIndex == arg1) 
            {
                return;
            }
            this._selectedIndex = arg1;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function set selectedSymbolFactory(arg1:Function):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._selectedSymbolFactory === arg1) 
            {
                return;
            }
            this._selectedSymbolFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get interactionMode():String
        {
            return this._interactionMode;
        }

        public function set interactionMode(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._interactionMode = arg1;
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_SELECTED);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_LAYOUT);
            if (loc1 || loc2 || loc3) 
            {
                this.refreshSymbols(loc3);
            }
            this.layoutSymbols(loc4);
            return;
        }

        protected function refreshSymbols(arg1:Boolean):void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=null;
            this.symbols.length = 0;
            var loc1:*=this.cache;
            if (arg1) 
            {
                loc2 = this.unselectedSymbols.length;
                loc3 = 0;
                while (loc3 < loc2) 
                {
                    loc4 = this.unselectedSymbols.shift();
                    this.removeChild(loc4, true);
                    ++loc3;
                }
                if (this.selectedSymbol) 
                {
                    this.removeChild(this.selectedSymbol, true);
                    this.selectedSymbol = null;
                }
            }
            this.cache = this.unselectedSymbols;
            this.unselectedSymbols = loc1;
            loc3 = 0;
            while (loc3 < this._pageCount) 
            {
                if (loc3 != this._selectedIndex) 
                {
                    if (this.cache.length > 0) 
                    {
                        loc4 = this.cache.shift();
                    }
                    else 
                    {
                        loc4 = this._normalSymbolFactory();
                        this.addChild(loc4);
                    }
                    this.unselectedSymbols.push(loc4);
                    this.symbols.push(loc4);
                    if (loc4 is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(loc4).validate();
                    }
                }
                else 
                {
                    if (!this.selectedSymbol) 
                    {
                        this.selectedSymbol = this._selectedSymbolFactory();
                        this.addChild(this.selectedSymbol);
                    }
                    this.symbols.push(this.selectedSymbol);
                    if (this.selectedSymbol is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(this.selectedSymbol).validate();
                    }
                }
                ++loc3;
            }
            loc2 = this.cache.length;
            loc3 = 0;
            while (loc3 < loc2) 
            {
                loc4 = this.cache.shift();
                this.removeChild(loc4, true);
                ++loc3;
            }
            return;
        }

        public function get direction():String
        {
            return this._direction;
        }

        public function set direction(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._direction === arg1) 
            {
                return;
            }
            this._direction = arg1;
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        protected function layoutSymbols(arg1:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1) 
            {
                if (this._direction == feathers.layout.Direction.VERTICAL && !(this._layout is feathers.layout.VerticalLayout)) 
                {
                    this._layout = new feathers.layout.VerticalLayout();
                    feathers.layout.IVirtualLayout(this._layout).useVirtualLayout = false;
                }
                else if (!(this._direction == feathers.layout.Direction.VERTICAL) && !(this._layout is feathers.layout.HorizontalLayout)) 
                {
                    this._layout = new feathers.layout.HorizontalLayout();
                    feathers.layout.IVirtualLayout(this._layout).useVirtualLayout = false;
                }
                if (this._layout is feathers.layout.VerticalLayout) 
                {
                    loc1 = feathers.layout.VerticalLayout(this._layout);
                    loc1.paddingTop = this._paddingTop;
                    loc1.paddingRight = this._paddingRight;
                    loc1.paddingBottom = this._paddingBottom;
                    loc1.paddingLeft = this._paddingLeft;
                    loc1.gap = this._gap;
                    loc1.horizontalAlign = this._horizontalAlign;
                    loc1.verticalAlign = this._verticalAlign;
                }
                if (this._layout is feathers.layout.HorizontalLayout) 
                {
                    loc2 = feathers.layout.HorizontalLayout(this._layout);
                    loc2.paddingTop = this._paddingTop;
                    loc2.paddingRight = this._paddingRight;
                    loc2.paddingBottom = this._paddingBottom;
                    loc2.paddingLeft = this._paddingLeft;
                    loc2.gap = this._gap;
                    loc2.horizontalAlign = this._horizontalAlign;
                    loc2.verticalAlign = this._verticalAlign;
                }
            }
            var loc3:*;
            SUGGESTED_BOUNDS.y = loc3 = 0;
            SUGGESTED_BOUNDS.x = loc3;
            SUGGESTED_BOUNDS.scrollY = loc3 = 0;
            SUGGESTED_BOUNDS.scrollX = loc3;
            SUGGESTED_BOUNDS.explicitWidth = this._explicitWidth;
            SUGGESTED_BOUNDS.explicitHeight = this._explicitHeight;
            SUGGESTED_BOUNDS.maxWidth = this._explicitMaxWidth;
            SUGGESTED_BOUNDS.maxHeight = this._explicitMaxHeight;
            SUGGESTED_BOUNDS.minWidth = this._explicitMinWidth;
            SUGGESTED_BOUNDS.minHeight = this._explicitMinHeight;
            this._layout.layout(this.symbols, SUGGESTED_BOUNDS, LAYOUT_RESULT);
            this.saveMeasurements(LAYOUT_RESULT.contentWidth, LAYOUT_RESULT.contentHeight, LAYOUT_RESULT.contentWidth, LAYOUT_RESULT.contentHeight);
            return;
        }

        public function get horizontalAlign():String
        {
            return this._horizontalAlign;
        }

        public function set horizontalAlign(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._horizontalAlign === arg1) 
            {
                return;
            }
            this._horizontalAlign = arg1;
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        protected function touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=false;
            var loc4:*=0;
            var loc5:*=NaN;
            var loc6:*=0;
            var loc7:*=NaN;
            if (!this._isEnabled || this._pageCount < 2) 
            {
                this.touchPointID = -1;
                return;
            }
            if (this.touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this, starling.events.TouchPhase.ENDED, this.touchPointID);
                if (!loc1) 
                {
                    return;
                }
                this.touchPointID = -1;
                loc2 = starling.utils.Pool.getPoint();
                loc1.getLocation(this.stage, loc2);
                loc3 = this.contains(this.stage.hitTest(loc2));
                if (loc3) 
                {
                    loc4 = (this._pageCount - 1);
                    this.globalToLocal(loc2, loc2);
                    if (this._direction != feathers.layout.Direction.VERTICAL) 
                    {
                        if (this._interactionMode !== feathers.controls.PageIndicatorInteractionMode.PRECISE) 
                        {
                            if (loc2.x < this.selectedSymbol.x) 
                            {
                                this.selectedIndex = Math.max(0, (this._selectedIndex - 1));
                            }
                            if (loc2.x > this.selectedSymbol.x + this.selectedSymbol.width) 
                            {
                                this.selectedIndex = Math.min(loc4, this._selectedIndex + 1);
                            }
                        }
                        else 
                        {
                            loc7 = this.selectedSymbol.width + (this.unselectedSymbols[0].width + this._gap) * loc4;
                            loc6 = Math.round(loc4 * (loc2.x - this.symbols[0].x) / loc7);
                            if (loc6 < 0) 
                            {
                                loc6 = 0;
                            }
                            else if (loc6 >= this._pageCount) 
                            {
                                loc6 = loc4;
                            }
                            this.selectedIndex = loc6;
                        }
                    }
                    else if (this._interactionMode !== feathers.controls.PageIndicatorInteractionMode.PRECISE) 
                    {
                        if (loc2.y < this.selectedSymbol.y) 
                        {
                            this.selectedIndex = Math.max(0, (this._selectedIndex - 1));
                        }
                        if (loc2.y > this.selectedSymbol.y + this.selectedSymbol.height) 
                        {
                            this.selectedIndex = Math.min(loc4, this._selectedIndex + 1);
                        }
                    }
                    else 
                    {
                        loc5 = this.selectedSymbol.height + (this.unselectedSymbols[0].height + this._gap) * loc4;
                        loc6 = Math.round(loc4 * (loc2.y - this.symbols[0].y) / loc5);
                        if (loc6 < 0) 
                        {
                            loc6 = 0;
                        }
                        else if (loc6 > loc4) 
                        {
                            loc6 = loc4;
                        }
                        this.selectedIndex = loc6;
                    }
                }
                starling.utils.Pool.putPoint(loc2);
            }
            else 
            {
                loc1 = arg1.getTouch(this, starling.events.TouchPhase.BEGAN);
                if (!loc1) 
                {
                    return;
                }
                this.touchPointID = loc1.id;
            }
            return;
        }

        public function get verticalAlign():String
        {
            return this._verticalAlign;
        }

        public function set verticalAlign(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._verticalAlign === arg1) 
            {
                return;
            }
            this._verticalAlign = arg1;
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        public function set paddingLeft(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingLeft === arg1) 
            {
                return;
            }
            this._paddingLeft = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get gap():Number
        {
            return this._gap;
        }

        public function set gap(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._gap === arg1) 
            {
                return;
            }
            this._gap = arg1;
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        public function get padding():Number
        {
            return this._paddingTop;
        }

        public function set padding(arg1:Number):void
        {
            this.paddingTop = arg1;
            this.paddingRight = arg1;
            this.paddingBottom = arg1;
            this.paddingLeft = arg1;
            return;
        }

        protected static function defaultSelectedSymbolFactory():starling.display.Quad
        {
            return new starling.display.Quad(25, 25, 16777215);
        }

        public function get paddingTop():Number
        {
            return this._paddingTop;
        }

        public function set paddingTop(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._paddingTop === arg1) 
            {
                return;
            }
            this._paddingTop = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected static function defaultNormalSymbolFactory():starling.display.Quad
        {
            return new starling.display.Quad(25, 25, 13421772);
        }

        public function get paddingRight():Number
        {
            return this._paddingRight;
        }

        internal static const LAYOUT_RESULT:feathers.layout.LayoutBoundsResult=new feathers.layout.LayoutBoundsResult();

        internal static const SUGGESTED_BOUNDS:feathers.layout.ViewPortBounds=new feathers.layout.ViewPortBounds();

        public static const DIRECTION_VERTICAL:String="vertical";

        public static const DIRECTION_HORIZONTAL:String="horizontal";

        public static const VERTICAL_ALIGN_TOP:String="top";

        public static const VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const HORIZONTAL_ALIGN_LEFT:String="left";

        public static const HORIZONTAL_ALIGN_CENTER:String="center";

        public static const HORIZONTAL_ALIGN_RIGHT:String="right";

        public static const INTERACTION_MODE_PREVIOUS_NEXT:String="previousNext";

        public static const INTERACTION_MODE_PRECISE:String="precise";

        public static const VERTICAL_ALIGN_BOTTOM:String="bottom";

        protected var selectedSymbol:starling.display.DisplayObject;

        protected var cache:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var unselectedSymbols:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var symbols:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var touchPointID:int=-1;

        protected var _pageCount:int=1;

        protected var _selectedIndex:int=0;

        protected var _interactionMode:String="previousNext";

        protected var _layout:feathers.layout.ILayout;

        protected var _direction:String="horizontal";

        protected var _horizontalAlign:String="center";

        protected var _verticalAlign:String="middle";

        protected var _paddingTop:Number=0;

        protected var _paddingLeft:Number=0;

        protected var _paddingBottom:Number=0;

        protected var _selectedSymbolFactory:Function;

        protected var _paddingRight:Number=0;

        protected var _gap:Number=0;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var _normalSymbolFactory:Function;
    }
}


