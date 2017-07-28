//class TabBar
package feathers.controls 
{
    import __AS3__.vec.*;
    import feathers.core.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import flash.ui.*;
    import flash.utils.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    
    public class TabBar extends feathers.core.FeathersControl implements feathers.core.IFocusDisplayObject, feathers.core.ITextBaselineControl
    {
        public function TabBar()
        {
            this._layoutItems = new Vector.<starling.display.DisplayObject>(0);
            this.activeTabs = new Vector.<feathers.controls.ToggleButton>(0);
            this.inactiveTabs = new Vector.<feathers.controls.ToggleButton>(0);
            this._tabToItem = new flash.utils.Dictionary(true);
            this._viewPortBounds = new feathers.layout.ViewPortBounds();
            this._layoutResult = new feathers.layout.LayoutBoundsResult();
            this._tabFactory = defaultTabFactory;
            this._tabInitializer = this.defaultTabInitializer;
            this._tabReleaser = this.defaultTabReleaser;
            super();
            return;
        }

        public function setSelectedIndexWithAnimation(arg1:int):void
        {
            if (this._selectedIndex == arg1) 
            {
                return;
            }
            this._selectedIndex = arg1;
            this._animateSelectionChange = true;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function setSelectedItemWithAnimation(arg1:Object):void
        {
            if (this.selectedItem == arg1) 
            {
                return;
            }
            var loc1:*=-1;
            if (this._dataProvider !== null) 
            {
                loc1 = this._dataProvider.getItemIndex(arg1);
            }
            this.setSelectedIndexWithAnimation(loc1);
            return;
        }

        protected override function initialize():void
        {
            this.toggleGroup = new feathers.core.ToggleGroup();
            this.toggleGroup.isSelectionRequired = true;
            this.toggleGroup.addEventListener(starling.events.Event.CHANGE, this.toggleGroup_changeHandler);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_SELECTED);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_TAB_FACTORY);
            var loc6:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            if (loc1 || loc5 || loc3) 
            {
                this.refreshTabs(loc5);
            }
            if (loc1 || loc5 || loc2) 
            {
                this.refreshTabStyles();
            }
            if (loc1 || loc5 || loc4) 
            {
                this.commitSelection();
            }
            if (loc1 || loc5 || loc3) 
            {
                this.commitEnabled();
            }
            if (loc2) 
            {
                this.refreshLayoutStyles();
            }
            this.layoutTabs();
            return;
        }

        protected function commitSelection():void
        {
            this.toggleGroup.selectedIndex = this._selectedIndex;
            return;
        }

        protected function commitEnabled():void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=this.activeTabs;
            for each (loc1 in loc3) 
            {
                loc1.isEnabled = loc1.isEnabled && this._isEnabled;
            }
            return;
        }

        protected function refreshTabStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=this._tabProperties;
            for (loc1 in loc5) 
            {
                loc2 = this._tabProperties[loc1];
                var loc6:*=0;
                var loc7:*=this.activeTabs;
                for each (loc3 in loc7) 
                {
                    loc3[loc1] = loc2;
                }
            }
            return;
        }

        protected function refreshLayoutStyles():void
        {
            if (this._direction != feathers.layout.Direction.VERTICAL) 
            {
                if (this.verticalLayout) 
                {
                    this.verticalLayout = null;
                }
                if (!this.horizontalLayout) 
                {
                    this.horizontalLayout = new feathers.layout.HorizontalLayout();
                    this.horizontalLayout.useVirtualLayout = false;
                }
                this.horizontalLayout.distributeWidths = this._distributeTabSizes;
                this.horizontalLayout.horizontalAlign = this._horizontalAlign != feathers.layout.HorizontalAlign.JUSTIFY ? this._horizontalAlign : feathers.layout.HorizontalAlign.LEFT;
                this.horizontalLayout.verticalAlign = this._verticalAlign;
                this.horizontalLayout.gap = this._gap;
                this.horizontalLayout.firstGap = this._firstGap;
                this.horizontalLayout.lastGap = this._lastGap;
                this.horizontalLayout.paddingTop = this._paddingTop;
                this.horizontalLayout.paddingRight = this._paddingRight;
                this.horizontalLayout.paddingBottom = this._paddingBottom;
                this.horizontalLayout.paddingLeft = this._paddingLeft;
            }
            else 
            {
                if (this.horizontalLayout) 
                {
                    this.horizontalLayout = null;
                }
                if (!this.verticalLayout) 
                {
                    this.verticalLayout = new feathers.layout.VerticalLayout();
                    this.verticalLayout.useVirtualLayout = false;
                }
                this.verticalLayout.distributeHeights = this._distributeTabSizes;
                this.verticalLayout.horizontalAlign = this._horizontalAlign;
                this.verticalLayout.verticalAlign = this._verticalAlign != feathers.layout.VerticalAlign.JUSTIFY ? this._verticalAlign : feathers.layout.VerticalAlign.TOP;
                this.verticalLayout.gap = this._gap;
                this.verticalLayout.firstGap = this._firstGap;
                this.verticalLayout.lastGap = this._lastGap;
                this.verticalLayout.paddingTop = this._paddingTop;
                this.verticalLayout.paddingRight = this._paddingRight;
                this.verticalLayout.paddingBottom = this._paddingBottom;
                this.verticalLayout.paddingLeft = this._paddingLeft;
            }
            return;
        }

        protected function commitTabData(arg1:feathers.controls.ToggleButton, arg2:Object):void
        {
            if (arg2 === null) 
            {
                arg1.label = "";
                arg1.isEnabled = this._isEnabled;
            }
            else 
            {
                if (this._labelFunction === null) 
                {
                    if (!(this._labelField === null) && !(arg2 === null) && this._labelField in arg2) 
                    {
                        arg1.label = arg2[this._labelField];
                    }
                    else if (arg2 is String) 
                    {
                        arg1.label = arg2 as String;
                    }
                    else 
                    {
                        arg1.label = arg2.toString();
                    }
                }
                else 
                {
                    arg1.label = this._labelFunction(arg2);
                }
                if (this._iconFunction === null) 
                {
                    if (!(this._iconField === null) && !(arg2 === null) && this._iconField in arg2) 
                    {
                        arg1.defaultIcon = arg2[this._iconField] as starling.display.DisplayObject;
                    }
                }
                else 
                {
                    arg1.defaultIcon = this._iconFunction(arg2);
                }
                if (this._enabledFunction === null) 
                {
                    if (!(this._enabledField === null) && !(arg2 === null) && this._enabledField in arg2) 
                    {
                        arg1.isEnabled = arg2[this._enabledField] as Boolean;
                    }
                    else 
                    {
                        arg1.isEnabled = this._isEnabled;
                    }
                }
                else 
                {
                    arg1.isEnabled = this._enabledFunction(arg2);
                }
                if (this._tabInitializer !== null) 
                {
                    this._tabInitializer(arg1, arg2);
                }
            }
            return;
        }

        protected function defaultTabInitializer(arg1:feathers.controls.ToggleButton, arg2:Object):void
        {
            var loc1:*=null;
            if (arg2 !== null) 
            {
                var loc2:*=0;
                var loc3:*=DEFAULT_TAB_FIELDS;
                for each (loc1 in loc3) 
                {
                    if (!arg2.hasOwnProperty(loc1)) 
                    {
                        continue;
                    }
                    arg1[loc1] = arg2[loc1];
                }
            }
            return;
        }

        protected function defaultTabReleaser(arg1:feathers.controls.ToggleButton, arg2:Object):void
        {
            var loc1:*=null;
            var loc2:*=0;
            var loc3:*=DEFAULT_TAB_FIELDS;
            for each (loc1 in loc3) 
            {
                if (!arg2.hasOwnProperty(loc1)) 
                {
                    continue;
                }
                arg1[loc1] = null;
            }
            return;
        }

        protected function refreshTabs(arg1:Boolean):void
        {
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=0;
            var loc1:*=this._ignoreSelectionChanges;
            this._ignoreSelectionChanges = true;
            var loc2:*=this.toggleGroup.selectedIndex;
            this.toggleGroup.removeAllItems();
            var loc3:*=this.inactiveTabs;
            this.inactiveTabs = this.activeTabs;
            this.activeTabs = loc3;
            this.activeTabs.length = 0;
            this._layoutItems.length = 0;
            loc3 = null;
            if (arg1) 
            {
                this.clearInactiveTabs();
            }
            else 
            {
                if (this.activeFirstTab) 
                {
                    this.inactiveTabs.shift();
                }
                this.inactiveFirstTab = this.activeFirstTab;
                if (this.activeLastTab) 
                {
                    this.inactiveTabs.pop();
                }
                this.inactiveLastTab = this.activeLastTab;
            }
            this.activeFirstTab = null;
            this.activeLastTab = null;
            var loc4:*=0;
            var loc5:*=this._dataProvider ? this._dataProvider.length : 0;
            var loc6:*;
            --loc6;
            var loc7:*=0;
            while (loc7 < loc5) 
            {
                loc8 = this._dataProvider.getItemAt(loc7);
                if (loc7 != 0) 
                {
                    if (loc7 != loc6) 
                    {
                        loc9 = this.createTab(loc8);
                    }
                    else 
                    {
                        this.activeLastTab = loc11 = this.createLastTab(loc8);
                        loc9 = loc11;
                    }
                }
                else 
                {
                    var loc11:*;
                    this.activeFirstTab = loc11 = this.createFirstTab(loc8);
                    loc9 = loc11;
                }
                this.toggleGroup.addItem(loc9);
                this.activeTabs[loc4] = loc9;
                this._layoutItems[loc4] = loc9;
                ++loc4;
                ++loc7;
            }
            this.clearInactiveTabs();
            this._ignoreSelectionChanges = loc1;
            if (loc2 >= 0) 
            {
                loc10 = (this.activeTabs.length - 1);
                if (loc2 < loc10) 
                {
                    loc10 = loc2;
                }
                this._ignoreSelectionChanges = loc2 == loc10;
                this.toggleGroup.selectedIndex = loc10;
                this._ignoreSelectionChanges = loc1;
            }
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.TabBar.globalStyleProvider;
        }

        protected function clearInactiveTabs():void
        {
            var loc3:*=null;
            var loc1:*=this.inactiveTabs.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this.inactiveTabs.shift();
                this.destroyTab(loc3);
                ++loc2;
            }
            if (this.inactiveFirstTab) 
            {
                this.destroyTab(this.inactiveFirstTab);
                this.inactiveFirstTab = null;
            }
            if (this.inactiveLastTab) 
            {
                this.destroyTab(this.inactiveLastTab);
                this.inactiveLastTab = null;
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
            var loc1:*=this.selectedIndex;
            var loc2:*=this.selectedItem;
            if (this._dataProvider) 
            {
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.ADD_ITEM, this.dataProvider_addItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.REMOVE_ITEM, this.dataProvider_removeItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.REPLACE_ITEM, this.dataProvider_replaceItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.UPDATE_ITEM, this.dataProvider_updateItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.UPDATE_ALL, this.dataProvider_updateAllHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.RESET, this.dataProvider_resetHandler);
            }
            this._dataProvider = arg1;
            if (this._dataProvider) 
            {
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.ADD_ITEM, this.dataProvider_addItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.REMOVE_ITEM, this.dataProvider_removeItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.REPLACE_ITEM, this.dataProvider_replaceItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.UPDATE_ITEM, this.dataProvider_updateItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.UPDATE_ALL, this.dataProvider_updateAllHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.RESET, this.dataProvider_resetHandler);
            }
            if (!this._dataProvider || this._dataProvider.length == 0) 
            {
                this.selectedIndex = -1;
            }
            else 
            {
                this.selectedIndex = 0;
            }
            if (this.selectedIndex == loc1 && !(this.selectedItem == loc2)) 
            {
                this.dispatchEventWith(starling.events.Event.CHANGE);
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function createFirstTab(arg1:Object):feathers.controls.ToggleButton
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=false;
            if (this.inactiveFirstTab === null) 
            {
                loc1 = true;
                loc3 = this._firstTabFactory == null ? this._tabFactory : this._firstTabFactory;
                loc2 = feathers.controls.ToggleButton(loc3());
                if (this._customFirstTabStyleName) 
                {
                    loc2.styleNameList.add(this._customFirstTabStyleName);
                }
                else if (this._customTabStyleName) 
                {
                    loc2.styleNameList.add(this._customTabStyleName);
                }
                else 
                {
                    loc2.styleNameList.add(this.firstTabStyleName);
                }
                loc2.isToggle = true;
                this.addChild(loc2);
            }
            else 
            {
                loc2 = this.inactiveFirstTab;
                this.releaseTab(loc2);
                this.inactiveFirstTab = null;
            }
            this.commitTabData(loc2, arg1);
            this._tabToItem[loc2] = arg1;
            if (loc1) 
            {
                loc2.addEventListener(starling.events.Event.TRIGGERED, this.tab_triggeredHandler);
            }
            return loc2;
        }

        protected function createLastTab(arg1:Object):feathers.controls.ToggleButton
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=false;
            if (this.inactiveLastTab === null) 
            {
                loc1 = true;
                loc3 = this._lastTabFactory == null ? this._tabFactory : this._lastTabFactory;
                loc2 = feathers.controls.ToggleButton(loc3());
                if (this._customLastTabStyleName) 
                {
                    loc2.styleNameList.add(this._customLastTabStyleName);
                }
                else if (this._customTabStyleName) 
                {
                    loc2.styleNameList.add(this._customTabStyleName);
                }
                else 
                {
                    loc2.styleNameList.add(this.lastTabStyleName);
                }
                loc2.isToggle = true;
                this.addChild(loc2);
            }
            else 
            {
                loc2 = this.inactiveLastTab;
                this.releaseTab(loc2);
                this.inactiveLastTab = null;
            }
            this.commitTabData(loc2, arg1);
            this._tabToItem[loc2] = arg1;
            if (loc1) 
            {
                loc2.addEventListener(starling.events.Event.TRIGGERED, this.tab_triggeredHandler);
            }
            return loc2;
        }

        protected function createTab(arg1:Object):feathers.controls.ToggleButton
        {
            var loc2:*=null;
            var loc1:*=false;
            if (this.inactiveTabs.length !== 0) 
            {
                loc2 = this.inactiveTabs.shift();
                this.releaseTab(loc2);
            }
            else 
            {
                loc1 = true;
                loc2 = feathers.controls.ToggleButton(this._tabFactory());
                if (this._customTabStyleName) 
                {
                    loc2.styleNameList.add(this._customTabStyleName);
                }
                else 
                {
                    loc2.styleNameList.add(this.tabStyleName);
                }
                loc2.isToggle = true;
                this.addChild(loc2);
            }
            this.commitTabData(loc2, arg1);
            this._tabToItem[loc2] = arg1;
            if (loc1) 
            {
                loc2.addEventListener(starling.events.Event.TRIGGERED, this.tab_triggeredHandler);
            }
            return loc2;
        }

        protected function releaseTab(arg1:feathers.controls.ToggleButton):void
        {
            var loc1:*=this._tabToItem[arg1];
            delete this._tabToItem[arg1];
            if (!(this._labelFunction === null) || this._labelField in loc1) 
            {
                arg1.label = null;
            }
            if (!(this._iconFunction === null) || this._iconField in loc1) 
            {
                arg1.defaultIcon = null;
            }
            if (this._tabReleaser !== null) 
            {
                if (this._tabReleaser.length !== 1) 
                {
                    this._tabReleaser(arg1, loc1);
                }
                else 
                {
                    this._tabReleaser(arg1);
                }
            }
            return;
        }

        public function set distributeTabSizes(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._distributeTabSizes === arg1) 
            {
                return;
            }
            this._distributeTabSizes = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
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
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function destroyTab(arg1:feathers.controls.ToggleButton):void
        {
            this.toggleGroup.removeItem(arg1);
            this.releaseTab(arg1);
            this.removeChild(arg1, true);
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

        protected function layoutTabs():void
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
            if (this.verticalLayout) 
            {
                this.verticalLayout.layout(this._layoutItems, this._viewPortBounds, this._layoutResult);
            }
            else if (this.horizontalLayout) 
            {
                this.horizontalLayout.layout(this._layoutItems, this._viewPortBounds, this._layoutResult);
            }
            var loc1:*=this._layoutResult.contentWidth;
            var loc2:*=this._layoutResult.contentHeight;
            this.saveMeasurements(loc1, loc2, loc1, loc2);
            var loc4:*=0;
            var loc5:*=this.activeTabs;
            for each (loc3 in loc5) 
            {
                loc3.validate();
            }
            if (this._selectionSkin !== null) 
            {
                this.setChildIndex(this._selectionSkin, (this.numChildren - 1));
                if (this._selectionChangeTween !== null) 
                {
                    this._selectionChangeTween.advanceTime(this._selectionChangeTween.totalTime);
                }
                if (this._selectedIndex >= 0) 
                {
                    this._selectionSkin.visible = true;
                    loc3 = this.activeTabs[this._selectedIndex];
                    if (this._animateSelectionChange) 
                    {
                        this._selectionChangeTween = new starling.animation.Tween(this._selectionSkin, this._selectionChangeDuration, this._selectionChangeEase);
                        if (this._direction !== feathers.layout.Direction.VERTICAL) 
                        {
                            this._selectionChangeTween.animate("x", loc3.x);
                            this._selectionChangeTween.animate("width", loc3.width);
                        }
                        else 
                        {
                            this._selectionChangeTween.animate("y", loc3.y);
                            this._selectionChangeTween.animate("height", loc3.height);
                        }
                        this._selectionChangeTween.onComplete = this.selectionChangeTween_onComplete;
                        starling.core.Starling.juggler.add(this._selectionChangeTween);
                    }
                    else if (this._direction !== DIRECTION_VERTICAL) 
                    {
                        this._selectionSkin.x = loc3.x;
                        this._selectionSkin.width = loc3.width;
                    }
                    else 
                    {
                        this._selectionSkin.y = loc3.y;
                        this._selectionSkin.height = loc3.height;
                    }
                }
                else 
                {
                    this._selectionSkin.visible = false;
                }
                this._animateSelectionChange = false;
                if (this._selectionSkin is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this._selectionSkin).validate();
                }
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
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public override function showFocus():void
        {
            if (!this._hasFocus) 
            {
                return;
            }
            this._showFocus = true;
            this.showFocusedTab();
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        public function get selectionSkin():starling.display.DisplayObject
        {
            return this._selectionSkin;
        }

        public function set selectionSkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._selectionSkin === arg1) 
            {
                return;
            }
            if (!(this._selectionSkin === null) && this._selectionSkin.parent === this) 
            {
                this._selectionSkin.removeFromParent(false);
            }
            this._selectionSkin = arg1;
            if (this._selectionSkin !== null) 
            {
                this._selectionSkin.touchable = false;
                this.addChild(this._selectionSkin);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public override function hideFocus():void
        {
            if (!this._hasFocus) 
            {
                return;
            }
            this._showFocus = false;
            this.hideFocusedTab();
            this.invalidate(INVALIDATION_FLAG_FOCUS);
            return;
        }

        protected function hideFocusedTab():void
        {
            if (this._focusedTabIndex < 0) 
            {
                return;
            }
            var loc1:*=this.activeTabs[this._focusedTabIndex];
            loc1.hideFocus();
            return;
        }

        public function get selectionChangeDuration():Number
        {
            return this._selectionChangeDuration;
        }

        public function set selectionChangeDuration(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._selectionChangeDuration = arg1;
            return;
        }

        protected function showFocusedTab():void
        {
            if (!this._showFocus || this._focusedTabIndex < 0) 
            {
                return;
            }
            var loc1:*=this.activeTabs[this._focusedTabIndex];
            loc1.showFocus();
            return;
        }

        public function get selectionChangeEase():Object
        {
            return this._selectionChangeEase;
        }

        public function set selectionChangeEase(arg1:Object):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._selectionChangeEase = arg1;
            return;
        }

        protected function focusedTabFocusIn():void
        {
            if (this._focusedTabIndex < 0) 
            {
                return;
            }
            var loc1:*=this.activeTabs[this._focusedTabIndex];
            loc1.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_IN);
            return;
        }

        public function get distributeTabSizes():Boolean
        {
            return this._distributeTabSizes;
        }

        protected function focusedTabFocusOut():void
        {
            if (this._focusedTabIndex < 0) 
            {
                return;
            }
            var loc1:*=this.activeTabs[this._focusedTabIndex];
            loc1.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_OUT);
            return;
        }

        protected function childProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:String):void
        {
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
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function selectionChangeTween_onComplete():void
        {
            this._selectionChangeTween = null;
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

        protected override function focusInHandler(arg1:starling.events.Event):void
        {
            super.focusInHandler(arg1);
            this._focusedTabIndex = this._selectedIndex;
            this.focusedTabFocusIn();
            this.stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
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

        protected override function focusOutHandler(arg1:starling.events.Event):void
        {
            super.focusOutHandler(arg1);
            this.hideFocusedTab();
            this.focusedTabFocusOut();
            this.stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
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

        protected function stage_keyDownHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (!this._isEnabled) 
            {
                return;
            }
            if (!this._dataProvider || this._dataProvider.length === 0) 
            {
                return;
            }
            var loc1:*=this._focusedTabIndex;
            var loc2:*=(this._dataProvider.length - 1);
            if (arg1.keyCode != flash.ui.Keyboard.HOME) 
            {
                if (arg1.keyCode != flash.ui.Keyboard.END) 
                {
                    if (arg1.keyCode != flash.ui.Keyboard.PAGE_UP) 
                    {
                        if (arg1.keyCode != flash.ui.Keyboard.PAGE_DOWN) 
                        {
                            if (arg1.keyCode === flash.ui.Keyboard.UP || arg1.keyCode === flash.ui.Keyboard.LEFT) 
                            {
                                --loc1;
                                if (loc1 < 0) 
                                {
                                    loc1 = loc2;
                                }
                            }
                            else if (arg1.keyCode === flash.ui.Keyboard.DOWN || arg1.keyCode === flash.ui.Keyboard.RIGHT) 
                            {
                                ++loc1;
                                if (loc1 > loc2) 
                                {
                                    loc1 = 0;
                                }
                            }
                        }
                        else 
                        {
                            ++loc1;
                            if (loc1 > loc2) 
                            {
                                loc1 = 0;
                            }
                            this.selectedIndex = loc1;
                        }
                    }
                    else 
                    {
                        --loc1;
                        if (loc1 < 0) 
                        {
                            loc1 = loc2;
                        }
                        this.selectedIndex = loc1;
                    }
                }
                else 
                {
                    loc1 = loc3 = loc2;
                    this.selectedIndex = loc3;
                }
            }
            else 
            {
                var loc3:*;
                loc1 = loc3 = 0;
                this.selectedIndex = loc3;
            }
            if (loc1 >= 0 && !(loc1 === this._focusedTabIndex)) 
            {
                this.hideFocusedTab();
                this.focusedTabFocusOut();
                this._focusedTabIndex = loc1;
                this.focusedTabFocusIn();
                this.showFocusedTab();
            }
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

        protected function tab_triggeredHandler(arg1:starling.events.Event):void
        {
            if (!this._dataProvider || !this.activeTabs) 
            {
                return;
            }
            var loc1:*=feathers.controls.ToggleButton(arg1.currentTarget);
            var loc2:*=this.activeTabs.indexOf(loc1);
            var loc3:*=this._dataProvider.getItemAt(loc2);
            this.dispatchEventWith(starling.events.Event.TRIGGERED, false, loc3);
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

        protected function toggleGroup_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreSelectionChanges) 
            {
                return;
            }
            this.setSelectedIndexWithAnimation(this.toggleGroup.selectedIndex);
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

        protected function dataProvider_removeItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            var loc1:*=0;
            var loc2:*=0;
            var loc3:*=0;
            if (this._selectedIndex > arg2) 
            {
                --this.selectedIndex;
            }
            else if (this._selectedIndex == arg2) 
            {
                loc1 = this._selectedIndex;
                loc2 = loc1;
                loc3 = (this._dataProvider.length - 1);
                if (loc2 > loc3) 
                {
                    loc2 = loc3;
                }
                if (loc1 != loc2) 
                {
                    this.selectedIndex = loc2;
                }
                else 
                {
                    this.invalidate(INVALIDATION_FLAG_SELECTED);
                    this.dispatchEventWith(starling.events.Event.CHANGE);
                }
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get tabFactory():Function
        {
            return this._tabFactory;
        }

        public function set tabFactory(arg1:Function):void
        {
            if (this._tabFactory == arg1) 
            {
                return;
            }
            this._tabFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_TAB_FACTORY);
            return;
        }

        protected function dataProvider_resetHandler(arg1:starling.events.Event):void
        {
            if (this._dataProvider.length > 0) 
            {
                if (this._selectedIndex == 0) 
                {
                    this.invalidate(INVALIDATION_FLAG_SELECTED);
                    this.dispatchEventWith(starling.events.Event.CHANGE);
                }
                else 
                {
                    this.selectedIndex = 0;
                }
            }
            else if (this._selectedIndex >= 0) 
            {
                this.selectedIndex = -1;
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get firstTabFactory():Function
        {
            return this._firstTabFactory;
        }

        public function set firstTabFactory(arg1:Function):void
        {
            if (this._firstTabFactory == arg1) 
            {
                return;
            }
            this._firstTabFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_TAB_FACTORY);
            return;
        }

        protected function dataProvider_replaceItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            if (this._selectedIndex == arg2) 
            {
                this.invalidate(INVALIDATION_FLAG_SELECTED);
                this.dispatchEventWith(starling.events.Event.CHANGE);
            }
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get lastTabFactory():Function
        {
            return this._lastTabFactory;
        }

        public function set lastTabFactory(arg1:Function):void
        {
            if (this._lastTabFactory == arg1) 
            {
                return;
            }
            this._lastTabFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_TAB_FACTORY);
            return;
        }

        protected function dataProvider_updateItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get tabInitializer():Function
        {
            return this._tabInitializer;
        }

        public function set tabInitializer(arg1:Function):void
        {
            if (this._tabInitializer == arg1) 
            {
                return;
            }
            this._tabInitializer = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function dataProvider_updateAllHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get tabReleaser():Function
        {
            return this._tabReleaser;
        }

        public function set tabReleaser(arg1:Function):void
        {
            if (this._tabReleaser == arg1) 
            {
                return;
            }
            this._tabReleaser = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected static function defaultTabFactory():feathers.controls.ToggleButton
        {
            return new feathers.controls.ToggleButton();
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

        
        {
            new Vector.<String>(10)[0] = "upIcon";
            new Vector.<String>(10)[1] = "downIcon";
            new Vector.<String>(10)[2] = "hoverIcon";
            new Vector.<String>(10)[3] = "disabledIcon";
            new Vector.<String>(10)[4] = "defaultSelectedIcon";
            new Vector.<String>(10)[5] = "selectedUpIcon";
            new Vector.<String>(10)[6] = "selectedDownIcon";
            new Vector.<String>(10)[7] = "selectedHoverIcon";
            new Vector.<String>(10)[8] = "selectedDisabledIcon";
            new Vector.<String>(10)[9] = "name";
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

        protected function dataProvider_addItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            if (this._selectedIndex >= arg2) 
            {
                this.selectedIndex = this.selectedIndex + 1;
                this.invalidate(INVALIDATION_FLAG_SELECTED);
            }
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

        public function get selectedIndex():int
        {
            return this._selectedIndex;
        }

        public function set selectedIndex(arg1:int):void
        {
            this._animateSelectionChange = false;
            if (this._selectedIndex == arg1) 
            {
                return;
            }
            this._selectedIndex = arg1;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get selectedItem():Object
        {
            var loc1:*=this.selectedIndex;
            if (!this._dataProvider || loc1 < 0 || loc1 >= this._dataProvider.length) 
            {
                return null;
            }
            return this._dataProvider.getItemAt(loc1);
        }

        public function set selectedItem(arg1:Object):void
        {
            if (!this._dataProvider) 
            {
                this.selectedIndex = -1;
                return;
            }
            this.selectedIndex = this._dataProvider.getItemIndex(arg1);
            return;
        }

        public function get customTabStyleName():String
        {
            return this._customTabStyleName;
        }

        public function set customTabStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customTabStyleName === arg1) 
            {
                return;
            }
            this._customTabStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_TAB_FACTORY);
            return;
        }

        public function get customFirstTabStyleName():String
        {
            return this._customFirstTabStyleName;
        }

        public function set customFirstTabStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customFirstTabStyleName === arg1) 
            {
                return;
            }
            this._customFirstTabStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_TAB_FACTORY);
            return;
        }

        public function get customLastTabStyleName():String
        {
            return this._customLastTabStyleName;
        }

        public function set customLastTabStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customLastTabStyleName === arg1) 
            {
                return;
            }
            this._customLastTabStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_TAB_FACTORY);
            return;
        }

        public function get tabProperties():Object
        {
            if (!this._tabProperties) 
            {
                this._tabProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._tabProperties;
        }

        public function set tabProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._tabProperties == arg1) 
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
            if (this._tabProperties) 
            {
                this._tabProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._tabProperties = feathers.core.PropertyProxy(arg1);
            if (this._tabProperties) 
            {
                this._tabProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get baseline():Number
        {
            if (!this.activeTabs || this.activeTabs.length === 0) 
            {
                return this.scaledActualHeight;
            }
            var loc1:*=this.activeTabs[0];
            return this.scaleY * (loc1.y + loc1.baseline);
        }

        public override function dispose():void
        {
            var loc3:*=null;
            this._selectedIndex = -1;
            this._ignoreSelectionChanges = true;
            var loc1:*=this.activeTabs.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this.activeTabs.shift();
                this.destroyTab(loc3);
                ++loc2;
            }
            this.dataProvider = null;
            super.dispose();
            return;
        }

        public static const HORIZONTAL_ALIGN_JUSTIFY:String="justify";

        protected static const INVALIDATION_FLAG_TAB_FACTORY:String="tabFactory";

        internal static const DEFAULT_TAB_FIELDS:__AS3__.vec.Vector.<String>=new Vector.<String>(10);

        public static const DIRECTION_HORIZONTAL:String="horizontal";

        public static const DIRECTION_VERTICAL:String="vertical";

        public static const HORIZONTAL_ALIGN_LEFT:String="left";

        public static const HORIZONTAL_ALIGN_CENTER:String="center";

        public static const HORIZONTAL_ALIGN_RIGHT:String="right";

        public static const VERTICAL_ALIGN_TOP:String="top";

        public static const VERTICAL_ALIGN_MIDDLE:String="middle";

        public static const VERTICAL_ALIGN_BOTTOM:String="bottom";

        public static const VERTICAL_ALIGN_JUSTIFY:String="justify";

        public static const DEFAULT_CHILD_STYLE_NAME_TAB:String="feathers-tab-bar-tab";

        protected var verticalLayout:feathers.layout.VerticalLayout;

        protected var horizontalLayout:feathers.layout.HorizontalLayout;

        protected var _viewPortBounds:feathers.layout.ViewPortBounds;

        protected var _layoutResult:feathers.layout.LayoutBoundsResult;

        protected var _horizontalAlign:String="justify";

        protected var _verticalAlign:String="justify";

        protected var _selectionSkin:starling.display.DisplayObject;

        protected var _selectionChangeTween:starling.animation.Tween;

        protected var _selectionChangeDuration:Number=0.25;

        protected var _selectionChangeEase:Object="easeOut";

        protected var _distributeTabSizes:Boolean=true;

        protected var _direction:String="horizontal";

        protected var _gap:Number=0;

        protected var _firstGap:Number=NaN;

        protected var _lastGap:Number=NaN;

        protected var _paddingTop:Number=0;

        protected var _paddingRight:Number=0;

        protected var _paddingBottom:Number=0;

        protected var _paddingLeft:Number=0;

        protected var _tabFactory:Function;

        protected var _firstTabFactory:Function;

        protected var _lastTabFactory:Function;

        protected var _tabInitializer:Function;

        protected var _tabReleaser:Function;

        protected var _labelField:String="label";

        protected var _labelFunction:Function;

        protected var _focusedTabIndex:int=-1;

        protected var _iconField:String="defaultIcon";

        protected var _iconFunction:Function;

        protected var _customLastTabStyleName:String;

        protected var _enabledField:String="isEnabled";

        protected var _ignoreSelectionChanges:Boolean=false;

        protected var _customTabStyleName:String;

        protected var _tabProperties:feathers.core.PropertyProxy;

        protected var _selectedIndex:int=-1;

        protected var tabStyleName:String="feathers-tab-bar-tab";

        protected var firstTabStyleName:String="feathers-tab-bar-tab";

        protected var lastTabStyleName:String="feathers-tab-bar-tab";

        protected var toggleGroup:feathers.core.ToggleGroup;

        protected var activeFirstTab:feathers.controls.ToggleButton;

        protected var inactiveFirstTab:feathers.controls.ToggleButton;

        protected var activeLastTab:feathers.controls.ToggleButton;

        protected var inactiveLastTab:feathers.controls.ToggleButton;

        protected var _enabledFunction:Function;

        protected var _layoutItems:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        protected var activeTabs:__AS3__.vec.Vector.<feathers.controls.ToggleButton>;

        protected var inactiveTabs:__AS3__.vec.Vector.<feathers.controls.ToggleButton>;

        protected var _tabToItem:flash.utils.Dictionary;

        protected var _dataProvider:feathers.data.ListCollection;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var _customFirstTabStyleName:String;

        protected var _animateSelectionChange:Boolean=false;
    }
}


