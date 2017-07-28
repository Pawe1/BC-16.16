//class Header
package feathers.controls 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.system.*;
    import feathers.text.*;
    import feathers.utils.display.*;
    import feathers.utils.skins.*;
    import flash.display.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.system.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.text.*;
    import starling.utils.*;
    
    public class Header extends feathers.core.FeathersControl
    {
        public function Header()
        {
            super();
            if (this._fontStylesSet === null) 
            {
                this._fontStylesSet = new feathers.text.FontStylesSet();
                this._fontStylesSet.addEventListener(starling.events.Event.CHANGE, this.fontStyles_changeHandler);
            }
            this.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.header_addedToStageHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.header_removedFromStageHandler);
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

        public function get customTitleStyleName():String
        {
            return this._customTitleStyleName;
        }

        public function set customTitleStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customTitleStyleName === arg1) 
            {
                return;
            }
            this._customTitleStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        public function set titleProperties(arg1:Object):void
        {
            if (this._titleProperties == arg1) 
            {
                return;
            }
            if (arg1 && !(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            if (this._titleProperties) 
            {
                this._titleProperties.removeOnChangeCallback(this.titleProperties_onChange);
            }
            this._titleProperties = feathers.core.PropertyProxy(arg1);
            if (this._titleProperties) 
            {
                this._titleProperties.addOnChangeCallback(this.titleProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get titleAlign():String
        {
            return this._titleAlign;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.Header.globalStyleProvider;
        }

        public function set titleAlign(arg1:String):void
        {
            if (arg1 !== TITLE_ALIGN_PREFER_LEFT) 
            {
                if (arg1 === TITLE_ALIGN_PREFER_RIGHT) 
                {
                    arg1 = feathers.layout.HorizontalAlign.RIGHT;
                }
            }
            else 
            {
                arg1 = feathers.layout.HorizontalAlign.LEFT;
            }
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._titleAlign === arg1) 
            {
                return;
            }
            this._titleAlign = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get title():String
        {
            return this._title;
        }

        public function set title(arg1:String):void
        {
            if (this._title === arg1) 
            {
                return;
            }
            this._title = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public override function dispose():void
        {
            var loc1:*=null;
            if (this._disposeItems) 
            {
                var loc2:*=0;
                var loc3:*=this._leftItems;
                for each (loc1 in loc3) 
                {
                    loc1.dispose();
                }
                loc2 = 0;
                loc3 = this._centerItems;
                for each (loc1 in loc3) 
                {
                    loc1.dispose();
                }
                loc2 = 0;
                loc3 = this._rightItems;
                for each (loc1 in loc3) 
                {
                    loc1.dispose();
                }
            }
            this.leftItems = null;
            this.rightItems = null;
            this.centerItems = null;
            super.dispose();
            return;
        }

        public function get titleFactory():Function
        {
            return this._titleFactory;
        }

        public function set titleFactory(arg1:Function):void
        {
            if (this._titleFactory == arg1) 
            {
                return;
            }
            this._titleFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        protected override function initialize():void
        {
            if (!this._layout) 
            {
                this._layout = new feathers.layout.HorizontalLayout();
                this._layout.useVirtualLayout = false;
                this._layout.verticalAlign = feathers.layout.VerticalAlign.MIDDLE;
            }
            return;
        }

        public function get disposeItems():Boolean
        {
            return this._disposeItems;
        }

        public function set disposeItems(arg1:Boolean):void
        {
            this._disposeItems = arg1;
            return;
        }

        protected override function draw():void
        {
            var loc10:*=null;
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_LEFT_CONTENT);
            var loc6:*=this.isInvalid(INVALIDATION_FLAG_RIGHT_CONTENT);
            var loc7:*=this.isInvalid(INVALIDATION_FLAG_CENTER_CONTENT);
            var loc8:*=this.isInvalid(INVALIDATION_FLAG_TEXT_RENDERER);
            if (loc8) 
            {
                this.createTitle();
            }
            if (loc8 || loc2) 
            {
                this.titleTextRenderer.text = this._title;
            }
            if (loc4 || loc3) 
            {
                this.refreshBackground();
            }
            if (loc8 || loc3 || loc1) 
            {
                this.refreshLayout();
            }
            if (loc8 || loc3) 
            {
                this.refreshTitleStyles();
            }
            var loc9:*=this._ignoreItemResizing;
            this._ignoreItemResizing = true;
            if (loc5) 
            {
                if (this._leftItems) 
                {
                    var loc11:*=0;
                    var loc12:*=this._leftItems;
                    for each (loc10 in loc12) 
                    {
                        if (loc10 is feathers.core.IFeathersControl) 
                        {
                            feathers.core.IFeathersControl(loc10).styleNameList.add(this.itemStyleName);
                        }
                        this.addChild(loc10);
                    }
                }
            }
            if (loc6) 
            {
                if (this._rightItems) 
                {
                    loc11 = 0;
                    loc12 = this._rightItems;
                    for each (loc10 in loc12) 
                    {
                        if (loc10 is feathers.core.IFeathersControl) 
                        {
                            feathers.core.IFeathersControl(loc10).styleNameList.add(this.itemStyleName);
                        }
                        this.addChild(loc10);
                    }
                }
            }
            if (loc7) 
            {
                if (this._centerItems) 
                {
                    loc11 = 0;
                    loc12 = this._centerItems;
                    for each (loc10 in loc12) 
                    {
                        if (loc10 is feathers.core.IFeathersControl) 
                        {
                            feathers.core.IFeathersControl(loc10).styleNameList.add(this.itemStyleName);
                        }
                        this.addChild(loc10);
                    }
                }
            }
            this._ignoreItemResizing = loc9;
            if (loc4 || loc8) 
            {
                this.refreshEnabled();
            }
            loc1 = this.autoSizeIfNeeded() || loc1;
            this.layoutBackground();
            if (loc1 || loc5 || loc6 || loc7 || loc3) 
            {
                this.leftItemsWidth = 0;
                this.rightItemsWidth = 0;
                if (this._leftItems) 
                {
                    this.layoutLeftItems();
                }
                if (this._rightItems) 
                {
                    this.layoutRightItems();
                }
                if (this._centerItems) 
                {
                    this.layoutCenterItems();
                }
            }
            if (loc8 || loc1 || loc3 || loc2 || loc5 || loc6 || loc7) 
            {
                this.layoutTitle();
            }
            return;
        }

        protected function autoSizeIfNeeded():Boolean
        {
            var loc17:*=0;
            var loc18:*=0;
            var loc19:*=null;
            var loc20:*=NaN;
            var loc21:*=NaN;
            var loc22:*=NaN;
            var loc23:*=NaN;
            var loc24:*=null;
            var loc25:*=NaN;
            var loc26:*=NaN;
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
            var loc6:*=this.calculateExtraOSStatusBarPadding();
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=!(this._leftItems === null) && this._leftItems.length > 0;
            var loc10:*=!(this._rightItems === null) && this._rightItems.length > 0;
            var loc11:*=!(this._centerItems === null) && this._centerItems.length > 0;
            var loc12:*=this._ignoreItemResizing;
            this._ignoreItemResizing = true;
            if (loc9) 
            {
                loc17 = this._leftItems.length;
                loc18 = 0;
                while (loc18 < loc17) 
                {
                    loc19 = this._leftItems[loc18];
                    if (loc19 is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(loc19).validate();
                    }
                    loc20 = loc19.width;
                    if (loc20 === loc20) 
                    {
                        loc7 = loc7 + loc20;
                        if (loc18 > 0) 
                        {
                            loc7 = loc7 + this._gap;
                        }
                    }
                    loc21 = loc19.height;
                    if (loc21 === loc21 && loc21 > loc8) 
                    {
                        loc8 = loc21;
                    }
                    ++loc18;
                }
            }
            if (loc11) 
            {
                loc17 = this._centerItems.length;
                loc18 = 0;
                while (loc18 < loc17) 
                {
                    loc19 = this._centerItems[loc18];
                    if (loc19 is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(loc19).validate();
                    }
                    loc20 = loc19.width;
                    if (loc20 === loc20) 
                    {
                        loc7 = loc7 + loc20;
                        if (loc18 > 0) 
                        {
                            loc7 = loc7 + this._gap;
                        }
                    }
                    loc21 = loc19.height;
                    if (loc21 === loc21 && loc21 > loc8) 
                    {
                        loc8 = loc21;
                    }
                    ++loc18;
                }
            }
            if (loc10) 
            {
                loc17 = this._rightItems.length;
                loc18 = 0;
                while (loc18 < loc17) 
                {
                    loc19 = this._rightItems[loc18];
                    if (loc19 is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(loc19).validate();
                    }
                    loc20 = loc19.width;
                    if (loc20 === loc20) 
                    {
                        loc7 = loc7 + loc20;
                        if (loc18 > 0) 
                        {
                            loc7 = loc7 + this._gap;
                        }
                    }
                    loc21 = loc19.height;
                    if (loc21 === loc21 && loc21 > loc8) 
                    {
                        loc8 = loc21;
                    }
                    ++loc18;
                }
            }
            this._ignoreItemResizing = loc12;
            if (this._titleAlign === feathers.layout.HorizontalAlign.CENTER && loc11) 
            {
                if (loc9) 
                {
                    loc7 = loc7 + this._gap;
                }
                if (loc10) 
                {
                    loc7 = loc7 + this._gap;
                }
            }
            else if (this._title !== null) 
            {
                loc22 = this._titleGap;
                if (loc22 !== loc22) 
                {
                    loc22 = this._gap;
                }
                loc23 = this._explicitWidth;
                if (loc1) 
                {
                    loc23 = this._explicitMaxWidth;
                }
                loc23 = loc23 - loc7;
                if (loc9) 
                {
                    loc23 = loc23 - loc22;
                }
                if (loc11) 
                {
                    loc23 = loc23 - loc22;
                }
                if (loc10) 
                {
                    loc23 = loc23 - loc22;
                }
                if (loc23 < 0) 
                {
                    loc23 = 0;
                }
                this.titleTextRenderer.maxWidth = loc23;
                loc24 = starling.utils.Pool.getPoint();
                this.titleTextRenderer.measureText(loc24);
                loc25 = loc24.x;
                loc26 = loc24.y;
                starling.utils.Pool.putPoint(loc24);
                if (loc25 !== loc25) 
                {
                    loc25 = 0;
                }
                else 
                {
                    if (loc9) 
                    {
                        loc25 = loc25 + loc22;
                    }
                    if (loc10) 
                    {
                        loc25 = loc25 + loc22;
                    }
                }
                loc7 = loc7 + loc25;
                if (loc26 === loc26 && loc26 > loc8) 
                {
                    loc8 = loc26;
                }
            }
            var loc13:*=this._explicitWidth;
            if (loc1) 
            {
                loc13 = loc7 + this._paddingLeft + this._paddingRight;
                if (!(this.currentBackgroundSkin === null) && this.currentBackgroundSkin.width > loc13) 
                {
                    loc13 = this.currentBackgroundSkin.width;
                }
            }
            var loc14:*=this._explicitHeight;
            if (loc2) 
            {
                loc14 = loc8;
                loc14 = loc14 + (this._paddingTop + this._paddingBottom);
                if (!(this.currentBackgroundSkin === null) && this.currentBackgroundSkin.height > loc14) 
                {
                    loc14 = this.currentBackgroundSkin.height;
                }
                if (loc6 > 0) 
                {
                    if (loc14 < this._explicitMinHeight) 
                    {
                        loc14 = this._explicitMinHeight;
                    }
                    loc14 = loc14 + loc6;
                }
            }
            var loc15:*=this._explicitMinWidth;
            if (loc3) 
            {
                loc15 = loc7 + this._paddingLeft + this._paddingRight;
                if (this.currentBackgroundSkin !== null) 
                {
                    if (loc5 === null) 
                    {
                        if (this._explicitBackgroundMinWidth > loc15) 
                        {
                            loc15 = this._explicitBackgroundMinWidth;
                        }
                    }
                    else if (loc5.minWidth > loc15) 
                    {
                        loc15 = loc5.minWidth;
                    }
                }
            }
            var loc16:*=this._explicitMinHeight;
            if (loc4) 
            {
                loc16 = loc8;
                loc16 = loc16 + (this._paddingTop + this._paddingBottom);
                if (this.currentBackgroundSkin !== null) 
                {
                    if (loc5 === null) 
                    {
                        if (this._explicitBackgroundMinHeight > loc16) 
                        {
                            loc16 = this._explicitBackgroundMinHeight;
                        }
                    }
                    else if (loc5.minHeight > loc16) 
                    {
                        loc16 = loc5.minHeight;
                    }
                }
                if (loc6 > 0) 
                {
                    loc16 = loc16 + loc6;
                }
            }
            return this.saveMeasurements(loc13, loc14, loc15, loc16);
        }

        public function get leftItems():__AS3__.vec.Vector.<starling.display.DisplayObject>
        {
            return this._leftItems;
        }

        public function set leftItems(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>):void
        {
            var loc1:*=null;
            if (this._leftItems == arg1) 
            {
                return;
            }
            if (this._leftItems) 
            {
                var loc2:*=0;
                var loc3:*=this._leftItems;
                for each (loc1 in loc3) 
                {
                    if (loc1 is feathers.core.IFeathersControl) 
                    {
                        feathers.core.IFeathersControl(loc1).styleNameList.remove(this.itemStyleName);
                        loc1.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.item_resizeHandler);
                    }
                    loc1.removeFromParent();
                }
            }
            this._leftItems = arg1;
            if (this._leftItems) 
            {
                loc2 = 0;
                loc3 = this._leftItems;
                for each (loc1 in loc3) 
                {
                    if (!(loc1 is feathers.core.IFeathersControl)) 
                    {
                        continue;
                    }
                    loc1.addEventListener(feathers.events.FeathersEventType.RESIZE, this.item_resizeHandler);
                }
            }
            this.invalidate(INVALIDATION_FLAG_LEFT_CONTENT);
            return;
        }

        protected function createTitle():void
        {
            if (this.titleTextRenderer) 
            {
                this.removeChild(starling.display.DisplayObject(this.titleTextRenderer), true);
                this.titleTextRenderer = null;
            }
            var loc1:*=this._titleFactory == null ? feathers.core.FeathersControl.defaultTextRendererFactory : this._titleFactory;
            this.titleTextRenderer = feathers.core.ITextRenderer(loc1());
            var loc2:*=feathers.core.IFeathersControl(this.titleTextRenderer);
            var loc3:*=this._customTitleStyleName == null ? this.titleStyleName : this._customTitleStyleName;
            loc2.styleNameList.add(loc3);
            this.addChild(starling.display.DisplayObject(loc2));
            return;
        }

        public function get centerItems():__AS3__.vec.Vector.<starling.display.DisplayObject>
        {
            return this._centerItems;
        }

        public function set centerItems(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>):void
        {
            var loc1:*=null;
            if (this._centerItems == arg1) 
            {
                return;
            }
            if (this._centerItems) 
            {
                var loc2:*=0;
                var loc3:*=this._centerItems;
                for each (loc1 in loc3) 
                {
                    if (loc1 is feathers.core.IFeathersControl) 
                    {
                        feathers.core.IFeathersControl(loc1).styleNameList.remove(this.itemStyleName);
                        loc1.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.item_resizeHandler);
                    }
                    loc1.removeFromParent();
                }
            }
            this._centerItems = arg1;
            if (this._centerItems) 
            {
                loc2 = 0;
                loc3 = this._centerItems;
                for each (loc1 in loc3) 
                {
                    if (!(loc1 is feathers.core.IFeathersControl)) 
                    {
                        continue;
                    }
                    loc1.addEventListener(feathers.events.FeathersEventType.RESIZE, this.item_resizeHandler);
                }
            }
            this.invalidate(INVALIDATION_FLAG_CENTER_CONTENT);
            return;
        }

        protected function refreshBackground():void
        {
            var loc1:*=null;
            this.currentBackgroundSkin = this._backgroundSkin;
            if (!this._isEnabled && this._backgroundDisabledSkin) 
            {
                if (this._backgroundSkin !== null) 
                {
                    this._backgroundSkin.visible = false;
                }
                this.currentBackgroundSkin = this._backgroundDisabledSkin;
            }
            else if (this._backgroundDisabledSkin !== null) 
            {
                this._backgroundDisabledSkin.visible = false;
            }
            if (this.currentBackgroundSkin !== null) 
            {
                this.currentBackgroundSkin.visible = true;
                if (this.currentBackgroundSkin is feathers.core.IFeathersControl) 
                {
                    feathers.core.IFeathersControl(this.currentBackgroundSkin).initializeNow();
                }
                if (this.currentBackgroundSkin is feathers.core.IMeasureDisplayObject) 
                {
                    loc1 = feathers.core.IMeasureDisplayObject(this.currentBackgroundSkin);
                    this._explicitBackgroundWidth = loc1.explicitWidth;
                    this._explicitBackgroundHeight = loc1.explicitHeight;
                    this._explicitBackgroundMinWidth = loc1.explicitMinWidth;
                    this._explicitBackgroundMinHeight = loc1.explicitMinHeight;
                    this._explicitBackgroundMaxWidth = loc1.explicitMaxWidth;
                    this._explicitBackgroundMaxHeight = loc1.explicitMaxHeight;
                }
                else 
                {
                    this._explicitBackgroundWidth = this.currentBackgroundSkin.width;
                    this._explicitBackgroundHeight = this.currentBackgroundSkin.height;
                    this._explicitBackgroundMinWidth = this._explicitBackgroundWidth;
                    this._explicitBackgroundMinHeight = this._explicitBackgroundHeight;
                    this._explicitBackgroundMaxWidth = this._explicitBackgroundWidth;
                    this._explicitBackgroundMaxHeight = this._explicitBackgroundHeight;
                }
            }
            return;
        }

        public function get rightItems():__AS3__.vec.Vector.<starling.display.DisplayObject>
        {
            return this._rightItems;
        }

        public function set rightItems(arg1:__AS3__.vec.Vector.<starling.display.DisplayObject>):void
        {
            var loc1:*=null;
            if (this._rightItems == arg1) 
            {
                return;
            }
            if (this._rightItems) 
            {
                var loc2:*=0;
                var loc3:*=this._rightItems;
                for each (loc1 in loc3) 
                {
                    if (loc1 is feathers.core.IFeathersControl) 
                    {
                        feathers.core.IFeathersControl(loc1).styleNameList.remove(this.itemStyleName);
                        loc1.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.item_resizeHandler);
                    }
                    loc1.removeFromParent();
                }
            }
            this._rightItems = arg1;
            if (this._rightItems) 
            {
                loc2 = 0;
                loc3 = this._rightItems;
                for each (loc1 in loc3) 
                {
                    if (!(loc1 is feathers.core.IFeathersControl)) 
                    {
                        continue;
                    }
                    loc1.addEventListener(feathers.events.FeathersEventType.RESIZE, this.item_resizeHandler);
                }
            }
            this.invalidate(INVALIDATION_FLAG_RIGHT_CONTENT);
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

        protected function refreshLayout():void
        {
            this._layout.gap = this._gap;
            this._layout.paddingTop = this._paddingTop + this.calculateExtraOSStatusBarPadding();
            this._layout.paddingBottom = this._paddingBottom;
            this._layout.verticalAlign = this._verticalAlign;
            return;
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

        protected function refreshEnabled():void
        {
            this.titleTextRenderer.isEnabled = this._isEnabled;
            return;
        }

        public function get paddingRight():Number
        {
            return this._paddingRight;
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

        protected function refreshTitleStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            this.titleTextRenderer.fontStyles = this._fontStylesSet;
            var loc3:*=0;
            var loc4:*=this._titleProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._titleProperties[loc1];
                this.titleTextRenderer[loc1] = loc2;
            }
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

        protected function calculateExtraOSStatusBarPadding():Number
        {
            var loc4:*=null;
            if (!this._useExtraPaddingForOSStatusBar) 
            {
                return 0;
            }
            var loc1:*=flash.system.Capabilities.os;
            if (loc1.indexOf(IOS_NAME_PREFIX) === -1) 
            {
                if (loc1.indexOf(OLD_IOS_NAME_PREFIX) === -1) 
                {
                    return 0;
                }
                else 
                {
                    loc1 = loc1.substring(OLD_IOS_NAME_PREFIX.length, loc1.indexOf("."));
                }
            }
            else 
            {
                loc1 = loc1.substring(IOS_NAME_PREFIX.length, loc1.indexOf("."));
            }
            if (parseInt(loc1, 10) < STATUS_BAR_MIN_IOS_VERSION) 
            {
                return 0;
            }
            var loc2:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            var loc3:*=loc2.nativeStage;
            if (loc3.displayState !== flash.display.StageDisplayState.NORMAL) 
            {
                return 0;
            }
            if (iOSStatusBarScaledHeight !== iOSStatusBarScaledHeight) 
            {
                loc4 = new feathers.utils.display.ScreenDensityScaleCalculator();
                loc4.addScaleForDensity(168, 1);
                loc4.addScaleForDensity(326, 2);
                loc4.addScaleForDensity(401, 3);
                iOSStatusBarScaledHeight = IOS_STATUS_BAR_HEIGHT * loc4.getScale(feathers.system.DeviceCapabilities.dpi);
            }
            return iOSStatusBarScaledHeight / loc2.contentScaleFactor;
        }

        public function get paddingLeft():Number
        {
            return this._paddingLeft;
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

        protected function layoutBackground():void
        {
            if (!this.currentBackgroundSkin) 
            {
                return;
            }
            this.currentBackgroundSkin.width = this.actualWidth;
            this.currentBackgroundSkin.height = this.actualHeight;
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
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function layoutLeftItems():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this._leftItems;
            for each (loc1 in loc3) 
            {
                if (!(loc1 is feathers.core.IValidating)) 
                {
                    continue;
                }
                feathers.core.IValidating(loc1).validate();
            }
            HELPER_BOUNDS.y = loc2 = 0;
            HELPER_BOUNDS.x = loc2;
            HELPER_BOUNDS.scrollY = loc2 = 0;
            HELPER_BOUNDS.scrollX = loc2;
            HELPER_BOUNDS.explicitWidth = this.actualWidth;
            HELPER_BOUNDS.explicitHeight = this.actualHeight;
            this._layout.horizontalAlign = feathers.layout.HorizontalAlign.LEFT;
            this._layout.paddingRight = 0;
            this._layout.paddingLeft = this._paddingLeft;
            this._layout.layout(this._leftItems, HELPER_BOUNDS, HELPER_LAYOUT_RESULT);
            this.leftItemsWidth = HELPER_LAYOUT_RESULT.contentWidth;
            if (this.leftItemsWidth !== this.leftItemsWidth) 
            {
                this.leftItemsWidth = 0;
            }
            return;
        }

        public function get titleGap():Number
        {
            return this._titleGap;
        }

        public function set titleGap(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._titleGap === arg1) 
            {
                return;
            }
            this._titleGap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function layoutRightItems():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this._rightItems;
            for each (loc1 in loc3) 
            {
                if (!(loc1 is feathers.core.IValidating)) 
                {
                    continue;
                }
                feathers.core.IValidating(loc1).validate();
            }
            HELPER_BOUNDS.y = loc2 = 0;
            HELPER_BOUNDS.x = loc2;
            HELPER_BOUNDS.scrollY = loc2 = 0;
            HELPER_BOUNDS.scrollX = loc2;
            HELPER_BOUNDS.explicitWidth = this.actualWidth;
            HELPER_BOUNDS.explicitHeight = this.actualHeight;
            this._layout.horizontalAlign = feathers.layout.HorizontalAlign.RIGHT;
            this._layout.paddingRight = this._paddingRight;
            this._layout.paddingLeft = 0;
            this._layout.layout(this._rightItems, HELPER_BOUNDS, HELPER_LAYOUT_RESULT);
            this.rightItemsWidth = HELPER_LAYOUT_RESULT.contentWidth;
            if (this.rightItemsWidth !== this.rightItemsWidth) 
            {
                this.rightItemsWidth = 0;
            }
            return;
        }

        public function get useExtraPaddingForOSStatusBar():Boolean
        {
            return this._useExtraPaddingForOSStatusBar;
        }

        public function set useExtraPaddingForOSStatusBar(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._useExtraPaddingForOSStatusBar === arg1) 
            {
                return;
            }
            this._useExtraPaddingForOSStatusBar = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function layoutCenterItems():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this._centerItems;
            for each (loc1 in loc3) 
            {
                if (!(loc1 is feathers.core.IValidating)) 
                {
                    continue;
                }
                feathers.core.IValidating(loc1).validate();
            }
            HELPER_BOUNDS.y = loc2 = 0;
            HELPER_BOUNDS.x = loc2;
            HELPER_BOUNDS.scrollY = loc2 = 0;
            HELPER_BOUNDS.scrollX = loc2;
            HELPER_BOUNDS.explicitWidth = this.actualWidth;
            HELPER_BOUNDS.explicitHeight = this.actualHeight;
            this._layout.horizontalAlign = feathers.layout.HorizontalAlign.CENTER;
            this._layout.paddingRight = this._paddingRight;
            this._layout.paddingLeft = this._paddingLeft;
            this._layout.layout(this._centerItems, HELPER_BOUNDS, HELPER_LAYOUT_RESULT);
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
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function layoutTitle():void
        {
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc1:*=!(this._leftItems === null) && this._leftItems.length > 0;
            var loc2:*=!(this._rightItems === null) && this._rightItems.length > 0;
            var loc3:*=!(this._centerItems === null) && this._centerItems.length > 0;
            if (this._titleAlign === feathers.layout.HorizontalAlign.CENTER && loc3) 
            {
                this.titleTextRenderer.visible = false;
                return;
            }
            if (this._titleAlign === feathers.layout.HorizontalAlign.LEFT && loc1 && loc3) 
            {
                this.titleTextRenderer.visible = false;
                return;
            }
            if (this._titleAlign === feathers.layout.HorizontalAlign.RIGHT && loc2 && loc3) 
            {
                this.titleTextRenderer.visible = false;
                return;
            }
            this.titleTextRenderer.visible = true;
            var loc4:*=this._titleGap;
            if (loc4 !== loc4) 
            {
                loc4 = this._gap;
            }
            var loc5:*=this._paddingLeft;
            if (loc1) 
            {
                loc5 = this.leftItemsWidth + loc4;
            }
            var loc6:*=this._paddingRight;
            if (loc2) 
            {
                loc6 = this.rightItemsWidth + loc4;
            }
            if (this._titleAlign !== feathers.layout.HorizontalAlign.LEFT) 
            {
                if (this._titleAlign !== feathers.layout.HorizontalAlign.RIGHT) 
                {
                    loc9 = this.actualWidth - this._paddingLeft - this._paddingRight;
                    if (loc9 < 0) 
                    {
                        loc9 = 0;
                    }
                    loc10 = this.actualWidth - loc5 - loc6;
                    if (loc10 < 0) 
                    {
                        loc10 = 0;
                    }
                    this.titleTextRenderer.maxWidth = loc10;
                    this.titleTextRenderer.validate();
                    loc11 = this._paddingLeft + Math.round((loc9 - this.titleTextRenderer.width) / 2);
                    if (loc5 > loc11 || loc11 + this.titleTextRenderer.width > this.actualWidth - loc6) 
                    {
                        this.titleTextRenderer.x = loc5 + Math.round((loc10 - this.titleTextRenderer.width) / 2);
                    }
                    else 
                    {
                        this.titleTextRenderer.x = loc11;
                    }
                }
                else 
                {
                    loc8 = this.actualWidth - loc5 - loc6;
                    if (loc8 < 0) 
                    {
                        loc8 = 0;
                    }
                    this.titleTextRenderer.maxWidth = loc8;
                    this.titleTextRenderer.validate();
                    this.titleTextRenderer.x = this.actualWidth - this.titleTextRenderer.width - loc6;
                }
            }
            else 
            {
                loc8 = this.actualWidth - loc5 - loc6;
                if (loc8 < 0) 
                {
                    loc8 = 0;
                }
                this.titleTextRenderer.maxWidth = loc8;
                this.titleTextRenderer.validate();
                this.titleTextRenderer.x = loc5;
            }
            var loc7:*=this._paddingTop + this.calculateExtraOSStatusBarPadding();
            var loc12:*=this._verticalAlign;
            switch (loc12) 
            {
                case feathers.layout.VerticalAlign.TOP:
                {
                    this.titleTextRenderer.y = loc7;
                    break;
                }
                case feathers.layout.VerticalAlign.BOTTOM:
                {
                    this.titleTextRenderer.y = this.actualHeight - this._paddingBottom - this.titleTextRenderer.height;
                    break;
                }
                default:
                {
                    this.titleTextRenderer.y = loc7 + Math.round((this.actualHeight - loc7 - this._paddingBottom - this.titleTextRenderer.height) / 2);
                    break;
                }
            }
            return;
        }

        protected function header_addedToStageHandler(arg1:starling.events.Event):void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            loc1.nativeStage.addEventListener("fullScreen", this.nativeStage_fullScreenHandler);
            return;
        }

        protected function header_removedFromStageHandler(arg1:starling.events.Event):void
        {
            var loc1:*=this.stage === null ? starling.core.Starling.current : this.stage.starling;
            loc1.nativeStage.removeEventListener("fullScreen", this.nativeStage_fullScreenHandler);
            return;
        }

        protected function nativeStage_fullScreenHandler(arg1:flash.events.FullScreenEvent):void
        {
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        protected function fontStyles_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function titleProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:String):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function item_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreItemResizing) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get titleProperties():Object
        {
            if (!this._titleProperties) 
            {
                this._titleProperties = new feathers.core.PropertyProxy(this.titleProperties_onChange);
            }
            return this._titleProperties;
        }

        public function get backgroundSkin():starling.display.DisplayObject
        {
            return this._backgroundSkin;
        }

        public function set backgroundSkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._backgroundSkin === arg1) 
            {
                return;
            }
            if (this._backgroundSkin && !(this._backgroundSkin == this._backgroundDisabledSkin)) 
            {
                this.removeChild(this._backgroundSkin);
            }
            this._backgroundSkin = arg1;
            if (this._backgroundSkin && !(this._backgroundSkin.parent == this)) 
            {
                this._backgroundSkin.visible = false;
                this.addChildAt(this._backgroundSkin, 0);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get backgroundDisabledSkin():starling.display.DisplayObject
        {
            return this._backgroundDisabledSkin;
        }

        public function set backgroundDisabledSkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._backgroundDisabledSkin === arg1) 
            {
                return;
            }
            if (this._backgroundDisabledSkin && !(this._backgroundDisabledSkin == this._backgroundSkin)) 
            {
                this.removeChild(this._backgroundDisabledSkin);
            }
            this._backgroundDisabledSkin = arg1;
            if (this._backgroundDisabledSkin && !(this._backgroundDisabledSkin.parent == this)) 
            {
                this._backgroundDisabledSkin.visible = false;
                this.addChildAt(this._backgroundDisabledSkin, 0);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
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

        public static const VERTICAL_ALIGN_TOP:String="top";

        protected static const INVALIDATION_FLAG_LEFT_CONTENT:String="leftContent";

        protected static const INVALIDATION_FLAG_RIGHT_CONTENT:String="rightContent";

        protected static const INVALIDATION_FLAG_CENTER_CONTENT:String="centerContent";

        protected static const IOS_STATUS_BAR_HEIGHT:Number=20;

        protected static const IOS_NAME_PREFIX:String="iOS ";

        protected static const OLD_IOS_NAME_PREFIX:String="iPhone OS ";

        protected static const STATUS_BAR_MIN_IOS_VERSION:int=7;

        public static const TITLE_ALIGN_CENTER:String="center";

        public static const TITLE_ALIGN_PREFER_LEFT:String="preferLeft";

        public static const TITLE_ALIGN_PREFER_RIGHT:String="preferRight";

        public static const VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const VERTICAL_ALIGN_BOTTOM:String="bottom";

        public static const DEFAULT_CHILD_STYLE_NAME_ITEM:String="feathers-header-item";

        public static const DEFAULT_CHILD_STYLE_NAME_TITLE:String="feathers-header-title";

        internal static const HELPER_BOUNDS:feathers.layout.ViewPortBounds=new feathers.layout.ViewPortBounds();

        internal static const HELPER_LAYOUT_RESULT:feathers.layout.LayoutBoundsResult=new feathers.layout.LayoutBoundsResult();

        protected var _gap:Number=0;

        protected var _titleGap:Number=NaN;

        protected var _useExtraPaddingForOSStatusBar:Boolean=false;

        protected var _verticalAlign:String="middle";

        protected var currentBackgroundSkin:starling.display.DisplayObject;

        protected var _explicitBackgroundWidth:Number;

        protected var _explicitBackgroundHeight:Number;

        protected var _explicitBackgroundMinWidth:Number;

        protected var _explicitBackgroundMinHeight:Number;

        protected var _title:String=null;

        protected var _explicitBackgroundMaxHeight:Number;

        protected var _titleAlign:String="center";

        protected var _backgroundDisabledSkin:starling.display.DisplayObject;

        protected var _fontStylesSet:feathers.text.FontStylesSet;

        protected var _titleProperties:feathers.core.PropertyProxy;

        protected var _backgroundSkin:starling.display.DisplayObject;

        protected var _customTitleStyleName:String;

        protected var titleTextRenderer:feathers.core.ITextRenderer;

        protected var titleStyleName:String="feathers-header-title";

        protected var itemStyleName:String="feathers-header-item";

        protected var leftItemsWidth:Number=0;

        protected static var iOSStatusBarScaledHeight:Number;

        protected var rightItemsWidth:Number=0;

        protected var _layout:feathers.layout.HorizontalLayout;

        protected var _titleFactory:Function;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var _disposeItems:Boolean=true;

        protected var _ignoreItemResizing:Boolean=false;

        protected var _leftItems:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var _explicitBackgroundMaxWidth:Number;

        protected var _centerItems:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var _rightItems:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var _paddingTop:Number=0;

        protected var _paddingRight:Number=0;

        protected var _paddingBottom:Number=0;

        protected var _paddingLeft:Number=0;
    }
}


