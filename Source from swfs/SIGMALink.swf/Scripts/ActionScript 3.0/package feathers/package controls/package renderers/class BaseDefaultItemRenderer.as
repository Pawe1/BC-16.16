//class BaseDefaultItemRenderer
package feathers.controls.renderers 
{
    import feathers.controls.*;
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.text.*;
    import feathers.utils.skins.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.events.*;
    import starling.text.*;
    
    public class BaseDefaultItemRenderer extends feathers.controls.ToggleButton implements feathers.core.IFocusContainer
    {
        public function BaseDefaultItemRenderer()
        {
            this._stateToAccessory = {};
            this._iconLoaderFactory = defaultLoaderFactory;
            this._accessoryLoaderFactory = defaultLoaderFactory;
            this._skinLoaderFactory = defaultLoaderFactory;
            super();
            if (this._iconLabelFontStylesSet === null) 
            {
                this._iconLabelFontStylesSet = new feathers.text.FontStylesSet();
                this._iconLabelFontStylesSet.addEventListener(starling.events.Event.CHANGE, fontStyles_changeHandler);
            }
            if (this._accessoryLabelFontStylesSet === null) 
            {
                this._accessoryLabelFontStylesSet = new feathers.text.FontStylesSet();
                this._accessoryLabelFontStylesSet.addEventListener(starling.events.Event.CHANGE, fontStyles_changeHandler);
            }
            this._explicitIsEnabled = this._isEnabled;
            this.labelStyleName = DEFAULT_CHILD_STYLE_NAME_LABEL;
            this.isFocusEnabled = false;
            this.isQuickHitAreaEnabled = false;
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.itemRenderer_removedFromStageHandler);
            return;
        }

        public function set accessoryLabelFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._accessoryLabelFontStylesSet.format = arg1;
            return;
        }

        public function get accessoryLabelDisabledFontStyles():starling.text.TextFormat
        {
            return this._accessoryLabelFontStylesSet.disabledFormat;
        }

        public function set accessoryLabelDisabledFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._accessoryLabelFontStylesSet.disabledFormat = arg1;
            return;
        }

        public function get accessoryLabelSelectedFontStyles():starling.text.TextFormat
        {
            return this._accessoryLabelFontStylesSet.selectedFormat;
        }

        public function set accessoryLabelSelectedFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._accessoryLabelFontStylesSet.selectedFormat = arg1;
            return;
        }

        public function get isChildFocusEnabled():Boolean
        {
            return this._isEnabled && this._isChildFocusEnabled;
        }

        public function set isChildFocusEnabled(arg1:Boolean):void
        {
            this._isChildFocusEnabled = arg1;
            return;
        }

        public function get accessoryLabelFactory():Function
        {
            return this._accessoryLabelFactory;
        }

        public function set accessoryLabelFactory(arg1:Function):void
        {
            if (this._accessoryLabelFactory == arg1) 
            {
                return;
            }
            this._accessoryLabelFactory = arg1;
            this._accessoryIsFromItem = false;
            this.replaceAccessory(null);
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get accessoryLabelProperties():Object
        {
            if (!this._accessoryLabelProperties) 
            {
                this._accessoryLabelProperties = new feathers.core.PropertyProxy(childProperties_onChange);
            }
            return this._accessoryLabelProperties;
        }

        public function set accessoryLabelProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._accessoryLabelProperties == arg1) 
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
            if (this._accessoryLabelProperties) 
            {
                this._accessoryLabelProperties.removeOnChangeCallback(childProperties_onChange);
            }
            this._accessoryLabelProperties = feathers.core.PropertyProxy(arg1);
            if (this._accessoryLabelProperties) 
            {
                this._accessoryLabelProperties.addOnChangeCallback(childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get skinLoaderFactory():Function
        {
            return this._skinLoaderFactory;
        }

        public function set skinLoaderFactory(arg1:Function):void
        {
            if (this._skinLoaderFactory == arg1) 
            {
                return;
            }
            this._skinLoaderFactory = arg1;
            this._skinIsFromItem = false;
            this.replaceSkin(null);
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public override function dispose():void
        {
            if (this._iconIsFromItem) 
            {
                this.replaceIcon(null);
            }
            if (this._accessoryIsFromItem) 
            {
                this.replaceAccessory(null);
            }
            if (this._skinIsFromItem) 
            {
                this.replaceSkin(null);
            }
            if (this._stateDelayTimer) 
            {
                if (this._stateDelayTimer.running) 
                {
                    this._stateDelayTimer.stop();
                }
                this._stateDelayTimer.removeEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this.stateDelayTimer_timerCompleteHandler);
                this._stateDelayTimer = null;
            }
            super.dispose();
            return;
        }

        public function itemToLabel(arg1:Object):String
        {
            var loc1:*=null;
            if (this._labelFunction === null) 
            {
                if (!(this._labelField === null) && !(arg1 === null) && arg1.hasOwnProperty(this._labelField)) 
                {
                    loc1 = arg1[this._labelField];
                    if (loc1 is String) 
                    {
                        return loc1 as String;
                    }
                    if (loc1 !== null) 
                    {
                        return loc1.toString();
                    }
                }
                else 
                {
                    if (arg1 is String) 
                    {
                        return arg1 as String;
                    }
                    if (arg1 !== null) 
                    {
                        return arg1.toString();
                    }
                }
            }
            else 
            {
                loc1 = this._labelFunction(arg1);
                if (loc1 is String) 
                {
                    return loc1 as String;
                }
                if (loc1 !== null) 
                {
                    return loc1.toString();
                }
            }
            return null;
        }

        protected function itemToIcon(arg1:Object):starling.display.DisplayObject
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._iconSourceFunction != null) 
            {
                loc1 = this._iconSourceFunction(arg1);
                this.refreshIconSource(loc1);
                return this.iconLoader;
            }
            if (!(this._iconSourceField == null) && arg1 && arg1.hasOwnProperty(this._iconSourceField)) 
            {
                loc1 = arg1[this._iconSourceField];
                this.refreshIconSource(loc1);
                return this.iconLoader;
            }
            if (this._iconLabelFunction != null) 
            {
                loc2 = this._iconLabelFunction(arg1);
                if (loc2 is String) 
                {
                    this.refreshIconLabel(loc2 as String);
                }
                else 
                {
                    this.refreshIconLabel(loc2.toString());
                }
                return starling.display.DisplayObject(this.iconLabel);
            }
            if (!(this._iconLabelField == null) && arg1 && arg1.hasOwnProperty(this._iconLabelField)) 
            {
                loc2 = arg1[this._iconLabelField];
                if (loc2 is String) 
                {
                    this.refreshIconLabel(loc2 as String);
                }
                else 
                {
                    this.refreshIconLabel(loc2.toString());
                }
                return starling.display.DisplayObject(this.iconLabel);
            }
            if (this._iconFunction != null) 
            {
                return this._iconFunction(arg1) as starling.display.DisplayObject;
            }
            if (!(this._iconField == null) && arg1 && arg1.hasOwnProperty(this._iconField)) 
            {
                return arg1[this._iconField] as starling.display.DisplayObject;
            }
            return null;
        }

        public override function set defaultIcon(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._defaultIcon === arg1) 
            {
                return;
            }
            this.replaceIcon(null);
            this._iconIsFromItem = false;
            super.defaultIcon = arg1;
            return;
        }

        public override function set defaultSkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._defaultSkin === arg1) 
            {
                return;
            }
            this.replaceSkin(null);
            this._skinIsFromItem = false;
            super.defaultSkin = arg1;
            return;
        }

        protected function itemToAccessory(arg1:Object):starling.display.DisplayObject
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._accessorySourceFunction != null) 
            {
                loc1 = this._accessorySourceFunction(arg1);
                this.refreshAccessorySource(loc1);
                return this.accessoryLoader;
            }
            if (!(this._accessorySourceField == null) && arg1 && arg1.hasOwnProperty(this._accessorySourceField)) 
            {
                loc1 = arg1[this._accessorySourceField];
                this.refreshAccessorySource(loc1);
                return this.accessoryLoader;
            }
            if (this._accessoryLabelFunction != null) 
            {
                loc2 = this._accessoryLabelFunction(arg1);
                if (loc2 is String) 
                {
                    this.refreshAccessoryLabel(loc2 as String);
                }
                else 
                {
                    this.refreshAccessoryLabel(loc2.toString());
                }
                return starling.display.DisplayObject(this.accessoryLabel);
            }
            if (!(this._accessoryLabelField == null) && arg1 && arg1.hasOwnProperty(this._accessoryLabelField)) 
            {
                loc2 = arg1[this._accessoryLabelField];
                if (loc2 is String) 
                {
                    this.refreshAccessoryLabel(loc2 as String);
                }
                else 
                {
                    this.refreshAccessoryLabel(loc2.toString());
                }
                return starling.display.DisplayObject(this.accessoryLabel);
            }
            if (this._accessoryFunction != null) 
            {
                return this._accessoryFunction(arg1) as starling.display.DisplayObject;
            }
            if (!(this._accessoryField == null) && arg1 && arg1.hasOwnProperty(this._accessoryField)) 
            {
                return arg1[this._accessoryField] as starling.display.DisplayObject;
            }
            return null;
        }

        public function get data():Object
        {
            return this._data;
        }

        public function set data(arg1:Object):void
        {
            if (this._data === arg1) 
            {
                return;
            }
            this._data = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            this.dispatchEventWith("dataChange");
            return;
        }

        protected function itemToSkin(arg1:Object):starling.display.DisplayObject
        {
            var loc1:*=null;
            if (this._skinSourceFunction != null) 
            {
                loc1 = this._skinSourceFunction(arg1);
                this.refreshSkinSource(loc1);
                return this.skinLoader;
            }
            if (!(this._skinSourceField == null) && arg1 && arg1.hasOwnProperty(this._skinSourceField)) 
            {
                loc1 = arg1[this._skinSourceField];
                this.refreshSkinSource(loc1);
                return this.skinLoader;
            }
            if (this._skinFunction != null) 
            {
                return this._skinFunction(arg1) as starling.display.DisplayObject;
            }
            if (!(this._skinField == null) && arg1 && arg1.hasOwnProperty(this._skinField)) 
            {
                return arg1[this._skinField] as starling.display.DisplayObject;
            }
            return null;
        }

        protected function itemToSelectable(arg1:Object):Boolean
        {
            if (this._selectableFunction != null) 
            {
                return this._selectableFunction(arg1) as Boolean;
            }
            if (!(this._selectableField == null) && arg1 && arg1.hasOwnProperty(this._selectableField)) 
            {
                return arg1[this._selectableField] as Boolean;
            }
            return true;
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

        protected function itemToEnabled(arg1:Object):Boolean
        {
            if (this._enabledFunction != null) 
            {
                return this._enabledFunction(arg1) as Boolean;
            }
            if (!(this._enabledField == null) && arg1 && arg1.hasOwnProperty(this._enabledField)) 
            {
                return arg1[this._enabledField] as Boolean;
            }
            return true;
        }

        public function getIconLabelFontStylesForState(arg1:String):starling.text.TextFormat
        {
            if (this._iconLabelFontStylesSet === null) 
            {
                return null;
            }
            return this._iconLabelFontStylesSet.getFormatForState(arg1);
        }

        public function setIconLabelFontStylesForState(arg1:String, arg2:starling.text.TextFormat):void
        {
            this._iconLabelFontStylesSet.setFormatForState(arg1, arg2);
            return;
        }

        public function get useStateDelayTimer():Boolean
        {
            return this._useStateDelayTimer;
        }

        public function set useStateDelayTimer(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._useStateDelayTimer = arg1;
            return;
        }

        public function getAccessoryLabelFontStylesForState(arg1:String):starling.text.TextFormat
        {
            if (this._accessoryLabelFontStylesSet === null) 
            {
                return null;
            }
            return this._accessoryLabelFontStylesSet.getFormatForState(arg1);
        }

        public function setAccessoryLabelFontStylesForState(arg1:String, arg2:starling.text.TextFormat):void
        {
            this._accessoryLabelFontStylesSet.setFormatForState(arg1, arg2);
            return;
        }

        public function get itemHasLabel():Boolean
        {
            return this._itemHasLabel;
        }

        public function set itemHasLabel(arg1:Boolean):void
        {
            if (this._itemHasLabel == arg1) 
            {
                return;
            }
            this._itemHasLabel = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function getAccessoryForState(arg1:String):starling.display.DisplayObject
        {
            return this._stateToAccessory[arg1] as starling.display.DisplayObject;
        }

        public function get itemHasIcon():Boolean
        {
            return this._itemHasIcon;
        }

        public function set itemHasIcon(arg1:Boolean):void
        {
            if (this._itemHasIcon == arg1) 
            {
                return;
            }
            this._itemHasIcon = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function setAccessoryForState(arg1:String, arg2:starling.display.DisplayObject):void
        {
            if (arg2 === null) 
            {
                delete this._stateToAccessory[arg1];
            }
            else 
            {
                this._stateToAccessory[arg1] = arg2;
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get itemHasAccessory():Boolean
        {
            return this._itemHasAccessory;
        }

        public function set itemHasAccessory(arg1:Boolean):void
        {
            if (this._itemHasAccessory == arg1) 
            {
                return;
            }
            this._itemHasAccessory = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected override function initialize():void
        {
            super.initialize();
            this.tapToTrigger.customHitTest = this.hitTestWithAccessory;
            this.tapToSelect.customHitTest = this.hitTestWithAccessory;
            this.longPress.customHitTest = this.hitTestWithAccessory;
            return;
        }

        public function get itemHasSkin():Boolean
        {
            return this._itemHasSkin;
        }

        public function set itemHasSkin(arg1:Boolean):void
        {
            if (this._itemHasSkin == arg1) 
            {
                return;
            }
            this._itemHasSkin = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            if (loc2) 
            {
                this.commitData();
            }
            if (loc1 || loc2 || loc3) 
            {
                this.refreshAccessory();
            }
            super.draw();
            return;
        }

        public function get itemHasSelectable():Boolean
        {
            return this._itemHasSelectable;
        }

        public function set itemHasSelectable(arg1:Boolean):void
        {
            if (this._itemHasSelectable == arg1) 
            {
                return;
            }
            this._itemHasSelectable = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected override function autoSizeIfNeeded():Boolean
        {
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            var loc5:*=this._ignoreAccessoryResizes;
            this._ignoreAccessoryResizes = true;
            var loc6:*=null;
            if (!(this._label === null) && !(this.labelTextRenderer === null)) 
            {
                loc6 = this.labelTextRenderer;
                this.refreshLabelTextRendererDimensions(true);
                this.labelTextRenderer.measureText(HELPER_POINT);
            }
            feathers.utils.skins.resetFluidChildDimensionsForMeasurement(this.currentSkin, this._explicitWidth, this._explicitHeight, this._explicitMinWidth, this._explicitMinHeight, this._explicitMaxWidth, this._explicitMaxHeight, this._explicitSkinWidth, this._explicitSkinHeight, this._explicitSkinMinWidth, this._explicitSkinMinHeight, this._explicitSkinMaxWidth, this._explicitSkinMaxHeight);
            var loc7:*=this.currentSkin as feathers.core.IMeasureDisplayObject;
            var loc8:*=this._explicitWidth;
            if (loc1) 
            {
                if (loc6 === null) 
                {
                    loc8 = 0;
                }
                else 
                {
                    loc8 = HELPER_POINT.x;
                }
                if (this._layoutOrder !== feathers.controls.ItemRendererLayoutOrder.LABEL_ACCESSORY_ICON) 
                {
                    loc8 = this.addIconWidth(loc8);
                    loc8 = this.addAccessoryWidth(loc8);
                }
                else 
                {
                    loc8 = this.addAccessoryWidth(loc8);
                    loc8 = this.addIconWidth(loc8);
                }
                loc8 = loc8 + (this._paddingLeft + this._paddingRight);
                if (!(this.currentSkin === null) && this.currentSkin.width > loc8) 
                {
                    loc8 = this.currentSkin.width;
                }
            }
            var loc9:*=this._explicitHeight;
            if (loc2) 
            {
                if (loc6 === null) 
                {
                    loc9 = 0;
                }
                else 
                {
                    loc9 = HELPER_POINT.y;
                }
                if (this._layoutOrder !== feathers.controls.ItemRendererLayoutOrder.LABEL_ACCESSORY_ICON) 
                {
                    loc9 = this.addIconHeight(loc9);
                    loc9 = this.addAccessoryHeight(loc9);
                }
                else 
                {
                    loc9 = this.addAccessoryHeight(loc9);
                    loc9 = this.addIconHeight(loc9);
                }
                loc9 = loc9 + (this._paddingTop + this._paddingBottom);
                if (!(this.currentSkin === null) && this.currentSkin.height > loc9) 
                {
                    loc9 = this.currentSkin.height;
                }
            }
            var loc10:*=this._explicitMinWidth;
            if (loc3) 
            {
                if (loc6 === null) 
                {
                    loc10 = 0;
                }
                else 
                {
                    loc10 = HELPER_POINT.x;
                }
                if (this._layoutOrder !== feathers.controls.ItemRendererLayoutOrder.LABEL_ACCESSORY_ICON) 
                {
                    loc10 = this.addIconWidth(loc10);
                    loc10 = this.addAccessoryWidth(loc10);
                }
                else 
                {
                    loc10 = this.addAccessoryWidth(loc10);
                    loc10 = this.addIconWidth(loc10);
                }
                loc10 = loc10 + (this._paddingLeft + this._paddingRight);
                if (this.currentSkin !== null) 
                {
                    if (loc7 === null) 
                    {
                        if (this._explicitSkinMinWidth > loc10) 
                        {
                            loc10 = this._explicitSkinMinWidth;
                        }
                    }
                    else if (loc7.minWidth > loc10) 
                    {
                        loc10 = loc7.minWidth;
                    }
                }
            }
            var loc11:*=this._explicitMinHeight;
            if (loc4) 
            {
                if (loc6 === null) 
                {
                    loc11 = 0;
                }
                else 
                {
                    loc11 = HELPER_POINT.y;
                }
                if (this._layoutOrder !== feathers.controls.ItemRendererLayoutOrder.LABEL_ACCESSORY_ICON) 
                {
                    loc11 = this.addIconHeight(loc11);
                    loc11 = this.addAccessoryHeight(loc11);
                }
                else 
                {
                    loc11 = this.addAccessoryHeight(loc11);
                    loc11 = this.addIconHeight(loc11);
                }
                loc11 = loc11 + (this._paddingTop + this._paddingBottom);
                if (this.currentSkin !== null) 
                {
                    if (loc7 === null) 
                    {
                        if (this._explicitSkinMinHeight > loc11) 
                        {
                            loc11 = this._explicitSkinMinHeight;
                        }
                    }
                    else if (loc7.minHeight > loc11) 
                    {
                        loc11 = loc7.minHeight;
                    }
                }
            }
            this._ignoreAccessoryResizes = loc5;
            return this.saveMeasurements(loc8, loc9, loc10, loc11);
        }

        public function get itemHasEnabled():Boolean
        {
            return this._itemHasEnabled;
        }

        public function set itemHasEnabled(arg1:Boolean):void
        {
            if (this._itemHasEnabled == arg1) 
            {
                return;
            }
            this._itemHasEnabled = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected override function changeState(arg1:String):void
        {
            if (this._isEnabled && !this._isToggle && (!this.isSelectableWithoutToggle || this._itemHasSelectable && !this.itemToSelectable(this._data))) 
            {
                arg1 = feathers.controls.ButtonState.UP;
            }
            if (this._useStateDelayTimer) 
            {
                if (this._stateDelayTimer && this._stateDelayTimer.running) 
                {
                    this._delayedCurrentState = arg1;
                    return;
                }
                if (arg1 == feathers.controls.ButtonState.DOWN) 
                {
                    if (this._currentState === arg1) 
                    {
                        return;
                    }
                    this._delayedCurrentState = arg1;
                    if (this._stateDelayTimer) 
                    {
                        this._stateDelayTimer.reset();
                    }
                    else 
                    {
                        this._stateDelayTimer = new flash.utils.Timer(DOWN_STATE_DELAY_MS, 1);
                        this._stateDelayTimer.addEventListener(flash.events.TimerEvent.TIMER_COMPLETE, this.stateDelayTimer_timerCompleteHandler);
                    }
                    this._stateDelayTimer.start();
                    return;
                }
            }
            super.changeState(arg1);
            return;
        }

        public function get accessoryPosition():String
        {
            return this._accessoryPosition;
        }

        public function set accessoryPosition(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._accessoryPosition === arg1) 
            {
                return;
            }
            this._accessoryPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function addIconWidth(arg1:Number):Number
        {
            var loc3:*=NaN;
            if (!this.currentIcon) 
            {
                return arg1;
            }
            var loc1:*=this.currentIcon.width;
            if (loc1 !== loc1) 
            {
                return arg1;
            }
            var loc2:*=arg1 === arg1;
            if (!loc2) 
            {
                arg1 = 0;
            }
            if (this._iconPosition == feathers.layout.RelativePosition.LEFT || this._iconPosition == feathers.layout.RelativePosition.LEFT_BASELINE || this._iconPosition == feathers.layout.RelativePosition.RIGHT || this._iconPosition == feathers.layout.RelativePosition.RIGHT_BASELINE) 
            {
                if (loc2) 
                {
                    loc3 = this._gap;
                    if (this._gap == Number.POSITIVE_INFINITY) 
                    {
                        loc3 = this._minGap;
                    }
                    arg1 = arg1 + loc3;
                }
                arg1 = arg1 + loc1;
            }
            else if (loc1 > arg1) 
            {
                arg1 = loc1;
            }
            return arg1;
        }

        public function get layoutOrder():String
        {
            return this._layoutOrder;
        }

        public function set layoutOrder(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._layoutOrder === arg1) 
            {
                return;
            }
            this._layoutOrder = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function addAccessoryWidth(arg1:Number):Number
        {
            var loc3:*=NaN;
            if (!this.currentAccessory) 
            {
                return arg1;
            }
            var loc1:*=this.currentAccessory.width;
            if (loc1 !== loc1) 
            {
                return arg1;
            }
            var loc2:*=arg1 === arg1;
            if (!loc2) 
            {
                arg1 = 0;
            }
            if (this._accessoryPosition == feathers.layout.RelativePosition.LEFT || this._accessoryPosition == feathers.layout.RelativePosition.RIGHT) 
            {
                if (loc2) 
                {
                    loc3 = this._accessoryGap;
                    if (this._accessoryGap !== this._accessoryGap) 
                    {
                        loc3 = this._gap;
                    }
                    if (loc3 == Number.POSITIVE_INFINITY) 
                    {
                        if (this._minAccessoryGap === this._minAccessoryGap) 
                        {
                            loc3 = this._minAccessoryGap;
                        }
                        else 
                        {
                            loc3 = this._minGap;
                        }
                    }
                    arg1 = arg1 + loc3;
                }
                arg1 = arg1 + loc1;
            }
            else if (loc1 > arg1) 
            {
                arg1 = loc1;
            }
            return arg1;
        }

        public function get accessoryOffsetX():Number
        {
            return this._accessoryOffsetX;
        }

        public function set accessoryOffsetX(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._accessoryOffsetX === arg1) 
            {
                return;
            }
            this._accessoryOffsetX = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function addIconHeight(arg1:Number):Number
        {
            var loc3:*=NaN;
            if (this.currentIcon === null) 
            {
                return arg1;
            }
            var loc1:*=this.currentIcon.height;
            if (loc1 !== loc1) 
            {
                return arg1;
            }
            var loc2:*=arg1 === arg1;
            if (!loc2) 
            {
                arg1 = 0;
            }
            if (this._iconPosition === feathers.layout.RelativePosition.TOP || this._iconPosition === feathers.layout.RelativePosition.BOTTOM) 
            {
                if (loc2) 
                {
                    loc3 = this._gap;
                    if (this._gap === Number.POSITIVE_INFINITY) 
                    {
                        loc3 = this._minGap;
                    }
                    arg1 = arg1 + loc3;
                }
                arg1 = arg1 + loc1;
            }
            else if (loc1 > arg1) 
            {
                arg1 = loc1;
            }
            return arg1;
        }

        public function get accessoryOffsetY():Number
        {
            return this._accessoryOffsetY;
        }

        public function set accessoryOffsetY(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._accessoryOffsetY === arg1) 
            {
                return;
            }
            this._accessoryOffsetY = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function addAccessoryHeight(arg1:Number):Number
        {
            var loc3:*=NaN;
            if (this.currentAccessory === null) 
            {
                return arg1;
            }
            var loc1:*=this.currentAccessory.height;
            if (loc1 !== loc1) 
            {
                return arg1;
            }
            var loc2:*=arg1 === arg1;
            if (!loc2) 
            {
                arg1 = 0;
            }
            if (this._accessoryPosition === feathers.layout.RelativePosition.TOP || this._accessoryPosition === feathers.layout.RelativePosition.BOTTOM) 
            {
                if (loc2) 
                {
                    loc3 = this._accessoryGap;
                    if (this._accessoryGap !== this._accessoryGap) 
                    {
                        loc3 = this._gap;
                    }
                    if (loc3 === Number.POSITIVE_INFINITY) 
                    {
                        if (this._minAccessoryGap === this._minAccessoryGap) 
                        {
                            loc3 = this._minAccessoryGap;
                        }
                        else 
                        {
                            loc3 = this._minGap;
                        }
                    }
                    arg1 = arg1 + loc3;
                }
                arg1 = arg1 + loc1;
            }
            else if (loc1 > arg1) 
            {
                arg1 = loc1;
            }
            return arg1;
        }

        public function get accessoryGap():Number
        {
            return this._accessoryGap;
        }

        public function set accessoryGap(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._accessoryGap === arg1) 
            {
                return;
            }
            this._accessoryGap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function commitData():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (!(this._data === null) && this._owner) 
            {
                if (this._itemHasLabel) 
                {
                    this._label = this.itemToLabel(this._data);
                }
                if (this._itemHasSkin) 
                {
                    loc1 = this.itemToSkin(this._data);
                    this._skinIsFromItem = !(loc1 == null);
                    this.replaceSkin(loc1);
                }
                else if (this._skinIsFromItem) 
                {
                    this._skinIsFromItem = false;
                    this.replaceSkin(null);
                }
                if (this._itemHasIcon) 
                {
                    loc2 = this.itemToIcon(this._data);
                    this._iconIsFromItem = !(loc2 == null);
                    this.replaceIcon(loc2);
                }
                else if (this._iconIsFromItem) 
                {
                    this._iconIsFromItem = false;
                    this.replaceIcon(null);
                }
                if (this._itemHasAccessory) 
                {
                    loc3 = this.itemToAccessory(this._data);
                    this._accessoryIsFromItem = !(loc3 == null);
                    this.replaceAccessory(loc3);
                }
                else if (this._accessoryIsFromItem) 
                {
                    this._accessoryIsFromItem = false;
                    this.replaceAccessory(null);
                }
                if (this._itemHasSelectable) 
                {
                    this._isToggle = this._explicitIsToggle && this.itemToSelectable(this._data);
                }
                else 
                {
                    this._isToggle = this._explicitIsToggle;
                }
                if (this._itemHasEnabled) 
                {
                    this.refreshIsEnabled(this._explicitIsEnabled && this.itemToEnabled(this._data));
                }
                else 
                {
                    this.refreshIsEnabled(this._explicitIsEnabled);
                }
            }
            else 
            {
                if (this._itemHasLabel) 
                {
                    this._label = "";
                }
                if (this._itemHasIcon || this._iconIsFromItem) 
                {
                    this._iconIsFromItem = false;
                    this.replaceIcon(null);
                }
                if (this._itemHasSkin || this._skinIsFromItem) 
                {
                    this._skinIsFromItem = false;
                    this.replaceSkin(null);
                }
                if (this._itemHasAccessory || this._accessoryIsFromItem) 
                {
                    this._accessoryIsFromItem = false;
                    this.replaceAccessory(null);
                }
                if (this._itemHasSelectable) 
                {
                    this._isToggle = this._explicitIsToggle;
                }
                if (this._itemHasEnabled) 
                {
                    this.refreshIsEnabled(this._explicitIsEnabled);
                }
            }
            return;
        }

        public function get minAccessoryGap():Number
        {
            return this._minAccessoryGap;
        }

        public function set minAccessoryGap(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._minAccessoryGap === arg1) 
            {
                return;
            }
            this._minAccessoryGap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshIsEnabled(arg1:Boolean):void
        {
            if (this._isEnabled == arg1) 
            {
                return;
            }
            this._isEnabled = arg1;
            if (this._isEnabled) 
            {
                if (this._currentState == feathers.controls.ButtonState.DISABLED) 
                {
                    this._currentState = feathers.controls.ButtonState.UP;
                }
                this.touchable = true;
            }
            else 
            {
                this.touchable = false;
                this._currentState = feathers.controls.ButtonState.DISABLED;
                this.touchPointID = -1;
            }
            this.setInvalidationFlag(INVALIDATION_FLAG_STATE);
            this.dispatchEventWith(feathers.events.FeathersEventType.STATE_CHANGE);
            return;
        }

        public function get defaultAccessory():starling.display.DisplayObject
        {
            return this._defaultAccessory;
        }

        public function set defaultAccessory(arg1:starling.display.DisplayObject):void
        {
            if (this._defaultAccessory === arg1) 
            {
                return;
            }
            this.replaceAccessory(null);
            this._accessoryIsFromItem = false;
            this._defaultAccessory = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function replaceIcon(arg1:starling.display.DisplayObject):void
        {
            if (this.iconLoader && !(this.iconLoader == arg1)) 
            {
                this.iconLoader.removeEventListener(starling.events.Event.COMPLETE, this.loader_completeOrErrorHandler);
                this.iconLoader.removeEventListener(feathers.events.FeathersEventType.ERROR, this.loader_completeOrErrorHandler);
                this.iconLoader.dispose();
                this.iconLoader = null;
            }
            if (this.iconLabel && !(this.iconLabel == arg1)) 
            {
                this.iconLabel.dispose();
                this.iconLabel = null;
            }
            if (this._itemHasIcon && this.currentIcon && !(this.currentIcon == arg1) && this.currentIcon.parent == this) 
            {
                this.currentIcon.removeFromParent(false);
                this.currentIcon = null;
            }
            if (this._defaultIcon !== arg1) 
            {
                this._defaultIcon = arg1;
                this._stateToIconFunction = null;
                this.setInvalidationFlag(INVALIDATION_FLAG_STYLES);
            }
            if (this.iconLoader) 
            {
                this.iconLoader.delayTextureCreation = this._delayTextureCreationOnScroll && this._owner.isScrolling;
            }
            return;
        }

        protected function replaceAccessory(arg1:starling.display.DisplayObject):void
        {
            if (this.accessoryLoader && !(this.accessoryLoader == arg1)) 
            {
                this.accessoryLoader.removeEventListener(starling.events.Event.COMPLETE, this.loader_completeOrErrorHandler);
                this.accessoryLoader.removeEventListener(feathers.events.FeathersEventType.ERROR, this.loader_completeOrErrorHandler);
                this.accessoryLoader.dispose();
                this.accessoryLoader = null;
            }
            if (this.accessoryLabel && !(this.accessoryLabel == arg1)) 
            {
                this.accessoryLabel.dispose();
                this.accessoryLabel = null;
            }
            if (this._itemHasAccessory && this.currentAccessory && !(this.currentAccessory == arg1) && this.currentAccessory.parent == this) 
            {
                this.currentAccessory.removeFromParent(false);
                this.currentAccessory = null;
            }
            if (this._defaultAccessory !== arg1) 
            {
                this._defaultAccessory = arg1;
                this._stateToAccessoryFunction = null;
                this.setInvalidationFlag(INVALIDATION_FLAG_STYLES);
            }
            if (this.accessoryLoader) 
            {
                this.accessoryLoader.delayTextureCreation = this._delayTextureCreationOnScroll && this._owner.isScrolling;
            }
            return;
        }

        public function get stateToAccessoryFunction():Function
        {
            return this._stateToAccessoryFunction;
        }

        public function set stateToAccessoryFunction(arg1:Function):void
        {
            if (this._stateToAccessoryFunction == arg1) 
            {
                return;
            }
            this._stateToAccessoryFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function replaceSkin(arg1:starling.display.DisplayObject):void
        {
            if (this.skinLoader && !(this.skinLoader == arg1)) 
            {
                this.skinLoader.removeEventListener(starling.events.Event.COMPLETE, this.loader_completeOrErrorHandler);
                this.skinLoader.removeEventListener(feathers.events.FeathersEventType.ERROR, this.loader_completeOrErrorHandler);
                this.skinLoader.dispose();
                this.skinLoader = null;
            }
            if (this._itemHasSkin && this.currentSkin && !(this.currentSkin == arg1) && this.currentSkin.parent == this) 
            {
                this.currentSkin.removeFromParent(false);
                this.currentSkin = null;
            }
            if (this._defaultSkin !== arg1) 
            {
                this._defaultSkin = arg1;
                this._stateToSkinFunction = null;
                this.setInvalidationFlag(INVALIDATION_FLAG_STYLES);
            }
            if (this.skinLoader) 
            {
                this.skinLoader.delayTextureCreation = this._delayTextureCreationOnScroll && this._owner.isScrolling;
            }
            return;
        }

        protected override function refreshIcon():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            super.refreshIcon();
            if (this.iconLabel !== null) 
            {
                this.iconLabel.fontStyles = this._iconLabelFontStylesSet;
                loc1 = starling.display.DisplayObject(this.iconLabel);
                var loc4:*=0;
                var loc5:*=this._iconLabelProperties;
                for (loc2 in loc5) 
                {
                    loc3 = this._iconLabelProperties[loc2];
                    loc1[loc2] = loc3;
                }
            }
            return;
        }

        public function get stopScrollingOnAccessoryTouch():Boolean
        {
            return this._stopScrollingOnAccessoryTouch;
        }

        public function set stopScrollingOnAccessoryTouch(arg1:Boolean):void
        {
            this._stopScrollingOnAccessoryTouch = arg1;
            return;
        }

        protected function refreshAccessory():void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc1:*=this.currentAccessory;
            this.currentAccessory = this.getCurrentAccessory();
            if (this.currentAccessory is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this.currentAccessory).isEnabled = this._isEnabled;
            }
            if (this.currentAccessory != loc1) 
            {
                if (loc1) 
                {
                    if (loc1 is feathers.core.IStateObserver) 
                    {
                        feathers.core.IStateObserver(loc1).stateContext = null;
                    }
                    if (loc1 is feathers.core.IFeathersControl) 
                    {
                        feathers.core.IFeathersControl(loc1).removeEventListener(feathers.events.FeathersEventType.RESIZE, this.accessory_resizeHandler);
                        feathers.core.IFeathersControl(loc1).removeEventListener(starling.events.TouchEvent.TOUCH, this.accessory_touchHandler);
                    }
                    this.removeChild(loc1, false);
                }
                if (this.currentAccessory) 
                {
                    if (this.currentAccessory is feathers.core.IStateObserver) 
                    {
                        feathers.core.IStateObserver(this.currentAccessory).stateContext = this;
                    }
                    this.addChild(this.currentAccessory);
                    if (this.currentAccessory is feathers.core.IFeathersControl) 
                    {
                        feathers.core.IFeathersControl(this.currentAccessory).addEventListener(feathers.events.FeathersEventType.RESIZE, this.accessory_resizeHandler);
                        feathers.core.IFeathersControl(this.currentAccessory).addEventListener(starling.events.TouchEvent.TOUCH, this.accessory_touchHandler);
                    }
                }
            }
            if (this.accessoryLabel !== null) 
            {
                this.accessoryLabel.fontStyles = this._accessoryLabelFontStylesSet;
                loc2 = starling.display.DisplayObject(this.accessoryLabel);
                var loc5:*=0;
                var loc6:*=this._accessoryLabelProperties;
                for (loc3 in loc6) 
                {
                    loc4 = this._accessoryLabelProperties[loc3];
                    loc2[loc3] = loc4;
                }
            }
            return;
        }

        public function get isSelectableOnAccessoryTouch():Boolean
        {
            return this._isSelectableOnAccessoryTouch;
        }

        public function set isSelectableOnAccessoryTouch(arg1:Boolean):void
        {
            this._isSelectableOnAccessoryTouch = arg1;
            return;
        }

        protected function getCurrentAccessory():starling.display.DisplayObject
        {
            if (this._stateToAccessoryFunction !== null) 
            {
                return starling.display.DisplayObject(this._stateToAccessoryFunction(this, this._currentState, this.currentAccessory));
            }
            var loc1:*=this._stateToAccessory[this.currentState] as starling.display.DisplayObject;
            if (loc1 !== null) 
            {
                return loc1;
            }
            return this._defaultAccessory;
        }

        public function get delayTextureCreationOnScroll():Boolean
        {
            return this._delayTextureCreationOnScroll;
        }

        public function set delayTextureCreationOnScroll(arg1:Boolean):void
        {
            this._delayTextureCreationOnScroll = arg1;
            return;
        }

        protected function refreshIconSource(arg1:Object):void
        {
            var loc1:*=null;
            if (!this.iconLoader) 
            {
                this.iconLoader = this._iconLoaderFactory();
                this.iconLoader.addEventListener(starling.events.Event.COMPLETE, this.loader_completeOrErrorHandler);
                this.iconLoader.addEventListener(feathers.events.FeathersEventType.ERROR, this.loader_completeOrErrorHandler);
                loc1 = this._customIconLoaderStyleName == null ? this.iconLoaderStyleName : this._customIconLoaderStyleName;
                this.iconLoader.styleNameList.add(loc1);
            }
            this.iconLoader.source = arg1;
            return;
        }

        public function get labelField():String
        {
            return this._labelField;
        }

        public function set labelField(arg1:String):void
        {
            if (this._labelField == arg1) 
            {
                return;
            }
            this._labelField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function refreshIconLabel(arg1:String):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.iconLabel === null) 
            {
                loc1 = this._iconLabelFactory == null ? feathers.core.FeathersControl.defaultTextRendererFactory : this._iconLabelFactory;
                this.iconLabel = feathers.core.ITextRenderer(loc1());
                if (this.iconLabel is feathers.core.IStateObserver) 
                {
                    feathers.core.IStateObserver(this.iconLabel).stateContext = this;
                }
                loc2 = this._customIconLabelStyleName == null ? this.iconLabelStyleName : this._customIconLabelStyleName;
                this.iconLabel.styleNameList.add(loc2);
            }
            this.iconLabel.text = arg1;
            return;
        }

        public function get labelFunction():Function
        {
            return this._labelFunction;
        }

        public function set labelFunction(arg1:Function):void
        {
            if (this._labelFunction == arg1) 
            {
                return;
            }
            this._labelFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function refreshAccessorySource(arg1:Object):void
        {
            var loc1:*=null;
            if (!this.accessoryLoader) 
            {
                this.accessoryLoader = this._accessoryLoaderFactory();
                this.accessoryLoader.addEventListener(starling.events.Event.COMPLETE, this.loader_completeOrErrorHandler);
                this.accessoryLoader.addEventListener(feathers.events.FeathersEventType.ERROR, this.loader_completeOrErrorHandler);
                loc1 = this._customAccessoryLoaderStyleName == null ? this.accessoryLoaderStyleName : this._customAccessoryLoaderStyleName;
                this.accessoryLoader.styleNameList.add(loc1);
            }
            this.accessoryLoader.source = arg1;
            return;
        }

        public function get iconField():String
        {
            return this._iconField;
        }

        public function set iconField(arg1:String):void
        {
            if (this._iconField == arg1) 
            {
                return;
            }
            this._iconField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function refreshAccessoryLabel(arg1:String):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this.accessoryLabel === null) 
            {
                loc1 = this._accessoryLabelFactory == null ? feathers.core.FeathersControl.defaultTextRendererFactory : this._accessoryLabelFactory;
                this.accessoryLabel = feathers.core.ITextRenderer(loc1());
                if (this.accessoryLabel is feathers.core.IStateObserver) 
                {
                    feathers.core.IStateObserver(this.accessoryLabel).stateContext = this;
                }
                loc2 = this._customAccessoryLabelStyleName == null ? this.accessoryLabelStyleName : this._customAccessoryLabelStyleName;
                this.accessoryLabel.styleNameList.add(loc2);
            }
            this.accessoryLabel.text = arg1;
            return;
        }

        public function get iconFunction():Function
        {
            return this._iconFunction;
        }

        public function set iconFunction(arg1:Function):void
        {
            if (this._iconFunction == arg1) 
            {
                return;
            }
            this._iconFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function refreshSkinSource(arg1:Object):void
        {
            if (!this.skinLoader) 
            {
                this.skinLoader = this._skinLoaderFactory();
                this.skinLoader.addEventListener(starling.events.Event.COMPLETE, this.loader_completeOrErrorHandler);
                this.skinLoader.addEventListener(feathers.events.FeathersEventType.ERROR, this.loader_completeOrErrorHandler);
            }
            this.skinLoader.source = arg1;
            return;
        }

        public function get iconSourceField():String
        {
            return this._iconSourceField;
        }

        public function set iconSourceField(arg1:String):void
        {
            if (this._iconSourceField == arg1) 
            {
                return;
            }
            this._iconSourceField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected override function layoutContent():void
        {
            var loc7:*=null;
            var loc1:*=this._ignoreAccessoryResizes;
            this._ignoreAccessoryResizes = true;
            var loc2:*=this._ignoreIconResizes;
            this._ignoreIconResizes = true;
            this.refreshLabelTextRendererDimensions(false);
            var loc3:*=null;
            if (!(this._label === null) && !(this.labelTextRenderer === null)) 
            {
                loc3 = starling.display.DisplayObject(this.labelTextRenderer);
            }
            var loc4:*=this.currentIcon && !(this._iconPosition == feathers.layout.RelativePosition.MANUAL);
            var loc5:*=this.currentAccessory && !(this._accessoryPosition == feathers.layout.RelativePosition.MANUAL);
            var loc6:*=this._accessoryGap;
            if (loc6 !== loc6) 
            {
                loc6 = this._gap;
            }
            if (loc3 && loc4 && loc5) 
            {
                this.positionSingleChild(loc3);
                if (this._layoutOrder != feathers.controls.ItemRendererLayoutOrder.LABEL_ACCESSORY_ICON) 
                {
                    this.positionLabelAndIcon();
                    this.positionRelativeToOthers(this.currentAccessory, loc3, this.currentIcon, this._accessoryPosition, loc6, this._iconPosition, this._gap);
                }
                else 
                {
                    this.positionRelativeToOthers(this.currentAccessory, loc3, null, this._accessoryPosition, loc6, null, 0);
                    loc7 = this._iconPosition;
                    if (loc7 != feathers.layout.RelativePosition.LEFT_BASELINE) 
                    {
                        if (loc7 == feathers.layout.RelativePosition.RIGHT_BASELINE) 
                        {
                            loc7 = feathers.layout.RelativePosition.RIGHT;
                        }
                    }
                    else 
                    {
                        loc7 = feathers.layout.RelativePosition.LEFT;
                    }
                    this.positionRelativeToOthers(this.currentIcon, loc3, this.currentAccessory, loc7, this._gap, this._accessoryPosition, loc6);
                }
            }
            else if (loc3) 
            {
                this.positionSingleChild(loc3);
                if (loc4) 
                {
                    this.positionLabelAndIcon();
                }
                else if (loc5) 
                {
                    this.positionRelativeToOthers(this.currentAccessory, loc3, null, this._accessoryPosition, loc6, null, 0);
                }
            }
            else if (loc4) 
            {
                this.positionSingleChild(this.currentIcon);
                if (loc5) 
                {
                    this.positionRelativeToOthers(this.currentAccessory, this.currentIcon, null, this._accessoryPosition, loc6, null, 0);
                }
            }
            else if (loc5) 
            {
                this.positionSingleChild(this.currentAccessory);
            }
            if (this.currentAccessory) 
            {
                if (!loc5) 
                {
                    this.currentAccessory.x = this._paddingLeft;
                    this.currentAccessory.y = this._paddingTop;
                }
                this.currentAccessory.x = this.currentAccessory.x + this._accessoryOffsetX;
                this.currentAccessory.y = this.currentAccessory.y + this._accessoryOffsetY;
            }
            if (this.currentIcon) 
            {
                if (!loc4) 
                {
                    this.currentIcon.x = this._paddingLeft;
                    this.currentIcon.y = this._paddingTop;
                }
                this.currentIcon.x = this.currentIcon.x + this._iconOffsetX;
                this.currentIcon.y = this.currentIcon.y + this._iconOffsetY;
            }
            if (loc3) 
            {
                this.labelTextRenderer.x = this.labelTextRenderer.x + this._labelOffsetX;
                this.labelTextRenderer.y = this.labelTextRenderer.y + this._labelOffsetY;
            }
            this._ignoreIconResizes = loc2;
            this._ignoreAccessoryResizes = loc1;
            return;
        }

        public function get iconSourceFunction():Function
        {
            return this._iconSourceFunction;
        }

        public function set iconSourceFunction(arg1:Function):void
        {
            if (this._iconSourceFunction == arg1) 
            {
                return;
            }
            this._iconSourceFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected override function refreshLabelTextRendererDimensions(arg1:Boolean):void
        {
            var loc10:*=false;
            var loc11:*=false;
            var loc1:*=this._ignoreIconResizes;
            this._ignoreIconResizes = true;
            var loc2:*=this.actualWidth;
            if (arg1) 
            {
                loc2 = this._explicitWidth;
                if (loc2 !== loc2) 
                {
                    loc2 = this._explicitMaxWidth;
                }
            }
            loc2 = loc2 - (this._paddingLeft + this._paddingRight);
            var loc3:*=this.actualHeight;
            if (arg1) 
            {
                loc3 = this._explicitHeight;
                if (loc3 !== loc3) 
                {
                    loc3 = this._explicitMaxHeight;
                }
            }
            loc3 = loc3 - (this._paddingTop + this._paddingBottom);
            var loc4:*=this._gap;
            if (loc4 == Number.POSITIVE_INFINITY) 
            {
                loc4 = this._minGap;
            }
            var loc5:*=this._accessoryGap;
            if (loc5 !== loc5) 
            {
                loc5 = this._gap;
            }
            if (loc5 == Number.POSITIVE_INFINITY) 
            {
                loc5 = this._minAccessoryGap;
                if (loc5 !== loc5) 
                {
                    loc5 = this._minGap;
                }
            }
            var loc6:*=this.currentIcon && (this._iconPosition == feathers.layout.RelativePosition.LEFT || this._iconPosition == feathers.layout.RelativePosition.LEFT_BASELINE || this._iconPosition == feathers.layout.RelativePosition.RIGHT || this._iconPosition == feathers.layout.RelativePosition.RIGHT_BASELINE);
            var loc7:*=this.currentIcon && (this._iconPosition == feathers.layout.RelativePosition.TOP || this._iconPosition == feathers.layout.RelativePosition.BOTTOM);
            var loc8:*=this.currentAccessory && (this._accessoryPosition == feathers.layout.RelativePosition.LEFT || this._accessoryPosition == feathers.layout.RelativePosition.RIGHT);
            var loc9:*=this.currentAccessory && (this._accessoryPosition == feathers.layout.RelativePosition.TOP || this._accessoryPosition == feathers.layout.RelativePosition.BOTTOM);
            if (this.accessoryLabel) 
            {
                loc10 = loc6 && (loc8 || this._layoutOrder === feathers.controls.ItemRendererLayoutOrder.LABEL_ACCESSORY_ICON);
                if (this.iconLabel) 
                {
                    this.iconLabel.maxWidth = loc2 - loc4;
                    if (this.iconLabel.maxWidth < 0) 
                    {
                        this.iconLabel.maxWidth = 0;
                    }
                }
                if (this.currentIcon is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this.currentIcon).validate();
                }
                if (loc10) 
                {
                    loc2 = loc2 - (this.currentIcon.width + loc4);
                }
                if (loc2 < 0) 
                {
                    loc2 = 0;
                }
                this.accessoryLabel.maxWidth = loc2;
                this.accessoryLabel.maxHeight = loc3;
                if (loc6 && this.currentIcon && !loc10) 
                {
                    loc2 = loc2 - (this.currentIcon.width + loc4);
                }
                if (this.currentAccessory is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this.currentAccessory).validate();
                }
                if (loc8) 
                {
                    loc2 = loc2 - (this.currentAccessory.width + loc5);
                }
                if (loc9) 
                {
                    loc3 = loc3 - (this.currentAccessory.height + loc5);
                }
            }
            else if (this.iconLabel) 
            {
                loc11 = loc8 && (loc6 || this._layoutOrder === feathers.controls.ItemRendererLayoutOrder.LABEL_ICON_ACCESSORY);
                if (this.currentAccessory is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this.currentAccessory).validate();
                }
                if (loc11) 
                {
                    loc2 = loc2 - (loc5 + this.currentAccessory.width);
                }
                if (loc2 < 0) 
                {
                    loc2 = 0;
                }
                this.iconLabel.maxWidth = loc2;
                this.iconLabel.maxHeight = loc3;
                if (loc8 && this.currentAccessory && !loc11) 
                {
                    loc2 = loc2 - (loc5 + this.currentAccessory.width);
                }
                if (this.currentIcon is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this.currentIcon).validate();
                }
                if (loc6) 
                {
                    loc2 = loc2 - (this.currentIcon.width + loc4);
                }
                if (loc7) 
                {
                    loc3 = loc3 - (this.currentIcon.height + loc4);
                }
            }
            else 
            {
                if (this.currentIcon is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this.currentIcon).validate();
                }
                if (loc6) 
                {
                    loc2 = loc2 - (loc4 + this.currentIcon.width);
                }
                if (loc7) 
                {
                    loc3 = loc3 - (loc4 + this.currentIcon.height);
                }
                if (this.currentAccessory is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this.currentAccessory).validate();
                }
                if (loc8) 
                {
                    loc2 = loc2 - (loc5 + this.currentAccessory.width);
                }
                if (loc9) 
                {
                    loc3 = loc3 - (loc5 + this.currentAccessory.height);
                }
            }
            if (loc2 < 0) 
            {
                loc2 = 0;
            }
            if (loc3 < 0) 
            {
                loc3 = 0;
            }
            if (loc2 > this._explicitLabelMaxWidth) 
            {
                loc2 = this._explicitLabelMaxWidth;
            }
            if (loc3 > this._explicitLabelMaxHeight) 
            {
                loc3 = this._explicitLabelMaxHeight;
            }
            if (this.labelTextRenderer !== null) 
            {
                if (arg1) 
                {
                    this.labelTextRenderer.width = this._explicitLabelWidth;
                    this.labelTextRenderer.height = this._explicitLabelHeight;
                    this.labelTextRenderer.minWidth = this._explicitLabelMinWidth;
                    this.labelTextRenderer.minHeight = this._explicitLabelMinHeight;
                    this.labelTextRenderer.maxWidth = loc2;
                    this.labelTextRenderer.maxHeight = loc3;
                    this.labelTextRenderer.validate();
                }
                else 
                {
                    this.labelTextRenderer.maxWidth = loc2;
                    this.labelTextRenderer.maxHeight = loc3;
                    this.labelTextRenderer.validate();
                    loc2 = this.labelTextRenderer.width;
                    loc3 = this.labelTextRenderer.height;
                    this.labelTextRenderer.width = loc2;
                    this.labelTextRenderer.height = loc3;
                    this.labelTextRenderer.minWidth = loc2;
                    this.labelTextRenderer.minHeight = loc3;
                }
            }
            this._ignoreIconResizes = loc1;
            return;
        }

        public function get iconLabelField():String
        {
            return this._iconLabelField;
        }

        public function set iconLabelField(arg1:String):void
        {
            if (this._iconLabelField == arg1) 
            {
                return;
            }
            this._iconLabelField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function positionRelativeToOthers(arg1:starling.display.DisplayObject, arg2:starling.display.DisplayObject, arg3:starling.display.DisplayObject, arg4:String, arg5:Number, arg6:String, arg7:Number):void
        {
            var loc1:*=arg3 ? Math.min(arg2.x, arg3.x) : arg2.x;
            var loc2:*=arg3 ? Math.min(arg2.y, arg3.y) : arg2.y;
            var loc3:*=arg3 ? Math.max(arg2.x + arg2.width, arg3.x + arg3.width) - loc1 : arg2.width;
            var loc4:*=arg3 ? Math.max(arg2.y + arg2.height, arg3.y + arg3.height) - loc2 : arg2.height;
            var loc5:*=loc1;
            var loc6:*=loc2;
            if (arg4 != feathers.layout.RelativePosition.TOP) 
            {
                if (arg4 != feathers.layout.RelativePosition.RIGHT) 
                {
                    if (arg4 != feathers.layout.RelativePosition.BOTTOM) 
                    {
                        if (arg4 == feathers.layout.RelativePosition.LEFT) 
                        {
                            if (arg5 != Number.POSITIVE_INFINITY) 
                            {
                                if (this._horizontalAlign != feathers.layout.HorizontalAlign.LEFT) 
                                {
                                    if (this._horizontalAlign == feathers.layout.HorizontalAlign.CENTER) 
                                    {
                                        loc5 = loc5 + Math.round((arg5 + arg1.width) / 2);
                                    }
                                }
                                else 
                                {
                                    loc5 = loc5 + (arg5 + arg1.width);
                                }
                                if (arg3) 
                                {
                                    loc5 = Math.max(loc5, this._paddingLeft + arg1.width + arg5);
                                }
                                arg1.x = loc5 - arg5 - arg1.width;
                            }
                            else 
                            {
                                arg1.x = this._paddingLeft;
                                loc5 = this.actualWidth - this._paddingRight - loc3;
                            }
                        }
                    }
                    else if (arg5 != Number.POSITIVE_INFINITY) 
                    {
                        if (this._verticalAlign != feathers.layout.VerticalAlign.BOTTOM) 
                        {
                            if (this._verticalAlign == feathers.layout.VerticalAlign.MIDDLE) 
                            {
                                loc6 = loc6 - Math.round((arg1.height + arg5) / 2);
                            }
                        }
                        else 
                        {
                            loc6 = loc6 - (arg1.height + arg5);
                        }
                        if (arg3) 
                        {
                            loc6 = Math.min(loc6, this.actualHeight - this._paddingBottom - arg1.height - loc4 - arg5);
                        }
                        arg1.y = loc6 + loc4 + arg5;
                    }
                    else 
                    {
                        loc6 = this._paddingTop;
                        arg1.y = this.actualHeight - this._paddingBottom - arg1.height;
                    }
                }
                else if (arg5 != Number.POSITIVE_INFINITY) 
                {
                    if (this._horizontalAlign != feathers.layout.HorizontalAlign.RIGHT) 
                    {
                        if (this._horizontalAlign == feathers.layout.HorizontalAlign.CENTER) 
                        {
                            loc5 = loc5 - Math.round((arg1.width + arg5) / 2);
                        }
                    }
                    else 
                    {
                        loc5 = loc5 - (arg1.width + arg5);
                    }
                    if (arg3) 
                    {
                        loc5 = Math.min(loc5, this.actualWidth - this._paddingRight - arg1.width - loc3 - arg5);
                    }
                    arg1.x = loc5 + loc3 + arg5;
                }
                else 
                {
                    loc5 = this._paddingLeft;
                    arg1.x = this.actualWidth - this._paddingRight - arg1.width;
                }
            }
            else if (arg5 != Number.POSITIVE_INFINITY) 
            {
                if (this._verticalAlign != feathers.layout.VerticalAlign.TOP) 
                {
                    if (this._verticalAlign == feathers.layout.VerticalAlign.MIDDLE) 
                    {
                        loc6 = loc6 + Math.round((arg1.height + arg5) / 2);
                    }
                }
                else 
                {
                    loc6 = loc6 + (arg1.height + arg5);
                }
                if (arg3) 
                {
                    loc6 = Math.max(loc6, this._paddingTop + arg1.height + arg5);
                }
                arg1.y = loc6 - arg1.height - arg5;
            }
            else 
            {
                arg1.y = this._paddingTop;
                loc6 = this.actualHeight - this._paddingBottom - loc4;
            }
            var loc7:*=loc5 - loc1;
            var loc8:*=loc6 - loc2;
            if (!arg3 || !(arg7 == Number.POSITIVE_INFINITY) || !(arg4 == feathers.layout.RelativePosition.TOP && arg6 == feathers.layout.RelativePosition.TOP || arg4 == feathers.layout.RelativePosition.RIGHT && arg6 == feathers.layout.RelativePosition.RIGHT || arg4 == feathers.layout.RelativePosition.BOTTOM && arg6 == feathers.layout.RelativePosition.BOTTOM || arg4 == feathers.layout.RelativePosition.LEFT && arg6 == feathers.layout.RelativePosition.LEFT)) 
            {
                arg2.x = arg2.x + loc7;
                arg2.y = arg2.y + loc8;
            }
            if (arg3) 
            {
                if (!(arg7 == Number.POSITIVE_INFINITY) || !(arg4 == feathers.layout.RelativePosition.LEFT && arg6 == feathers.layout.RelativePosition.RIGHT || arg4 == feathers.layout.RelativePosition.RIGHT && arg6 == feathers.layout.RelativePosition.LEFT || arg4 == feathers.layout.RelativePosition.TOP && arg6 == feathers.layout.RelativePosition.BOTTOM || arg4 == feathers.layout.RelativePosition.BOTTOM && arg6 == feathers.layout.RelativePosition.TOP)) 
                {
                    arg3.x = arg3.x + loc7;
                    arg3.y = arg3.y + loc8;
                }
                if (arg5 == Number.POSITIVE_INFINITY && arg7 == Number.POSITIVE_INFINITY) 
                {
                    if (arg4 == feathers.layout.RelativePosition.RIGHT && arg6 == feathers.layout.RelativePosition.LEFT) 
                    {
                        arg2.x = arg3.x + Math.round((arg1.x - arg3.x + arg3.width - arg2.width) / 2);
                    }
                    else if (arg4 == feathers.layout.RelativePosition.LEFT && arg6 == feathers.layout.RelativePosition.RIGHT) 
                    {
                        arg2.x = arg1.x + Math.round((arg3.x - arg1.x + arg1.width - arg2.width) / 2);
                    }
                    else if (arg4 == feathers.layout.RelativePosition.RIGHT && arg6 == feathers.layout.RelativePosition.RIGHT) 
                    {
                        arg3.x = arg2.x + Math.round((arg1.x - arg2.x + arg2.width - arg3.width) / 2);
                    }
                    else if (arg4 == feathers.layout.RelativePosition.LEFT && arg6 == feathers.layout.RelativePosition.LEFT) 
                    {
                        arg3.x = arg1.x + Math.round((arg2.x - arg1.x + arg1.width - arg3.width) / 2);
                    }
                    else if (arg4 == feathers.layout.RelativePosition.BOTTOM && arg6 == feathers.layout.RelativePosition.TOP) 
                    {
                        arg2.y = arg3.y + Math.round((arg1.y - arg3.y + arg3.height - arg2.height) / 2);
                    }
                    else if (arg4 == feathers.layout.RelativePosition.TOP && arg6 == feathers.layout.RelativePosition.BOTTOM) 
                    {
                        arg2.y = arg1.y + Math.round((arg3.y - arg1.y + arg1.height - arg2.height) / 2);
                    }
                    else if (arg4 == feathers.layout.RelativePosition.BOTTOM && arg6 == feathers.layout.RelativePosition.BOTTOM) 
                    {
                        arg3.y = arg2.y + Math.round((arg1.y - arg2.y + arg2.height - arg3.height) / 2);
                    }
                    else if (arg4 == feathers.layout.RelativePosition.TOP && arg6 == feathers.layout.RelativePosition.TOP) 
                    {
                        arg3.y = arg1.y + Math.round((arg2.y - arg1.y + arg1.height - arg3.height) / 2);
                    }
                }
            }
            if (arg4 == feathers.layout.RelativePosition.LEFT || arg4 == feathers.layout.RelativePosition.RIGHT) 
            {
                if (this._verticalAlign != feathers.layout.VerticalAlign.TOP) 
                {
                    if (this._verticalAlign != feathers.layout.VerticalAlign.BOTTOM) 
                    {
                        arg1.y = this._paddingTop + Math.round((this.actualHeight - this._paddingTop - this._paddingBottom - arg1.height) / 2);
                    }
                    else 
                    {
                        arg1.y = this.actualHeight - this._paddingBottom - arg1.height;
                    }
                }
                else 
                {
                    arg1.y = this._paddingTop;
                }
            }
            else if (arg4 == feathers.layout.RelativePosition.TOP || arg4 == feathers.layout.RelativePosition.BOTTOM) 
            {
                if (this._horizontalAlign != feathers.layout.HorizontalAlign.LEFT) 
                {
                    if (this._horizontalAlign != feathers.layout.HorizontalAlign.RIGHT) 
                    {
                        arg1.x = this._paddingLeft + Math.round((this.actualWidth - this._paddingLeft - this._paddingRight - arg1.width) / 2);
                    }
                    else 
                    {
                        arg1.x = this.actualWidth - this._paddingRight - arg1.width;
                    }
                }
                else 
                {
                    arg1.x = this._paddingLeft;
                }
            }
            return;
        }

        public function get iconLabelFunction():Function
        {
            return this._iconLabelFunction;
        }

        public function set iconLabelFunction(arg1:Function):void
        {
            if (this._iconLabelFunction == arg1) 
            {
                return;
            }
            this._iconLabelFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected override function refreshSelectionEvents():void
        {
            var loc1:*=this._isEnabled && (this._isToggle || this.isSelectableWithoutToggle);
            if (this._itemHasSelectable) 
            {
                loc1 = loc1 && this.itemToSelectable(this._data);
            }
            if (this.accessoryTouchPointID >= 0) 
            {
                loc1 = loc1 && this._isSelectableOnAccessoryTouch;
            }
            this.tapToSelect.isEnabled = loc1;
            this.tapToSelect.tapToDeselect = this._isToggle;
            this.keyToSelect.isEnabled = false;
            return;
        }

        public function get customIconLoaderStyleName():String
        {
            return this._customIconLoaderStyleName;
        }

        public function set customIconLoaderStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customIconLoaderStyleName === arg1) 
            {
                return;
            }
            this._customIconLoaderStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function hitTestWithAccessory(arg1:flash.geom.Point):Boolean
        {
            var loc1:*=null;
            if (this._isQuickHitAreaEnabled || this._isSelectableOnAccessoryTouch || this.currentAccessory === null || this.currentAccessory === this.accessoryLabel || this.currentAccessory === this.accessoryLoader) 
            {
                return true;
            }
            if (this.currentAccessory is starling.display.DisplayObjectContainer) 
            {
                loc1 = starling.display.DisplayObjectContainer(this.currentAccessory);
                return !loc1.contains(this.hitTest(arg1));
            }
            return !(this.hitTest(arg1) === this.currentAccessory);
        }

        public function get customIconLabelStyleName():String
        {
            return this._customIconLabelStyleName;
        }

        public function set customIconLabelStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customIconLabelStyleName === arg1) 
            {
                return;
            }
            this._customIconLabelStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        protected function owner_scrollStartHandler(arg1:starling.events.Event):void
        {
            if (this._delayTextureCreationOnScroll) 
            {
                if (this.accessoryLoader) 
                {
                    this.accessoryLoader.delayTextureCreation = true;
                }
                if (this.iconLoader) 
                {
                    this.iconLoader.delayTextureCreation = true;
                }
            }
            if (this.touchPointID < 0 && this.accessoryTouchPointID < 0) 
            {
                return;
            }
            this.resetTouchState();
            if (this._stateDelayTimer && this._stateDelayTimer.running) 
            {
                this._stateDelayTimer.stop();
            }
            this._delayedCurrentState = null;
            if (this.accessoryTouchPointID >= 0) 
            {
                this._owner.stopScrolling();
            }
            return;
        }

        public function get accessoryField():String
        {
            return this._accessoryField;
        }

        public function set accessoryField(arg1:String):void
        {
            if (this._accessoryField == arg1) 
            {
                return;
            }
            this._accessoryField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function owner_scrollCompleteHandler(arg1:starling.events.Event):void
        {
            if (this._delayTextureCreationOnScroll) 
            {
                if (this.accessoryLoader) 
                {
                    this.accessoryLoader.delayTextureCreation = false;
                }
                if (this.iconLoader) 
                {
                    this.iconLoader.delayTextureCreation = false;
                }
            }
            return;
        }

        public function get accessoryFunction():Function
        {
            return this._accessoryFunction;
        }

        public function set accessoryFunction(arg1:Function):void
        {
            if (this._accessoryFunction == arg1) 
            {
                return;
            }
            this._accessoryFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function itemRenderer_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.accessoryTouchPointID = -1;
            return;
        }

        public function get accessorySourceField():String
        {
            return this._accessorySourceField;
        }

        public function set accessorySourceField(arg1:String):void
        {
            if (this._accessorySourceField == arg1) 
            {
                return;
            }
            this._accessorySourceField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function stateDelayTimer_timerCompleteHandler(arg1:flash.events.TimerEvent):void
        {
            super.changeState(this._delayedCurrentState);
            this._delayedCurrentState = null;
            return;
        }

        public function get accessorySourceFunction():Function
        {
            return this._accessorySourceFunction;
        }

        public function set accessorySourceFunction(arg1:Function):void
        {
            if (this._accessorySourceFunction == arg1) 
            {
                return;
            }
            this._accessorySourceFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected override function basicButton_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (this.currentAccessory && !this._isSelectableOnAccessoryTouch && !(this.currentAccessory == this.accessoryLabel) && !(this.currentAccessory == this.accessoryLoader) && this.touchPointID < 0) 
            {
                loc1 = arg1.getTouch(this.currentAccessory);
                if (loc1) 
                {
                    this.changeState(feathers.controls.ButtonState.UP);
                    return;
                }
            }
            super.basicButton_touchHandler(arg1);
            return;
        }

        public function get accessoryLabelField():String
        {
            return this._accessoryLabelField;
        }

        public function set accessoryLabelField(arg1:String):void
        {
            if (this._accessoryLabelField == arg1) 
            {
                return;
            }
            this._accessoryLabelField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function accessory_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (!this._isEnabled) 
            {
                this.accessoryTouchPointID = -1;
                return;
            }
            if (!this._stopScrollingOnAccessoryTouch || this.currentAccessory === this.accessoryLabel || this.currentAccessory === this.accessoryLoader) 
            {
                return;
            }
            if (this.accessoryTouchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this.currentAccessory, starling.events.TouchPhase.ENDED, this.accessoryTouchPointID);
                if (!loc1) 
                {
                    return;
                }
                this.accessoryTouchPointID = -1;
                this.refreshSelectionEvents();
            }
            else 
            {
                loc1 = arg1.getTouch(this.currentAccessory, starling.events.TouchPhase.BEGAN);
                if (!loc1) 
                {
                    return;
                }
                this.accessoryTouchPointID = loc1.id;
                this.refreshSelectionEvents();
            }
            return;
        }

        public function get accessoryLabelFunction():Function
        {
            return this._accessoryLabelFunction;
        }

        public function set accessoryLabelFunction(arg1:Function):void
        {
            if (this._accessoryLabelFunction == arg1) 
            {
                return;
            }
            this._accessoryLabelFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function accessory_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreAccessoryResizes) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get customAccessoryLabelStyleName():String
        {
            return this._customAccessoryLabelStyleName;
        }

        public function set customAccessoryLabelStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customAccessoryLabelStyleName === arg1) 
            {
                return;
            }
            this._customAccessoryLabelStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        protected function loader_completeOrErrorHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_SIZE);
            return;
        }

        public function get customAccessoryLoaderStyleName():String
        {
            return this._customAccessoryLoaderStyleName;
        }

        public function set customAccessoryLoaderStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customAccessoryLoaderStyleName === arg1) 
            {
                return;
            }
            this._customAccessoryLoaderStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        
        {
            DOWN_STATE_DELAY_MS = 250;
        }

        public function get skinField():String
        {
            return this._skinField;
        }

        public function set skinField(arg1:String):void
        {
            if (this._skinField == arg1) 
            {
                return;
            }
            this._skinField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected static function defaultLoaderFactory():feathers.controls.ImageLoader
        {
            return new feathers.controls.ImageLoader();
        }

        public function get skinFunction():Function
        {
            return this._skinFunction;
        }

        public function set skinFunction(arg1:Function):void
        {
            if (this._skinFunction == arg1) 
            {
                return;
            }
            this._skinFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get skinSourceField():String
        {
            return this._skinSourceField;
        }

        public function set skinSourceField(arg1:String):void
        {
            if (this._iconSourceField == arg1) 
            {
                return;
            }
            this._skinSourceField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get skinSourceFunction():Function
        {
            return this._skinSourceFunction;
        }

        public function set skinSourceFunction(arg1:Function):void
        {
            if (this._skinSourceFunction == arg1) 
            {
                return;
            }
            this._skinSourceFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get selectableField():String
        {
            return this._selectableField;
        }

        public function set selectableField(arg1:String):void
        {
            if (this._selectableField == arg1) 
            {
                return;
            }
            this._selectableField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get selectableFunction():Function
        {
            return this._selectableFunction;
        }

        public function set selectableFunction(arg1:Function):void
        {
            if (this._selectableFunction == arg1) 
            {
                return;
            }
            this._selectableFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get enabledField():String
        {
            return this._enabledField;
        }

        public function set enabledField(arg1:String):void
        {
            if (this._enabledField == arg1) 
            {
                return;
            }
            this._enabledField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get enabledFunction():Function
        {
            return this._enabledFunction;
        }

        public function set enabledFunction(arg1:Function):void
        {
            if (this._enabledFunction == arg1) 
            {
                return;
            }
            this._enabledFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public override function set isToggle(arg1:Boolean):void
        {
            if (this._explicitIsToggle == arg1) 
            {
                return;
            }
            super.isToggle = arg1;
            this._explicitIsToggle = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public override function set isEnabled(arg1:Boolean):void
        {
            if (this._explicitIsEnabled == arg1) 
            {
                return;
            }
            this._explicitIsEnabled = arg1;
            super.isEnabled = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get iconLoaderFactory():Function
        {
            return this._iconLoaderFactory;
        }

        public function set iconLoaderFactory(arg1:Function):void
        {
            if (this._iconLoaderFactory == arg1) 
            {
                return;
            }
            this._iconLoaderFactory = arg1;
            this._iconIsFromItem = false;
            this.replaceIcon(null);
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get iconLabelFontStyles():starling.text.TextFormat
        {
            return this._iconLabelFontStylesSet.format;
        }

        public function set iconLabelFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._iconLabelFontStylesSet.format = arg1;
            return;
        }

        public function get iconLabelDisabledFontStyles():starling.text.TextFormat
        {
            return this._iconLabelFontStylesSet.disabledFormat;
        }

        public function set iconLabelDisabledFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._iconLabelFontStylesSet.disabledFormat = arg1;
            return;
        }

        public function get iconLabelSelectedFontStyles():starling.text.TextFormat
        {
            return this._iconLabelFontStylesSet.selectedFormat;
        }

        public function set iconLabelSelectedFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._iconLabelFontStylesSet.selectedFormat = arg1;
            return;
        }

        public function get iconLabelFactory():Function
        {
            return this._iconLabelFactory;
        }

        public function set iconLabelFactory(arg1:Function):void
        {
            if (this._iconLabelFactory == arg1) 
            {
                return;
            }
            this._iconLabelFactory = arg1;
            this._iconIsFromItem = false;
            this.replaceIcon(null);
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get iconLabelProperties():Object
        {
            if (!this._iconLabelProperties) 
            {
                this._iconLabelProperties = new feathers.core.PropertyProxy(childProperties_onChange);
            }
            return this._iconLabelProperties;
        }

        public function set iconLabelProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._iconLabelProperties == arg1) 
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
            if (this._iconLabelProperties) 
            {
                this._iconLabelProperties.removeOnChangeCallback(childProperties_onChange);
            }
            this._iconLabelProperties = feathers.core.PropertyProxy(arg1);
            if (this._iconLabelProperties) 
            {
                this._iconLabelProperties.addOnChangeCallback(childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get accessoryLoaderFactory():Function
        {
            return this._accessoryLoaderFactory;
        }

        public function set accessoryLoaderFactory(arg1:Function):void
        {
            if (this._accessoryLoaderFactory == arg1) 
            {
                return;
            }
            this._accessoryLoaderFactory = arg1;
            this._accessoryIsFromItem = false;
            this.replaceAccessory(null);
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get accessoryLabelFontStyles():starling.text.TextFormat
        {
            return this._accessoryLabelFontStylesSet.format;
        }

        public static const HORIZONTAL_ALIGN_RIGHT:String="right";

        public static const ALTERNATE_STYLE_NAME_DRILL_DOWN:String="feathers-drill-down-item-renderer";

        public static const ALTERNATE_STYLE_NAME_CHECK:String="feathers-check-item-renderer";

        public static const DEFAULT_CHILD_STYLE_NAME_ICON_LABEL:String="feathers-item-renderer-icon-label";

        public static const DEFAULT_CHILD_STYLE_NAME_ICON_LOADER:String="feathers-item-renderer-icon-loader";

        public static const DEFAULT_CHILD_STYLE_NAME_ACCESSORY_LABEL:String="feathers-item-renderer-accessory-label";

        public static const DEFAULT_CHILD_STYLE_NAME_ACCESSORY_LOADER:String="feathers-item-renderer-accessory-loader";

        public static const STATE_UP:String="up";

        public static const STATE_DOWN:String="down";

        public static const STATE_HOVER:String="hover";

        public static const STATE_DISABLED:String="disabled";

        public static const STATE_UP_AND_SELECTED:String="upAndSelected";

        public static const STATE_DOWN_AND_SELECTED:String="downAndSelected";

        public static const STATE_HOVER_AND_SELECTED:String="hoverAndSelected";

        public static const STATE_DISABLED_AND_SELECTED:String="disabledAndSelected";

        public static const ICON_POSITION_TOP:String="top";

        public static const ICON_POSITION_RIGHT:String="right";

        public static const ICON_POSITION_BOTTOM:String="bottom";

        public static const ICON_POSITION_LEFT:String="left";

        public static const ICON_POSITION_MANUAL:String="manual";

        public static const ICON_POSITION_LEFT_BASELINE:String="leftBaseline";

        public static const ICON_POSITION_RIGHT_BASELINE:String="rightBaseline";

        public static const HORIZONTAL_ALIGN_LEFT:String="left";

        public static const HORIZONTAL_ALIGN_CENTER:String="center";

        public static const VERTICAL_ALIGN_TOP:String="top";

        public static const VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const VERTICAL_ALIGN_BOTTOM:String="bottom";

        public static const ACCESSORY_POSITION_TOP:String="top";

        public static const ACCESSORY_POSITION_RIGHT:String="right";

        public static const ACCESSORY_POSITION_BOTTOM:String="bottom";

        public static const ACCESSORY_POSITION_LEFT:String="left";

        public static const ACCESSORY_POSITION_MANUAL:String="manual";

        public static const LAYOUT_ORDER_LABEL_ACCESSORY_ICON:String="labelAccessoryIcon";

        public static const LAYOUT_ORDER_LABEL_ICON_ACCESSORY:String="labelIconAccessory";

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        public static const DEFAULT_CHILD_STYLE_NAME_LABEL:String="feathers-item-renderer-label";

        protected var accessoryTouchPointID:int=-1;

        protected var _stopScrollingOnAccessoryTouch:Boolean=true;

        protected var _isSelectableOnAccessoryTouch:Boolean=false;

        protected var _delayTextureCreationOnScroll:Boolean=false;

        protected var _labelField:String="label";

        protected var _labelFunction:Function;

        protected var _iconField:String="icon";

        protected var _iconFunction:Function;

        protected var _iconSourceField:String="iconSource";

        protected var _iconSourceFunction:Function;

        protected var _iconLabelField:String="iconLabel";

        protected var _iconLabelFunction:Function;

        protected var _customIconLoaderStyleName:String;

        protected var _customIconLabelStyleName:String;

        protected var _accessoryField:String="accessory";

        protected var _accessoryFunction:Function;

        protected var _accessorySourceField:String="accessorySource";

        protected var _accessorySourceFunction:Function;

        protected var _accessoryLabelField:String="accessoryLabel";

        protected var _accessoryLabelFunction:Function;

        protected var _customAccessoryLabelStyleName:String;

        protected var _data:Object;

        protected var _skinField:String="skin";

        protected var _skinFunction:Function;

        protected var _iconLabelFontStylesSet:feathers.text.FontStylesSet;

        protected var _skinLoaderFactory:Function;

        protected var _accessoryLoaderFactory:Function;

        protected var _selectableField:String="selectable";

        protected var _ignoreAccessoryResizes:Boolean=false;

        protected var _skinSourceField:String="skinSource";

        protected var _accessoryLabelFontStylesSet:feathers.text.FontStylesSet;

        protected var _explicitIsToggle:Boolean=false;

        protected var _enabledField:String="enabled";

        protected var _explicitIsEnabled:Boolean;

        protected var _skinSourceFunction:Function;

        protected var _iconLabelFactory:Function;

        protected var _iconLoaderFactory:Function;

        protected var _accessoryLabelFactory:Function;

        protected var _selectableFunction:Function;

        protected var _iconLabelProperties:feathers.core.PropertyProxy;

        protected var iconLabelStyleName:String="feathers-item-renderer-icon-label";

        protected var iconLoaderStyleName:String="feathers-item-renderer-icon-loader";

        protected var _accessoryLabelProperties:feathers.core.PropertyProxy;

        protected var accessoryLabelStyleName:String="feathers-item-renderer-accessory-label";

        protected var accessoryLoaderStyleName:String="feathers-item-renderer-accessory-loader";

        protected var _isChildFocusEnabled:Boolean=true;

        protected var skinLoader:feathers.controls.ImageLoader;

        protected var iconLoader:feathers.controls.ImageLoader;

        protected var iconLabel:feathers.core.ITextRenderer;

        protected var accessoryLoader:feathers.controls.ImageLoader;

        protected var accessoryLabel:feathers.core.ITextRenderer;

        protected var currentAccessory:starling.display.DisplayObject;

        protected var _skinIsFromItem:Boolean=false;

        protected var _iconIsFromItem:Boolean=false;

        protected var _accessoryIsFromItem:Boolean=false;

        protected var _owner:feathers.controls.Scroller;

        protected var _factoryID:String;

        protected var _delayedCurrentState:String;

        protected var _stateDelayTimer:flash.utils.Timer;

        protected var _useStateDelayTimer:Boolean=true;

        protected var isSelectableWithoutToggle:Boolean=true;

        protected var _itemHasLabel:Boolean=true;

        protected var _itemHasIcon:Boolean=true;

        protected var _itemHasAccessory:Boolean=true;

        protected var _customAccessoryLoaderStyleName:String;

        protected var _itemHasSkin:Boolean=false;

        protected var _itemHasSelectable:Boolean=false;

        protected var _itemHasEnabled:Boolean=false;

        protected var _accessoryPosition:String="right";

        protected var _layoutOrder:String="labelIconAccessory";

        protected var _accessoryOffsetX:Number=0;

        protected var _accessoryOffsetY:Number=0;

        protected var _accessoryGap:Number=NaN;

        protected var _minAccessoryGap:Number=NaN;

        protected var _defaultAccessory:starling.display.DisplayObject;

        protected var _stateToAccessory:Object;

        protected static var DOWN_STATE_DELAY_MS:int=250;

        protected var _enabledFunction:Function;

        protected var _stateToAccessoryFunction:Function;
    }
}


