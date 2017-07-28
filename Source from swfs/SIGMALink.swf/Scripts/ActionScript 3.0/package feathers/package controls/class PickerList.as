//class PickerList
package feathers.controls 
{
    import feathers.controls.popups.*;
    import feathers.core.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.skins.*;
    import feathers.system.*;
    import flash.ui.*;
    import starling.core.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class PickerList extends feathers.core.FeathersControl implements feathers.core.IFocusDisplayObject, feathers.core.ITextBaselineControl
    {
        public function PickerList()
        {
            super();
            return;
        }

        protected function refreshButtonLabel():void
        {
            if (this._selectedIndex >= 0) 
            {
                this.button.label = this.itemToLabel(this.selectedItem);
            }
            else 
            {
                this.button.label = this._prompt;
            }
            return;
        }

        protected function refreshButtonProperties():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._buttonProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._buttonProperties[loc1];
                this.button[loc1] = loc2;
            }
            return;
        }

        protected function refreshListProperties():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._listProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._listProperties[loc1];
                this.list[loc1] = loc2;
            }
            return;
        }

        protected function layout():void
        {
            this.button.width = this.actualWidth;
            this.button.height = this.actualHeight;
            this.button.validate();
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return PickerList.globalStyleProvider;
        }

        protected function handlePendingActions():void
        {
            if (this._isOpenListPending) 
            {
                this.openList();
            }
            if (this._isCloseListPending) 
            {
                this.closeList();
            }
            return;
        }

        protected override function focusInHandler(arg1:starling.events.Event):void
        {
            super.focusInHandler(arg1);
            this._buttonHasFocus = true;
            this.button.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_IN);
            return;
        }

        protected override function focusOutHandler(arg1:starling.events.Event):void
        {
            if (this._buttonHasFocus) 
            {
                this.button.dispatchEventWith(feathers.events.FeathersEventType.FOCUS_OUT);
                this._buttonHasFocus = false;
            }
            super.focusOutHandler(arg1);
            return;
        }

        protected function childProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:String):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function button_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (this._buttonTouchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this.button, starling.events.TouchPhase.ENDED, this._buttonTouchPointID);
                if (!loc1) 
                {
                    return;
                }
                this._buttonTouchPointID = -1;
                this._listIsOpenOnTouchBegan = false;
            }
            else 
            {
                loc1 = arg1.getTouch(this.button, starling.events.TouchPhase.BEGAN);
                if (!loc1) 
                {
                    return;
                }
                this._buttonTouchPointID = loc1.id;
                this._listIsOpenOnTouchBegan = this._popUpContentManager.isOpen;
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
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.RESET, this.dataProvider_multipleEventHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.ADD_ITEM, this.dataProvider_multipleEventHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.REMOVE_ITEM, this.dataProvider_multipleEventHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.REPLACE_ITEM, this.dataProvider_multipleEventHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.UPDATE_ITEM, this.dataProvider_updateItemHandler);
            }
            this._dataProvider = arg1;
            if (this._dataProvider) 
            {
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.RESET, this.dataProvider_multipleEventHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.ADD_ITEM, this.dataProvider_multipleEventHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.REMOVE_ITEM, this.dataProvider_multipleEventHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.REPLACE_ITEM, this.dataProvider_multipleEventHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.UPDATE_ITEM, this.dataProvider_updateItemHandler);
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

        protected function button_triggeredHandler(arg1:starling.events.Event):void
        {
            if (this._focusManager && this._listIsOpenOnTouchBegan) 
            {
                return;
            }
            if (this._popUpContentManager.isOpen) 
            {
                this.closeList();
                return;
            }
            this.openList();
            return;
        }

        protected function list_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreSelectionChanges || this._popUpContentManager is feathers.controls.popups.IPersistentPopUpContentManager) 
            {
                return;
            }
            this.selectedIndex = this.list.selectedIndex;
            return;
        }

        public function get selectedIndex():int
        {
            return this._selectedIndex;
        }

        public function set selectedIndex(arg1:int):void
        {
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
            if (!this._dataProvider || this._selectedIndex < 0 || this._selectedIndex >= this._dataProvider.length) 
            {
                return null;
            }
            return this._dataProvider.getItemAt(this._selectedIndex);
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

        protected function popUpContentManager_openHandler(arg1:starling.events.Event):void
        {
            if (this._toggleButtonOnOpenAndClose && this.button is feathers.core.IToggle) 
            {
                feathers.core.IToggle(this.button).isSelected = true;
            }
            this.list.revealScrollBars();
            this.dispatchEventWith(starling.events.Event.OPEN);
            return;
        }

        public function get prompt():String
        {
            return this._prompt;
        }

        public function set prompt(arg1:String):void
        {
            if (this._prompt == arg1) 
            {
                return;
            }
            this._prompt = arg1;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        protected function popUpContentManager_closeHandler(arg1:starling.events.Event):void
        {
            if (this._popUpContentManager is feathers.controls.popups.IPersistentPopUpContentManager) 
            {
                this.selectedIndex = this.list.selectedIndex;
            }
            if (this._toggleButtonOnOpenAndClose && this.button is feathers.core.IToggle) 
            {
                feathers.core.IToggle(this.button).isSelected = false;
            }
            this.dispatchEventWith(starling.events.Event.CLOSE);
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

        protected function list_removedFromStageHandler(arg1:starling.events.Event):void
        {
            if (this._focusManager) 
            {
                this.list.stage.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
                this.list.removeEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.list_focusOutHandler);
            }
            return;
        }

        public function get labelFunction():Function
        {
            return this._labelFunction;
        }

        public function set labelFunction(arg1:Function):void
        {
            this._labelFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function list_focusOutHandler(arg1:starling.events.Event):void
        {
            if (!this._popUpContentManager.isOpen) 
            {
                return;
            }
            this.closeList();
            return;
        }

        public function get popUpContentManager():feathers.controls.popups.IPopUpContentManager
        {
            return this._popUpContentManager;
        }

        public function set popUpContentManager(arg1:feathers.controls.popups.IPopUpContentManager):void
        {
            var loc1:*=null;
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._popUpContentManager === arg1) 
            {
                return;
            }
            if (this._popUpContentManager is starling.events.EventDispatcher) 
            {
                loc1 = starling.events.EventDispatcher(this._popUpContentManager);
                loc1.removeEventListener(starling.events.Event.OPEN, this.popUpContentManager_openHandler);
                loc1.removeEventListener(starling.events.Event.CLOSE, this.popUpContentManager_closeHandler);
            }
            this._popUpContentManager = arg1;
            if (this._popUpContentManager is starling.events.EventDispatcher) 
            {
                loc1 = starling.events.EventDispatcher(this._popUpContentManager);
                loc1.addEventListener(starling.events.Event.OPEN, this.popUpContentManager_openHandler);
                loc1.addEventListener(starling.events.Event.CLOSE, this.popUpContentManager_closeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function list_triggeredHandler(arg1:starling.events.Event):void
        {
            if (!this._isEnabled || this._popUpContentManager is feathers.controls.popups.IPersistentPopUpContentManager) 
            {
                return;
            }
            this._triggered = true;
            return;
        }

        public function get typicalItem():Object
        {
            return this._typicalItem;
        }

        public function set typicalItem(arg1:Object):void
        {
            if (this._typicalItem == arg1) 
            {
                return;
            }
            this._typicalItem = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function list_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=arg1.getTouch(this.list);
            if (loc1 === null) 
            {
                return;
            }
            if (loc1.phase === starling.events.TouchPhase.BEGAN) 
            {
                this._triggered = false;
            }
            if (loc1.phase === starling.events.TouchPhase.ENDED && this._triggered) 
            {
                this.closeList();
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

        protected function dataProvider_multipleEventHandler(arg1:starling.events.Event):void
        {
            this.validate();
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

        protected function dataProvider_updateItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            if (arg2 === this._selectedIndex) 
            {
                this.invalidate(INVALIDATION_FLAG_SELECTED);
            }
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

        protected function stage_keyUpHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (!this._popUpContentManager.isOpen) 
            {
                return;
            }
            if (arg1.keyCode == flash.ui.Keyboard.ENTER) 
            {
                this.closeList();
            }
            return;
        }

        public function get listFactory():Function
        {
            return this._listFactory;
        }

        public function set listFactory(arg1:Function):void
        {
            if (this._listFactory == arg1) 
            {
                return;
            }
            this._listFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_LIST_FACTORY);
            return;
        }

        protected static function defaultButtonFactory():feathers.controls.Button
        {
            return new feathers.controls.Button();
        }

        public function get customListStyleName():String
        {
            return this._customListStyleName;
        }

        public function set customListStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customListStyleName === arg1) 
            {
                return;
            }
            this._customListStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_LIST_FACTORY);
            return;
        }

        protected static function defaultListFactory():feathers.controls.List
        {
            return new feathers.controls.List();
        }

        public function get listProperties():Object
        {
            if (!this._listProperties) 
            {
                this._listProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._listProperties;
        }

        public function set listProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._listProperties == arg1) 
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
            if (this._listProperties) 
            {
                this._listProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._listProperties = feathers.core.PropertyProxy(arg1);
            if (this._listProperties) 
            {
                this._listProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get toggleButtonOnOpenAndClose():Boolean
        {
            return this._toggleButtonOnOpenAndClose;
        }

        public function set toggleButtonOnOpenAndClose(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._toggleButtonOnOpenAndClose === arg1) 
            {
                return;
            }
            this._toggleButtonOnOpenAndClose = arg1;
            if (this.button is feathers.core.IToggle) 
            {
                if (this._toggleButtonOnOpenAndClose && this._popUpContentManager.isOpen) 
                {
                    feathers.core.IToggle(this.button).isSelected = true;
                }
                else 
                {
                    feathers.core.IToggle(this.button).isSelected = false;
                }
            }
            return;
        }

        public function get baseline():Number
        {
            if (!this.button) 
            {
                return this.scaledActualHeight;
            }
            return this.scaleY * (this.button.y + this.button.baseline);
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

        public function openList():void
        {
            this._isCloseListPending = false;
            if (this._popUpContentManager.isOpen) 
            {
                return;
            }
            if (!this._isValidating && this.isInvalid()) 
            {
                this._isOpenListPending = true;
                return;
            }
            this._isOpenListPending = false;
            if (this._popUpContentManager is feathers.controls.popups.IPopUpContentManagerWithPrompt) 
            {
                feathers.controls.popups.IPopUpContentManagerWithPrompt(this._popUpContentManager).prompt = this._prompt;
            }
            this._popUpContentManager.open(this.list, this);
            this.list.scrollToDisplayIndex(this._selectedIndex);
            this.list.validate();
            if (this._focusManager) 
            {
                this._focusManager.focus = this.list;
                this.stage.addEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
                this.list.addEventListener(feathers.events.FeathersEventType.FOCUS_OUT, this.list_focusOutHandler);
            }
            return;
        }

        public function closeList():void
        {
            this._isOpenListPending = false;
            if (!this._popUpContentManager.isOpen) 
            {
                return;
            }
            if (!this._isValidating && this.isInvalid()) 
            {
                this._isCloseListPending = true;
                return;
            }
            this._isCloseListPending = false;
            this.list.validate();
            this._popUpContentManager.close();
            return;
        }

        public override function dispose():void
        {
            if (this.list) 
            {
                this.closeList();
                this.list.dispose();
                this.list = null;
            }
            if (this._popUpContentManager) 
            {
                this._popUpContentManager.dispose();
                this._popUpContentManager = null;
            }
            this._selectedIndex = -1;
            this.dataProvider = null;
            super.dispose();
            return;
        }

        public override function showFocus():void
        {
            if (!this.button) 
            {
                return;
            }
            this.button.showFocus();
            return;
        }

        public override function hideFocus():void
        {
            if (!this.button) 
            {
                return;
            }
            this.button.hideFocus();
            return;
        }

        protected override function initialize():void
        {
            var loc1:*=null;
            if (this._popUpContentManager === null) 
            {
                loc1 = this.stage === null ? starling.core.Starling.current : this.stage.starling;
                if (starling.utils.SystemUtil.isDesktop) 
                {
                    this._popUpContentManager = new feathers.controls.popups.DropDownPopUpContentManager();
                }
                else if (feathers.system.DeviceCapabilities.isTablet(loc1.nativeStage)) 
                {
                    this._popUpContentManager = new feathers.controls.popups.CalloutPopUpContentManager();
                }
                else 
                {
                    this._popUpContentManager = new feathers.controls.popups.VerticalCenteredPopUpContentManager();
                }
            }
            super.initialize();
            return;
        }

        protected override function draw():void
        {
            var loc8:*=false;
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_SELECTED);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc6:*=this.isInvalid(INVALIDATION_FLAG_BUTTON_FACTORY);
            var loc7:*=this.isInvalid(INVALIDATION_FLAG_LIST_FACTORY);
            if (loc6) 
            {
                this.createButton();
            }
            if (loc7) 
            {
                this.createList();
            }
            if (loc6 || loc2 || loc4) 
            {
                if (this._explicitWidth !== this._explicitWidth) 
                {
                    this.button.width = NaN;
                }
                if (this._explicitHeight !== this._explicitHeight) 
                {
                    this.button.height = NaN;
                }
            }
            if (loc6 || loc2) 
            {
                this.refreshButtonProperties();
            }
            if (loc7 || loc2) 
            {
                this.refreshListProperties();
            }
            if (loc7 || loc1) 
            {
                loc8 = this._ignoreSelectionChanges;
                this._ignoreSelectionChanges = true;
                this.list.dataProvider = this._dataProvider;
                this._ignoreSelectionChanges = loc8;
            }
            if (loc6 || loc7 || loc3) 
            {
                this.button.isEnabled = this._isEnabled;
                this.list.isEnabled = this._isEnabled;
            }
            if (loc6 || loc1 || loc4) 
            {
                this.refreshButtonLabel();
            }
            if (loc7 || loc1 || loc4) 
            {
                loc8 = this._ignoreSelectionChanges;
                this._ignoreSelectionChanges = true;
                this.list.selectedIndex = this._selectedIndex;
                this._ignoreSelectionChanges = loc8;
            }
            this.autoSizeIfNeeded();
            this.layout();
            if (this.list.stage) 
            {
                this.list.validate();
            }
            this.handlePendingActions();
            return;
        }

        protected function autoSizeIfNeeded():Boolean
        {
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            var loc5:*=this._explicitWidth;
            if (loc5 !== loc5) 
            {
                loc5 = this.buttonExplicitWidth;
            }
            var loc6:*=this._explicitHeight;
            if (loc6 !== loc6) 
            {
                loc6 = this.buttonExplicitHeight;
            }
            var loc7:*=this._explicitMinWidth;
            if (loc7 !== loc7) 
            {
                loc7 = this.buttonExplicitMinWidth;
            }
            var loc8:*=this._explicitMinHeight;
            if (loc8 !== loc8) 
            {
                loc8 = this.buttonExplicitMinHeight;
            }
            if (this._typicalItem !== null) 
            {
                this.button.label = this.itemToLabel(this._typicalItem);
            }
            this.button.width = loc5;
            this.button.height = loc6;
            this.button.minWidth = loc7;
            this.button.minHeight = loc8;
            this.button.validate();
            if (this._typicalItem !== null) 
            {
                this.refreshButtonLabel();
            }
            var loc9:*=this._explicitWidth;
            var loc10:*=this._explicitHeight;
            var loc11:*=this._explicitMinWidth;
            var loc12:*=this._explicitMinHeight;
            if (loc1) 
            {
                loc9 = this.button.width;
            }
            if (loc2) 
            {
                loc10 = this.button.height;
            }
            if (loc3) 
            {
                loc11 = this.button.minWidth;
            }
            if (loc4) 
            {
                loc12 = this.button.minHeight;
            }
            return this.saveMeasurements(loc9, loc10, loc11, loc12);
        }

        protected function createButton():void
        {
            if (this.button) 
            {
                this.button.removeFromParent(true);
                this.button = null;
            }
            var loc1:*=this._buttonFactory == null ? defaultButtonFactory : this._buttonFactory;
            var loc2:*=this._customButtonStyleName == null ? this.buttonStyleName : this._customButtonStyleName;
            this.button = feathers.controls.Button(loc1());
            if (this.button is feathers.controls.ToggleButton) 
            {
                feathers.controls.ToggleButton(this.button).isToggle = false;
            }
            this.button.styleNameList.add(loc2);
            this.button.addEventListener(starling.events.TouchEvent.TOUCH, this.button_touchHandler);
            this.button.addEventListener(starling.events.Event.TRIGGERED, this.button_triggeredHandler);
            this.addChild(this.button);
            this.button.initializeNow();
            this.buttonExplicitWidth = this.button.explicitWidth;
            this.buttonExplicitHeight = this.button.explicitHeight;
            this.buttonExplicitMinWidth = this.button.explicitMinWidth;
            this.buttonExplicitMinHeight = this.button.explicitMinHeight;
            return;
        }

        protected function createList():void
        {
            if (this.list) 
            {
                this.list.removeFromParent(false);
                this.list.dispose();
                this.list = null;
            }
            var loc1:*=this._listFactory == null ? defaultListFactory : this._listFactory;
            var loc2:*=this._customListStyleName == null ? this.listStyleName : this._customListStyleName;
            this.list = feathers.controls.List(loc1());
            this.list.focusOwner = this;
            this.list.styleNameList.add(loc2);
            this.list.addEventListener(starling.events.Event.CHANGE, this.list_changeHandler);
            this.list.addEventListener(starling.events.Event.TRIGGERED, this.list_triggeredHandler);
            this.list.addEventListener(starling.events.TouchEvent.TOUCH, this.list_touchHandler);
            this.list.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.list_removedFromStageHandler);
            return;
        }

        protected static const INVALIDATION_FLAG_BUTTON_FACTORY:String="buttonFactory";

        protected static const INVALIDATION_FLAG_LIST_FACTORY:String="listFactory";

        public static const DEFAULT_CHILD_STYLE_NAME_BUTTON:String="feathers-picker-list-button";

        public static const DEFAULT_CHILD_STYLE_NAME_LIST:String="feathers-picker-list-list";

        protected var buttonExplicitWidth:Number;

        protected var buttonExplicitHeight:Number;

        protected var buttonExplicitMinWidth:Number;

        protected var buttonExplicitMinHeight:Number;

        protected var _dataProvider:feathers.data.ListCollection;

        protected var _ignoreSelectionChanges:Boolean=false;

        protected var _selectedIndex:int=-1;

        protected var _prompt:String;

        protected var _labelField:String="label";

        protected var _labelFunction:Function;

        protected var _popUpContentManager:feathers.controls.popups.IPopUpContentManager;

        protected var _typicalItem:Object=null;

        protected var _buttonFactory:Function;

        protected var _customButtonStyleName:String;

        protected var _buttonProperties:feathers.core.PropertyProxy;

        protected var _listFactory:Function;

        protected var _customListStyleName:String;

        protected var _listProperties:feathers.core.PropertyProxy;

        protected var _buttonHasFocus:Boolean=false;

        protected var _buttonTouchPointID:int=-1;

        protected var _listIsOpenOnTouchBegan:Boolean=false;

        protected var _triggered:Boolean=false;

        protected var _isOpenListPending:Boolean=false;

        protected var buttonStyleName:String="feathers-picker-list-button";

        protected var listStyleName:String="feathers-picker-list-list";

        protected var button:feathers.controls.Button;

        protected var list:feathers.controls.List;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var _isCloseListPending:Boolean=false;

        protected var _toggleButtonOnOpenAndClose:Boolean=false;
    }
}


