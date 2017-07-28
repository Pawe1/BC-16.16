//class DefaultGroupedListHeaderOrFooterRenderer
package feathers.controls.renderers 
{
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.text.*;
    import feathers.utils.skins.*;
    import flash.geom.*;
    import starling.display.*;
    import starling.events.*;
    import starling.text.*;
    
    public class DefaultGroupedListHeaderOrFooterRenderer extends feathers.core.FeathersControl implements feathers.controls.renderers.IGroupedListHeaderRenderer, feathers.controls.renderers.IGroupedListFooterRenderer
    {
        public function DefaultGroupedListHeaderOrFooterRenderer()
        {
            this._contentLoaderFactory = defaultImageLoaderFactory;
            super();
            if (this._fontStylesSet === null) 
            {
                this._fontStylesSet = new feathers.text.FontStylesSet();
                this._fontStylesSet.addEventListener(starling.events.Event.CHANGE, this.fontStyles_changeHandler);
            }
            return;
        }

        public function get contentLabelField():String
        {
            return this._contentLabelField;
        }

        public function set contentLabelField(arg1:String):void
        {
            if (this._contentLabelField == arg1) 
            {
                return;
            }
            this._contentLabelField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function set contentLabelFactory(arg1:Function):void
        {
            if (this._contentLabelFactory == arg1) 
            {
                return;
            }
            this._contentLabelFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get contentLabelFunction():Function
        {
            return this._contentLabelFunction;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer.globalStyleProvider;
        }

        public function set contentLabelFunction(arg1:Function):void
        {
            if (this._contentLabelFunction == arg1) 
            {
                return;
            }
            this._contentLabelFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get data():Object
        {
            return this._data;
        }

        public function set data(arg1:Object):void
        {
            if (this._data == arg1) 
            {
                return;
            }
            this._data = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get contentLabelProperties():Object
        {
            if (!this._contentLabelProperties) 
            {
                this._contentLabelProperties = new feathers.core.PropertyProxy(this.contentLabelProperties_onChange);
            }
            return this._contentLabelProperties;
        }

        public function get groupIndex():int
        {
            return this._groupIndex;
        }

        public function set groupIndex(arg1:int):void
        {
            this._groupIndex = arg1;
            return;
        }

        public function get contentLoaderFactory():Function
        {
            return this._contentLoaderFactory;
        }

        public function get layoutIndex():int
        {
            return this._layoutIndex;
        }

        public function set layoutIndex(arg1:int):void
        {
            this._layoutIndex = arg1;
            return;
        }

        protected static function defaultImageLoaderFactory():feathers.controls.ImageLoader
        {
            return new feathers.controls.ImageLoader();
        }

        public function get owner():feathers.controls.GroupedList
        {
            return this._owner;
        }

        public function set owner(arg1:feathers.controls.GroupedList):void
        {
            if (this._owner == arg1) 
            {
                return;
            }
            this._owner = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function set contentLoaderFactory(arg1:Function):void
        {
            if (this._contentLoaderFactory == arg1) 
            {
                return;
            }
            this._contentLoaderFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get factoryID():String
        {
            return this._factoryID;
        }

        public function set factoryID(arg1:String):void
        {
            this._factoryID = arg1;
            return;
        }

        public function set customContentLabelStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customContentLabelStyleName === arg1) 
            {
                return;
            }
            this._customContentLabelStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
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
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get fontStyles():starling.text.TextFormat
        {
            return this._fontStylesSet.format;
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

        public function set fontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._fontStylesSet.format = arg1;
            return;
        }

        public function get contentField():String
        {
            return this._contentField;
        }

        public function set contentField(arg1:String):void
        {
            if (this._contentField == arg1) 
            {
                return;
            }
            this._contentField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get disabledFontStyles():starling.text.TextFormat
        {
            return this._fontStylesSet.disabledFormat;
        }

        public function get contentFunction():Function
        {
            return this._contentFunction;
        }

        public function set contentFunction(arg1:Function):void
        {
            if (this._contentFunction == arg1) 
            {
                return;
            }
            this._contentFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
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

        public function get contentSourceField():String
        {
            return this._contentSourceField;
        }

        public function set contentSourceField(arg1:String):void
        {
            if (this._contentSourceField == arg1) 
            {
                return;
            }
            this._contentSourceField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get customContentLabelStyleName():String
        {
            return this._customContentLabelStyleName;
        }

        public function get contentSourceFunction():Function
        {
            return this._contentSourceFunction;
        }

        public function set contentSourceFunction(arg1:Function):void
        {
            if (this.contentSourceFunction == arg1) 
            {
                return;
            }
            this._contentSourceFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get contentLabelFactory():Function
        {
            return this._contentLabelFactory;
        }

        public function set contentLabelProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._contentLabelProperties == arg1) 
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
            if (this._contentLabelProperties) 
            {
                this._contentLabelProperties.removeOnChangeCallback(this.contentLabelProperties_onChange);
            }
            this._contentLabelProperties = feathers.core.PropertyProxy(arg1);
            if (this._contentLabelProperties) 
            {
                this._contentLabelProperties.addOnChangeCallback(this.contentLabelProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
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

        protected function refreshContentLabelStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.contentLabel === null) 
            {
                return;
            }
            this.contentLabel.fontStyles = this._fontStylesSet;
            var loc3:*=0;
            var loc4:*=this._contentLabelProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._contentLabelProperties[loc1];
                this.contentLabel[loc1] = loc2;
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

        public override function dispose():void
        {
            if (this.content) 
            {
                this.content.removeFromParent();
            }
            if (this.contentImage) 
            {
                this.contentImage.dispose();
                this.contentImage = null;
            }
            if (this.contentLabel) 
            {
                starling.display.DisplayObject(this.contentLabel).dispose();
                this.contentLabel = null;
            }
            super.dispose();
            return;
        }

        protected function itemToContent(arg1:Object):starling.display.DisplayObject
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._contentSourceFunction != null) 
            {
                loc1 = this._contentSourceFunction(arg1);
                this.refreshContentSource(loc1);
                return this.contentImage;
            }
            if (!(this._contentSourceField == null) && arg1 && arg1.hasOwnProperty(this._contentSourceField)) 
            {
                loc1 = arg1[this._contentSourceField];
                this.refreshContentSource(loc1);
                return this.contentImage;
            }
            if (this._contentLabelFunction != null) 
            {
                loc2 = this._contentLabelFunction(arg1);
                if (loc2 is String) 
                {
                    this.refreshContentLabel(loc2 as String);
                }
                else if (loc2 === null) 
                {
                    this.refreshContentLabel(null);
                }
                else 
                {
                    this.refreshContentLabel(loc2.toString());
                }
                return starling.display.DisplayObject(this.contentLabel);
            }
            if (!(this._contentLabelField == null) && arg1 && arg1.hasOwnProperty(this._contentLabelField)) 
            {
                loc2 = arg1[this._contentLabelField];
                if (loc2 is String) 
                {
                    this.refreshContentLabel(loc2 as String);
                }
                else if (loc2 === null) 
                {
                    this.refreshContentLabel(null);
                }
                else 
                {
                    this.refreshContentLabel(loc2.toString());
                }
                return starling.display.DisplayObject(this.contentLabel);
            }
            if (this._contentFunction != null) 
            {
                return this._contentFunction(arg1) as starling.display.DisplayObject;
            }
            if (!(this._contentField == null) && arg1 && arg1.hasOwnProperty(this._contentField)) 
            {
                return arg1[this._contentField] as starling.display.DisplayObject;
            }
            if (arg1 is String) 
            {
                this.refreshContentLabel(arg1 as String);
                return starling.display.DisplayObject(this.contentLabel);
            }
            if (arg1 !== null) 
            {
                this.refreshContentLabel(arg1.toString());
                return starling.display.DisplayObject(this.contentLabel);
            }
            this.refreshContentLabel(null);
            return null;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            if (loc2 || loc3) 
            {
                this.refreshBackgroundSkin();
            }
            if (loc1) 
            {
                this.commitData();
            }
            if (loc1 || loc2) 
            {
                this.refreshContentLabelStyles();
            }
            if (loc1 || loc3) 
            {
                this.refreshEnabled();
            }
            loc4 = this.autoSizeIfNeeded() || loc4;
            this.layoutChildren();
            return;
        }

        protected function autoSizeIfNeeded():Boolean
        {
            var loc11:*=NaN;
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            var loc5:*=this.content as feathers.core.IMeasureDisplayObject;
            if (this.contentLabel === null) 
            {
                if (this.content !== null) 
                {
                    if (this._horizontalAlign === feathers.layout.HorizontalAlign.JUSTIFY && this._verticalAlign === feathers.layout.VerticalAlign.JUSTIFY) 
                    {
                        feathers.utils.skins.resetFluidChildDimensionsForMeasurement(this.content, this._explicitWidth - this._paddingLeft - this._paddingRight, this._explicitHeight - this._paddingTop - this._paddingBottom, this._explicitMinWidth - this._paddingLeft - this._paddingRight, this._explicitMinHeight - this._paddingTop - this._paddingBottom, this._explicitMaxWidth - this._paddingLeft - this._paddingRight, this._explicitMaxHeight - this._paddingTop - this._paddingBottom, this._explicitContentWidth, this._explicitContentHeight, this._explicitContentMinWidth, this._explicitContentMinHeight, this._explicitContentMaxWidth, this._explicitContentMaxHeight);
                    }
                    else 
                    {
                        this.content.width = this._explicitContentWidth;
                        this.content.height = this._explicitContentHeight;
                        if (loc5 !== null) 
                        {
                            loc5.minWidth = this._explicitContentMinWidth;
                            loc5.minHeight = this._explicitContentMinHeight;
                        }
                    }
                    if (this.content is feathers.core.IValidating) 
                    {
                        feathers.core.IValidating(this.content).validate();
                    }
                }
            }
            else 
            {
                loc11 = this._explicitWidth;
                if (loc1) 
                {
                    loc11 = this._explicitMaxWidth;
                }
                this.contentLabel.maxWidth = loc11 - this._paddingLeft - this._paddingRight;
                this.contentLabel.measureText(HELPER_POINT);
            }
            feathers.utils.skins.resetFluidChildDimensionsForMeasurement(this.currentBackgroundSkin, this._explicitWidth, this._explicitHeight, this._explicitMinWidth, this._explicitMinHeight, this._explicitMaxWidth, this._explicitMaxHeight, this._explicitBackgroundWidth, this._explicitBackgroundHeight, this._explicitBackgroundMinWidth, this._explicitBackgroundMinHeight, this._explicitBackgroundMaxWidth, this._explicitBackgroundMaxHeight);
            var loc6:*=this.currentBackgroundSkin as feathers.core.IMeasureDisplayObject;
            var loc7:*=this._explicitWidth;
            if (loc1) 
            {
                if (this.contentLabel === null) 
                {
                    if (this.content === null) 
                    {
                        loc7 = 0;
                    }
                    else 
                    {
                        loc7 = this.content.width;
                    }
                }
                else 
                {
                    loc7 = HELPER_POINT.x;
                }
                loc7 = loc7 + (this._paddingLeft + this._paddingRight);
                if (!(this.currentBackgroundSkin === null) && this.currentBackgroundSkin.width > loc7) 
                {
                    loc7 = this.currentBackgroundSkin.width;
                }
            }
            var loc8:*=this._explicitHeight;
            if (loc2) 
            {
                if (this.contentLabel === null) 
                {
                    if (this.content === null) 
                    {
                        loc8 = 0;
                    }
                    else 
                    {
                        loc8 = this.content.height;
                    }
                }
                else 
                {
                    loc8 = HELPER_POINT.y;
                }
                loc8 = loc8 + (this._paddingTop + this._paddingBottom);
                if (!(this.currentBackgroundSkin === null) && this.currentBackgroundSkin.height > loc8) 
                {
                    loc8 = this.currentBackgroundSkin.height;
                }
            }
            var loc9:*=this._explicitMinWidth;
            if (loc3) 
            {
                if (this.contentLabel === null) 
                {
                    if (loc5 === null) 
                    {
                        if (this.content === null) 
                        {
                            loc9 = 0;
                        }
                        else 
                        {
                            loc9 = this.content.width;
                        }
                    }
                    else 
                    {
                        loc9 = loc5.minWidth;
                    }
                }
                else 
                {
                    loc9 = HELPER_POINT.x;
                }
                loc9 = loc9 + (this._paddingLeft + this._paddingRight);
                if (this.currentBackgroundSkin !== null) 
                {
                    if (loc6 === null) 
                    {
                        if (this._explicitBackgroundMinWidth > loc9) 
                        {
                            loc9 = this._explicitBackgroundMinWidth;
                        }
                    }
                    else if (loc6.minWidth > loc9) 
                    {
                        loc9 = loc6.minWidth;
                    }
                }
            }
            var loc10:*=this._explicitMinHeight;
            if (loc4) 
            {
                if (this.contentLabel === null) 
                {
                    if (loc5 === null) 
                    {
                        if (this.content === null) 
                        {
                            loc10 = 0;
                        }
                        else 
                        {
                            loc10 = this.content.height;
                        }
                    }
                    else 
                    {
                        loc10 = loc5.minHeight;
                    }
                }
                else 
                {
                    loc10 = HELPER_POINT.y;
                }
                loc10 = loc10 + (this._paddingTop + this._paddingBottom);
                if (this.currentBackgroundSkin !== null) 
                {
                    if (loc6 === null) 
                    {
                        if (this._explicitBackgroundMinHeight > loc10) 
                        {
                            loc10 = this._explicitBackgroundMinHeight;
                        }
                    }
                    else if (loc6.minHeight > loc10) 
                    {
                        loc10 = loc6.minHeight;
                    }
                }
            }
            return this.saveMeasurements(loc7, loc8, loc9, loc10);
        }

        protected function refreshBackgroundSkin():void
        {
            var loc1:*=null;
            this.currentBackgroundSkin = this._backgroundSkin;
            if (!this._isEnabled && !(this._backgroundDisabledSkin === null)) 
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

        protected function commitData():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._owner) 
            {
                loc1 = this.itemToContent(this._data);
                if (loc1 !== this.content) 
                {
                    if (this.content !== null) 
                    {
                        this.content.removeFromParent();
                    }
                    this.content = loc1;
                    if (this.content !== null) 
                    {
                        this.addChild(this.content);
                        if (this.content is feathers.core.IFeathersControl) 
                        {
                            feathers.core.IFeathersControl(this.content).initializeNow();
                        }
                        if (this.content is feathers.core.IMeasureDisplayObject) 
                        {
                            loc2 = feathers.core.IMeasureDisplayObject(this.content);
                            this._explicitContentWidth = loc2.explicitWidth;
                            this._explicitContentHeight = loc2.explicitHeight;
                            this._explicitContentMinWidth = loc2.explicitMinWidth;
                            this._explicitContentMinHeight = loc2.explicitMinHeight;
                            this._explicitContentMaxWidth = loc2.explicitMaxWidth;
                            this._explicitContentMaxHeight = loc2.explicitMaxHeight;
                        }
                        else 
                        {
                            this._explicitContentWidth = this.content.width;
                            this._explicitContentHeight = this.content.height;
                            this._explicitContentMinWidth = this._explicitContentWidth;
                            this._explicitContentMinHeight = this._explicitContentHeight;
                            this._explicitContentMaxWidth = this._explicitContentWidth;
                            this._explicitContentMaxHeight = this._explicitContentHeight;
                        }
                    }
                }
            }
            else if (this.content) 
            {
                this.content.removeFromParent();
                this.content = null;
            }
            return;
        }

        protected function refreshContentSource(arg1:Object):void
        {
            if (!this.contentImage) 
            {
                this.contentImage = this._contentLoaderFactory();
            }
            this.contentImage.source = arg1;
            return;
        }

        protected function refreshContentLabel(arg1:String):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (arg1 === null) 
            {
                if (this.contentLabel !== null) 
                {
                    starling.display.DisplayObject(this.contentLabel).removeFromParent(true);
                    this.contentLabel = null;
                }
            }
            else 
            {
                if (this.contentLabel === null) 
                {
                    loc1 = this._contentLabelFactory == null ? feathers.core.FeathersControl.defaultTextRendererFactory : this._contentLabelFactory;
                    this.contentLabel = feathers.core.ITextRenderer(loc1());
                    loc2 = this._customContentLabelStyleName == null ? this.contentLabelStyleName : this._customContentLabelStyleName;
                    feathers.core.FeathersControl(this.contentLabel).styleNameList.add(loc2);
                }
                this.contentLabel.text = arg1;
            }
            return;
        }

        protected function refreshEnabled():void
        {
            if (this.content is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this.content).isEnabled = this._isEnabled;
            }
            return;
        }

        protected function layoutChildren():void
        {
            if (this.currentBackgroundSkin !== null) 
            {
                this.currentBackgroundSkin.width = this.actualWidth;
                this.currentBackgroundSkin.height = this.actualHeight;
            }
            if (this.content === null) 
            {
                return;
            }
            if (this.contentLabel !== null) 
            {
                this.contentLabel.maxWidth = this.actualWidth - this._paddingLeft - this._paddingRight;
            }
            if (this.content is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.content).validate();
            }
            var loc1:*=this._horizontalAlign;
            switch (loc1) 
            {
                case feathers.layout.HorizontalAlign.CENTER:
                {
                    this.content.x = this._paddingLeft + (this.actualWidth - this._paddingLeft - this._paddingRight - this.content.width) / 2;
                    break;
                }
                case feathers.layout.HorizontalAlign.RIGHT:
                {
                    this.content.x = this.actualWidth - this._paddingRight - this.content.width;
                    break;
                }
                case feathers.layout.HorizontalAlign.JUSTIFY:
                {
                    this.content.x = this._paddingLeft;
                    this.content.width = this.actualWidth - this._paddingLeft - this._paddingRight;
                    break;
                }
                default:
                {
                    this.content.x = this._paddingLeft;
                }
            }
            loc1 = this._verticalAlign;
            switch (loc1) 
            {
                case feathers.layout.VerticalAlign.TOP:
                {
                    this.content.y = this._paddingTop;
                    break;
                }
                case feathers.layout.VerticalAlign.BOTTOM:
                {
                    this.content.y = this.actualHeight - this._paddingBottom - this.content.height;
                    break;
                }
                case feathers.layout.VerticalAlign.JUSTIFY:
                {
                    this.content.y = this._paddingTop;
                    this.content.height = this.actualHeight - this._paddingTop - this._paddingBottom;
                    break;
                }
                default:
                {
                    this.content.y = this._paddingTop + (this.actualHeight - this._paddingTop - this._paddingBottom - this.content.height) / 2;
                }
            }
            return;
        }

        protected function fontStyles_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function contentLabelProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:String):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public static const HORIZONTAL_ALIGN_LEFT:String="left";

        public static const HORIZONTAL_ALIGN_CENTER:String="center";

        public static const HORIZONTAL_ALIGN_RIGHT:String="right";

        public static const HORIZONTAL_ALIGN_JUSTIFY:String="justify";

        public static const VERTICAL_ALIGN_TOP:String="top";

        public static const VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const VERTICAL_ALIGN_BOTTOM:String="bottom";

        public static const VERTICAL_ALIGN_JUSTIFY:String="justify";

        public static const DEFAULT_CHILD_STYLE_NAME_CONTENT_LABEL:String="feathers-header-footer-renderer-content-label";

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        protected var _backgroundDisabledSkin:starling.display.DisplayObject;

        protected var content:starling.display.DisplayObject;

        protected var _data:Object;

        protected var _groupIndex:int=-1;

        protected var _layoutIndex:int=-1;

        protected var _paddingTop:Number=0;

        protected var _factoryID:String;

        protected var _horizontalAlign:String="left";

        protected var _paddingRight:Number=0;

        protected var _verticalAlign:String="middle";

        protected var _contentField:String="content";

        protected var _contentFunction:Function;

        protected var _contentSourceField:String="source";

        protected var _contentSourceFunction:Function;

        protected var _paddingLeft:Number=0;

        protected var _contentLabelField:String="label";

        protected var _contentLabelFunction:Function;

        protected var _fontStylesSet:feathers.text.FontStylesSet;

        protected var _contentLabelFactory:Function;

        protected var _customContentLabelStyleName:String;

        protected var _contentLabelProperties:feathers.core.PropertyProxy;

        protected var _owner:feathers.controls.GroupedList;

        protected var contentLabelStyleName:String="feathers-header-footer-renderer-content-label";

        protected var _explicitBackgroundWidth:Number;

        protected var _explicitBackgroundHeight:Number;

        protected var _explicitBackgroundMinWidth:Number;

        protected var _contentLoaderFactory:Function;

        protected var _explicitBackgroundMinHeight:Number;

        protected var _explicitBackgroundMaxWidth:Number;

        protected var _explicitBackgroundMaxHeight:Number;

        protected var _explicitContentWidth:Number;

        protected var _explicitContentHeight:Number;

        protected var _explicitContentMinWidth:Number;

        protected var _explicitContentMinHeight:Number;

        protected var _explicitContentMaxWidth:Number;

        protected var _explicitContentMaxHeight:Number;

        protected var currentBackgroundSkin:starling.display.DisplayObject;

        protected var _backgroundSkin:starling.display.DisplayObject;

        protected var contentImage:feathers.controls.ImageLoader;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var contentLabel:feathers.core.ITextRenderer;

        protected var _paddingBottom:Number=0;
    }
}


