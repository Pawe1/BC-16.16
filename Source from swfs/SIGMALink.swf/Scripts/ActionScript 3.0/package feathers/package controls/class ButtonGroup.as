//class ButtonGroup
package feathers.controls 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.events.*;
    
    public class ButtonGroup extends feathers.core.FeathersControl implements feathers.core.ITextBaselineControl
    {
        public function ButtonGroup()
        {
            this._layoutItems = new Vector.<starling.display.DisplayObject>(0);
            this.activeButtons = new Vector.<feathers.controls.Button>(0);
            this.inactiveButtons = new Vector.<feathers.controls.Button>(0);
            this._buttonToItem = new flash.utils.Dictionary(true);
            this._viewPortBounds = new feathers.layout.ViewPortBounds();
            this._layoutResult = new feathers.layout.LayoutBoundsResult();
            this._buttonFactory = defaultButtonFactory;
            this._buttonInitializer = this.defaultButtonInitializer;
            this._buttonReleaser = this.defaultButtonReleaser;
            super();
            return;
        }

        public function set customFirstButtonStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customFirstButtonStyleName === arg1) 
            {
                return;
            }
            this._customFirstButtonStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_BUTTON_FACTORY);
            return;
        }

        public function get customLastButtonStyleName():String
        {
            return this._customLastButtonStyleName;
        }

        public function set customLastButtonStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customLastButtonStyleName === arg1) 
            {
                return;
            }
            this._customLastButtonStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_BUTTON_FACTORY);
            return;
        }

        public function get buttonProperties():Object
        {
            if (!this._buttonProperties) 
            {
                this._buttonProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._buttonProperties;
        }

        public function set buttonProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._buttonProperties == arg1) 
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
            if (this._buttonProperties) 
            {
                this._buttonProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._buttonProperties = feathers.core.PropertyProxy(arg1);
            if (this._buttonProperties) 
            {
                this._buttonProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get baseline():Number
        {
            if (!this.activeButtons || this.activeButtons.length === 0) 
            {
                return this.scaledActualHeight;
            }
            var loc1:*=this.activeButtons[0];
            return this.scaleY * (loc1.y + loc1.baseline);
        }

        public override function dispose():void
        {
            this.dataProvider = null;
            super.dispose();
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_BUTTON_FACTORY);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            if (loc1 || loc3 || loc4) 
            {
                this.refreshButtons(loc4);
            }
            if (loc1 || loc4 || loc2) 
            {
                this.refreshButtonStyles();
            }
            if (loc1 || loc3 || loc4) 
            {
                this.commitEnabled();
            }
            if (loc2) 
            {
                this.refreshLayoutStyles();
            }
            this.layoutButtons();
            return;
        }

        protected function commitEnabled():void
        {
            var loc3:*=null;
            var loc1:*=this.activeButtons.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this.activeButtons[loc2];
                loc3.isEnabled = loc3.isEnabled && this._isEnabled;
                ++loc2;
            }
            return;
        }

        protected function refreshButtonStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=this._buttonProperties;
            for (loc1 in loc5) 
            {
                loc2 = this._buttonProperties[loc1];
                var loc6:*=0;
                var loc7:*=this.activeButtons;
                for each (loc3 in loc7) 
                {
                    loc3[loc1] = loc2;
                }
            }
            return;
        }

        protected function refreshLayoutStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (this._direction != feathers.layout.Direction.VERTICAL) 
            {
                if (this._distributeButtonSizes) 
                {
                    loc2 = this.layout as feathers.layout.HorizontalLayout;
                    if (!loc2) 
                    {
                        loc2 = loc4 = new feathers.layout.HorizontalLayout();
                        this.layout = loc4;
                    }
                    loc2.distributeWidths = true;
                    loc2.horizontalAlign = this._horizontalAlign != feathers.layout.HorizontalAlign.JUSTIFY ? this._horizontalAlign : feathers.layout.HorizontalAlign.LEFT;
                    loc2.verticalAlign = this._verticalAlign;
                    loc2.gap = this._gap;
                    loc2.firstGap = this._firstGap;
                    loc2.lastGap = this._lastGap;
                    loc2.paddingTop = this._paddingTop;
                    loc2.paddingRight = this._paddingRight;
                    loc2.paddingBottom = this._paddingBottom;
                    loc2.paddingLeft = this._paddingLeft;
                }
                else 
                {
                    loc3 = this.layout as feathers.layout.FlowLayout;
                    if (!loc3) 
                    {
                        loc3 = loc4 = new feathers.layout.FlowLayout();
                        this.layout = loc4;
                    }
                    loc3.horizontalAlign = this._horizontalAlign != feathers.layout.HorizontalAlign.JUSTIFY ? this._horizontalAlign : feathers.layout.HorizontalAlign.LEFT;
                    loc3.verticalAlign = this._verticalAlign;
                    loc3.gap = this._gap;
                    loc3.firstHorizontalGap = this._firstGap;
                    loc3.lastHorizontalGap = this._lastGap;
                    loc3.paddingTop = this._paddingTop;
                    loc3.paddingRight = this._paddingRight;
                    loc3.paddingBottom = this._paddingBottom;
                    loc3.paddingLeft = this._paddingLeft;
                }
            }
            else 
            {
                loc1 = this.layout as feathers.layout.VerticalLayout;
                if (!loc1) 
                {
                    var loc4:*;
                    loc1 = loc4 = new feathers.layout.VerticalLayout();
                    this.layout = loc4;
                }
                loc1.distributeHeights = this._distributeButtonSizes;
                loc1.horizontalAlign = this._horizontalAlign;
                loc1.verticalAlign = this._verticalAlign != feathers.layout.VerticalAlign.JUSTIFY ? this._verticalAlign : feathers.layout.VerticalAlign.TOP;
                loc1.gap = this._gap;
                loc1.firstGap = this._firstGap;
                loc1.lastGap = this._lastGap;
                loc1.paddingTop = this._paddingTop;
                loc1.paddingRight = this._paddingRight;
                loc1.paddingBottom = this._paddingBottom;
                loc1.paddingLeft = this._paddingLeft;
            }
            if (this.layout is feathers.layout.IVirtualLayout) 
            {
                feathers.layout.IVirtualLayout(this.layout).useVirtualLayout = false;
            }
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.ButtonGroup.globalStyleProvider;
        }

        protected function defaultButtonInitializer(arg1:feathers.controls.Button, arg2:Object):void
        {
            var loc1:*=null;
            var loc2:*=false;
            var loc3:*=null;
            if (arg2 is Object) 
            {
                if (arg2.hasOwnProperty(LABEL_FIELD)) 
                {
                    arg1.label = arg2.label as String;
                }
                else 
                {
                    arg1.label = arg2.toString();
                }
                if (arg2.hasOwnProperty(ENABLED_FIELD)) 
                {
                    arg1.isEnabled = arg2.isEnabled as Boolean;
                }
                else 
                {
                    arg1.isEnabled = this._isEnabled;
                }
                var loc4:*=0;
                var loc5:*=DEFAULT_BUTTON_FIELDS;
                for each (loc1 in loc5) 
                {
                    if (!arg2.hasOwnProperty(loc1)) 
                    {
                        continue;
                    }
                    arg1[loc1] = arg2[loc1];
                }
                loc4 = 0;
                loc5 = DEFAULT_BUTTON_EVENTS;
                for each (loc1 in loc5) 
                {
                    loc2 = true;
                    if (arg2.hasOwnProperty(loc1)) 
                    {
                        loc3 = arg2[loc1] as Function;
                        if (loc3 === null) 
                        {
                            continue;
                        }
                        loc2 = false;
                        arg1.addEventListener(loc1, this.defaultButtonEventsListener);
                    }
                    if (!loc2) 
                    {
                        continue;
                    }
                    arg1.removeEventListener(loc1, this.defaultButtonEventsListener);
                }
            }
            else 
            {
                arg1.label = "";
                arg1.isEnabled = this._isEnabled;
            }
            return;
        }

        public function get dataProvider():feathers.data.ListCollection
        {
            return this._dataProvider;
        }

        public function set dataProvider(arg1:feathers.data.ListCollection):void
        {
            if (this._dataProvider == arg1) 
            {
                return;
            }
            if (this._dataProvider) 
            {
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.UPDATE_ALL, this.dataProvider_updateAllHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.UPDATE_ITEM, this.dataProvider_updateItemHandler);
                this._dataProvider.removeEventListener(starling.events.Event.CHANGE, this.dataProvider_changeHandler);
            }
            this._dataProvider = arg1;
            if (this._dataProvider) 
            {
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.UPDATE_ALL, this.dataProvider_updateAllHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.UPDATE_ITEM, this.dataProvider_updateItemHandler);
                this._dataProvider.addEventListener(starling.events.Event.CHANGE, this.dataProvider_changeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function defaultButtonReleaser(arg1:feathers.controls.Button, arg2:Object):void
        {
            var loc1:*=null;
            var loc2:*=false;
            var loc3:*=null;
            arg1.label = null;
            var loc4:*=0;
            var loc5:*=DEFAULT_BUTTON_FIELDS;
            for each (loc1 in loc5) 
            {
                if (!arg2.hasOwnProperty(loc1)) 
                {
                    continue;
                }
                arg1[loc1] = null;
            }
            loc4 = 0;
            loc5 = DEFAULT_BUTTON_EVENTS;
            for each (loc1 in loc5) 
            {
                loc2 = true;
                if (!arg2.hasOwnProperty(loc1)) 
                {
                    continue;
                }
                loc3 = arg2[loc1] as Function;
                if (loc3 === null) 
                {
                    continue;
                }
                arg1.removeEventListener(loc1, this.defaultButtonEventsListener);
            }
            return;
        }

        protected function refreshButtons(arg1:Boolean):void
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=this.inactiveButtons;
            this.inactiveButtons = this.activeButtons;
            this.activeButtons = loc1;
            this.activeButtons.length = 0;
            this._layoutItems.length = 0;
            loc1 = null;
            if (arg1) 
            {
                this.clearInactiveButtons();
            }
            else 
            {
                if (this.activeFirstButton) 
                {
                    this.inactiveButtons.shift();
                }
                this.inactiveFirstButton = this.activeFirstButton;
                if (this.activeLastButton) 
                {
                    this.inactiveButtons.pop();
                }
                this.inactiveLastButton = this.activeLastButton;
            }
            this.activeFirstButton = null;
            this.activeLastButton = null;
            var loc2:*=0;
            var loc3:*=this._dataProvider ? this._dataProvider.length : 0;
            var loc4:*;
            --loc4;
            var loc5:*=0;
            while (loc5 < loc3) 
            {
                loc6 = this._dataProvider.getItemAt(loc5);
                if (loc5 != 0) 
                {
                    if (loc5 != loc4) 
                    {
                        loc7 = this.createButton(loc6);
                    }
                    else 
                    {
                        this.activeLastButton = loc8 = this.createLastButton(loc6);
                        loc7 = loc8;
                    }
                }
                else 
                {
                    var loc8:*;
                    this.activeFirstButton = loc8 = this.createFirstButton(loc6);
                    loc7 = loc8;
                }
                this.activeButtons[loc2] = loc7;
                this._layoutItems[loc2] = loc7;
                ++loc2;
                ++loc5;
            }
            this.clearInactiveButtons();
            return;
        }

        protected function clearInactiveButtons():void
        {
            var loc3:*=null;
            var loc1:*=this.inactiveButtons.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this.inactiveButtons.shift();
                this.destroyButton(loc3);
                ++loc2;
            }
            if (this.inactiveFirstButton) 
            {
                this.destroyButton(this.inactiveFirstButton);
                this.inactiveFirstButton = null;
            }
            if (this.inactiveLastButton) 
            {
                this.destroyButton(this.inactiveLastButton);
                this.inactiveLastButton = null;
            }
            return;
        }

        protected function createFirstButton(arg1:Object):feathers.controls.Button
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=false;
            if (this.inactiveFirstButton === null) 
            {
                loc1 = true;
                loc3 = this._firstButtonFactory == null ? this._buttonFactory : this._firstButtonFactory;
                loc2 = feathers.controls.Button(loc3());
                if (this._customFirstButtonStyleName) 
                {
                    loc2.styleNameList.add(this._customFirstButtonStyleName);
                }
                else if (this._customButtonStyleName) 
                {
                    loc2.styleNameList.add(this._customButtonStyleName);
                }
                else 
                {
                    loc2.styleNameList.add(this.firstButtonStyleName);
                }
                this.addChild(loc2);
            }
            else 
            {
                loc2 = this.inactiveFirstButton;
                this.releaseButton(loc2);
                this.inactiveFirstButton = null;
            }
            this._buttonInitializer(loc2, arg1);
            this._buttonToItem[loc2] = arg1;
            if (loc1) 
            {
                loc2.addEventListener(starling.events.Event.TRIGGERED, this.button_triggeredHandler);
            }
            return loc2;
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
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function createLastButton(arg1:Object):feathers.controls.Button
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=false;
            if (this.inactiveLastButton === null) 
            {
                loc1 = true;
                loc3 = this._lastButtonFactory == null ? this._buttonFactory : this._lastButtonFactory;
                loc2 = feathers.controls.Button(loc3());
                if (this._customLastButtonStyleName) 
                {
                    loc2.styleNameList.add(this._customLastButtonStyleName);
                }
                else if (this._customButtonStyleName) 
                {
                    loc2.styleNameList.add(this._customButtonStyleName);
                }
                else 
                {
                    loc2.styleNameList.add(this.lastButtonStyleName);
                }
                this.addChild(loc2);
            }
            else 
            {
                loc2 = this.inactiveLastButton;
                this.releaseButton(loc2);
                this.inactiveLastButton = null;
            }
            this._buttonInitializer(loc2, arg1);
            this._buttonToItem[loc2] = arg1;
            if (loc1) 
            {
                loc2.addEventListener(starling.events.Event.TRIGGERED, this.button_triggeredHandler);
            }
            return loc2;
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

        protected function createButton(arg1:Object):feathers.controls.Button
        {
            var loc2:*=null;
            var loc1:*=false;
            if (this.inactiveButtons.length !== 0) 
            {
                loc2 = this.inactiveButtons.shift();
                this.releaseButton(loc2);
            }
            else 
            {
                loc1 = true;
                loc2 = this._buttonFactory();
                if (this._customButtonStyleName) 
                {
                    loc2.styleNameList.add(this._customButtonStyleName);
                }
                else 
                {
                    loc2.styleNameList.add(this.buttonStyleName);
                }
                this.addChild(loc2);
            }
            this._buttonInitializer(loc2, arg1);
            this._buttonToItem[loc2] = arg1;
            if (loc1) 
            {
                loc2.addEventListener(starling.events.Event.TRIGGERED, this.button_triggeredHandler);
            }
            return loc2;
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

        protected function releaseButton(arg1:feathers.controls.Button):void
        {
            var loc1:*=this._buttonToItem[arg1];
            delete this._buttonToItem[arg1];
            if (this._buttonReleaser.length !== 1) 
            {
                this._buttonReleaser(arg1, loc1);
            }
            else 
            {
                this._buttonReleaser(arg1);
            }
            return;
        }

        public function get distributeButtonSizes():Boolean
        {
            return this._distributeButtonSizes;
        }

        public function set distributeButtonSizes(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._distributeButtonSizes === arg1) 
            {
                return;
            }
            this._distributeButtonSizes = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function destroyButton(arg1:feathers.controls.Button):void
        {
            arg1.removeEventListener(starling.events.Event.TRIGGERED, this.button_triggeredHandler);
            this.releaseButton(arg1);
            this.removeChild(arg1, true);
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

        protected function layoutButtons():void
        {
            var loc3:*=null;
            this._viewPortBounds.x = 0;
            this._viewPortBounds.y = 0;
            this._viewPortBounds.scrollX = 0;
            this._viewPortBounds.scrollY = 0;
            this._viewPortBounds.explicitWidth = this._explicitWidth;
            this._viewPortBounds.explicitHeight = this._explicitHeight;
            this._viewPortBounds.minWidth = this._explicitMinWidth;
            this._viewPortBounds.minHeight = this._explicitMinHeight;
            this._viewPortBounds.maxWidth = this._explicitMaxWidth;
            this._viewPortBounds.maxHeight = this._explicitMaxHeight;
            this.layout.layout(this._layoutItems, this._viewPortBounds, this._layoutResult);
            var loc1:*=this._layoutResult.contentWidth;
            var loc2:*=this._layoutResult.contentHeight;
            this.saveMeasurements(loc1, loc2, loc1, loc2);
            var loc4:*=0;
            var loc5:*=this.activeButtons;
            for each (loc3 in loc5) 
            {
                loc3.validate();
            }
            return;
        }

        public function get firstGap():Number
        {
            return this._firstGap;
        }

        public function set firstGap(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._firstGap === arg1) 
            {
                return;
            }
            this._firstGap = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function childProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:String):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get lastGap():Number
        {
            return this._lastGap;
        }

        public function set lastGap(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._lastGap === arg1) 
            {
                return;
            }
            this._lastGap = arg1;
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

        protected function dataProvider_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_DATA);
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

        protected function dataProvider_updateAllHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_DATA);
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

        protected function dataProvider_updateItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            this.invalidate(INVALIDATION_FLAG_DATA);
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

        protected function button_triggeredHandler(arg1:starling.events.Event):void
        {
            if (!this._dataProvider || !this.activeButtons) 
            {
                return;
            }
            var loc1:*=feathers.controls.Button(arg1.currentTarget);
            var loc2:*=this.activeButtons.indexOf(loc1);
            var loc3:*=this._dataProvider.getItemAt(loc2);
            this.dispatchEventWith(starling.events.Event.TRIGGERED, false, loc3);
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

        protected function defaultButtonEventsListener(arg1:starling.events.Event):void
        {
            var loc5:*=null;
            var loc6:*=0;
            var loc1:*=feathers.controls.Button(arg1.currentTarget);
            var loc2:*=this.activeButtons.indexOf(loc1);
            var loc3:*=this._dataProvider.getItemAt(loc2);
            var loc4:*=arg1.type;
            if (loc3.hasOwnProperty(loc4)) 
            {
                loc5 = loc3[loc4] as Function;
                if (loc5 == null) 
                {
                    return;
                }
                loc6 = loc5.length;
                var loc7:*=loc6;
                switch (loc7) 
                {
                    case 3:
                    {
                        loc5(arg1, arg1.data, loc3);
                        break;
                    }
                    case 2:
                    {
                        loc5(arg1, arg1.data);
                        break;
                    }
                    case 1:
                    {
                        loc5(arg1);
                        break;
                    }
                    default:
                    {
                        loc5();
                    }
                }
            }
            return;
        }

        public function get buttonFactory():Function
        {
            return this._buttonFactory;
        }

        public function set buttonFactory(arg1:Function):void
        {
            if (this._buttonFactory == arg1) 
            {
                return;
            }
            this._buttonFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_BUTTON_FACTORY);
            return;
        }

        
        {
            new Vector.<String>(14)[0] = "defaultIcon";
            new Vector.<String>(14)[1] = "upIcon";
            new Vector.<String>(14)[2] = "downIcon";
            new Vector.<String>(14)[3] = "hoverIcon";
            new Vector.<String>(14)[4] = "disabledIcon";
            new Vector.<String>(14)[5] = "defaultSelectedIcon";
            new Vector.<String>(14)[6] = "selectedUpIcon";
            new Vector.<String>(14)[7] = "selectedDownIcon";
            new Vector.<String>(14)[8] = "selectedHoverIcon";
            new Vector.<String>(14)[9] = "selectedDisabledIcon";
            new Vector.<String>(14)[10] = "isSelected";
            new Vector.<String>(14)[11] = "isToggle";
            new Vector.<String>(14)[12] = "isLongPressEnabled";
            new Vector.<String>(14)[13] = "name";
            new Vector.<String>(3)[0] = starling.events.Event.TRIGGERED;
            new Vector.<String>(3)[1] = starling.events.Event.CHANGE;
            new Vector.<String>(3)[2] = feathers.events.FeathersEventType.LONG_PRESS;
        }

        public function get firstButtonFactory():Function
        {
            return this._firstButtonFactory;
        }

        public function set firstButtonFactory(arg1:Function):void
        {
            if (this._firstButtonFactory == arg1) 
            {
                return;
            }
            this._firstButtonFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_BUTTON_FACTORY);
            return;
        }

        protected static function defaultButtonFactory():feathers.controls.Button
        {
            return new feathers.controls.Button();
        }

        public function get lastButtonFactory():Function
        {
            return this._lastButtonFactory;
        }

        public function set lastButtonFactory(arg1:Function):void
        {
            if (this._lastButtonFactory == arg1) 
            {
                return;
            }
            this._lastButtonFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_BUTTON_FACTORY);
            return;
        }

        public function get buttonInitializer():Function
        {
            return this._buttonInitializer;
        }

        public function set buttonInitializer(arg1:Function):void
        {
            if (this._buttonInitializer == arg1) 
            {
                return;
            }
            this._buttonInitializer = arg1;
            this.invalidate(INVALIDATION_FLAG_BUTTON_FACTORY);
            return;
        }

        public function get buttonReleaser():Function
        {
            return this._buttonReleaser;
        }

        public function set buttonReleaser(arg1:Function):void
        {
            if (this._buttonReleaser == arg1) 
            {
                return;
            }
            this._buttonReleaser = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get customButtonStyleName():String
        {
            return this._customButtonStyleName;
        }

        public function set customButtonStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customButtonStyleName === arg1) 
            {
                return;
            }
            this._customButtonStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_BUTTON_FACTORY);
            return;
        }

        public function get customFirstButtonStyleName():String
        {
            return this._customFirstButtonStyleName;
        }

        public static const VERTICAL_ALIGN_TOP:String="top";

        protected static const INVALIDATION_FLAG_BUTTON_FACTORY:String="buttonFactory";

        protected static const LABEL_FIELD:String="label";

        internal static const DEFAULT_BUTTON_FIELDS:__AS3__.vec.Vector.<String>=new Vector.<String>(14);

        internal static const DEFAULT_BUTTON_EVENTS:__AS3__.vec.Vector.<String>=new Vector.<String>(3);

        public static const DIRECTION_HORIZONTAL:String="horizontal";

        public static const DIRECTION_VERTICAL:String="vertical";

        public static const HORIZONTAL_ALIGN_LEFT:String="left";

        public static const HORIZONTAL_ALIGN_CENTER:String="center";

        public static const HORIZONTAL_ALIGN_RIGHT:String="right";

        public static const HORIZONTAL_ALIGN_JUSTIFY:String="justify";

        public static const VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const VERTICAL_ALIGN_BOTTOM:String="bottom";

        public static const VERTICAL_ALIGN_JUSTIFY:String="justify";

        public static const DEFAULT_CHILD_STYLE_NAME_BUTTON:String="feathers-button-group-button";

        protected static const ENABLED_FIELD:String="isEnabled";

        protected var _horizontalAlign:String="justify";

        protected var _verticalAlign:String="justify";

        protected var _distributeButtonSizes:Boolean=true;

        protected var _gap:Number=0;

        protected var _firstGap:Number=NaN;

        protected var _lastGap:Number=NaN;

        protected var _paddingTop:Number=0;

        protected var _paddingRight:Number=0;

        protected var _paddingBottom:Number=0;

        protected var _paddingLeft:Number=0;

        protected var inactiveLastButton:feathers.controls.Button;

        protected var _firstButtonFactory:Function;

        protected var _lastButtonFactory:Function;

        protected var _customLastButtonStyleName:String;

        protected var _buttonReleaser:Function;

        protected var _customFirstButtonStyleName:String;

        protected var _buttonProperties:feathers.core.PropertyProxy;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var buttonStyleName:String="feathers-button-group-button";

        protected var firstButtonStyleName:String="feathers-button-group-button";

        protected var _customButtonStyleName:String;

        protected var lastButtonStyleName:String="feathers-button-group-button";

        protected var activeFirstButton:feathers.controls.Button;

        protected var inactiveFirstButton:feathers.controls.Button;

        protected var activeLastButton:feathers.controls.Button;

        protected var _layoutItems:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var activeButtons:__AS3__.vec.Vector.<feathers.controls.Button>;

        protected var inactiveButtons:__AS3__.vec.Vector.<feathers.controls.Button>;

        protected var _buttonToItem:flash.utils.Dictionary;

        protected var _buttonFactory:Function;

        protected var _dataProvider:feathers.data.ListCollection;

        protected var layout:feathers.layout.ILayout;

        protected var _viewPortBounds:feathers.layout.ViewPortBounds;

        protected var _layoutResult:feathers.layout.LayoutBoundsResult;

        protected var _buttonInitializer:Function;

        protected var _direction:String="vertical";
    }
}


