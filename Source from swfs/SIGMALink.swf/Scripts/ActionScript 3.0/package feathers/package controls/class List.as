//class List
package feathers.controls 
{
    import __AS3__.vec.*;
    import feathers.controls.renderers.*;
    import feathers.controls.supportClasses.*;
    import feathers.core.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import flash.geom.*;
    import flash.ui.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class List extends feathers.controls.Scroller implements feathers.core.IFocusContainer
    {
        public function List()
        {
            this._selectedIndices = new feathers.data.ListCollection(new Vector.<int>(0));
            this._itemRendererType = feathers.controls.renderers.DefaultListItemRenderer;
            super();
            this._selectedIndices.addEventListener(starling.events.Event.CHANGE, this.selectedIndices_changeHandler);
            return;
        }

        public override function dispose():void
        {
            this._selectedIndices.removeEventListeners();
            this._selectedIndex = -1;
            this.dataProvider = null;
            this.layout = null;
            super.dispose();
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.List.globalStyleProvider;
        }

        public override function get isFocusEnabled():Boolean
        {
            return (this._isSelectable || !(this._minHorizontalScrollPosition == this._maxHorizontalScrollPosition) || !(this._minVerticalScrollPosition == this._maxVerticalScrollPosition)) && this._isEnabled && this._isFocusEnabled;
        }

        protected override function initialize():void
        {
            var loc2:*=null;
            var loc1:*=!(this._layout === null);
            super.initialize();
            if (!this.dataViewPort) 
            {
                var loc3:*;
                this.dataViewPort = loc3 = new feathers.controls.supportClasses.ListDataViewPort();
                this.viewPort = loc3;
                this.dataViewPort.owner = this;
                this.viewPort = this.dataViewPort;
            }
            if (!loc1) 
            {
                if (this._hasElasticEdges && this._verticalScrollPolicy === feathers.controls.ScrollPolicy.AUTO && !(this._scrollBarDisplayMode === feathers.controls.ScrollBarDisplayMode.FIXED)) 
                {
                    this._verticalScrollPolicy = feathers.controls.ScrollPolicy.ON;
                }
                loc2 = new feathers.layout.VerticalLayout();
                loc2.useVirtualLayout = true;
                loc2.padding = 0;
                loc2.gap = 0;
                loc2.horizontalAlign = feathers.layout.HorizontalAlign.JUSTIFY;
                loc2.verticalAlign = feathers.layout.VerticalAlign.TOP;
                this._layout = loc2;
            }
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

        protected override function draw():void
        {
            this.refreshDataViewPortProperties();
            super.draw();
            return;
        }

        public function get layout():feathers.layout.ILayout
        {
            return this._layout;
        }

        public function set layout(arg1:feathers.layout.ILayout):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._layout == arg1) 
            {
                return;
            }
            if (!(this is feathers.controls.SpinnerList) && arg1 is feathers.layout.ISpinnerLayout) 
            {
                throw new ArgumentError("Layouts that implement the ISpinnerLayout interface should be used with the SpinnerList component.");
            }
            if (this._layout) 
            {
                this._layout.removeEventListener(starling.events.Event.SCROLL, this.layout_scrollHandler);
            }
            this._layout = arg1;
            if (this._layout is feathers.layout.IVariableVirtualLayout) 
            {
                this._layout.addEventListener(starling.events.Event.SCROLL, this.layout_scrollHandler);
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        protected function refreshDataViewPortProperties():void
        {
            this.dataViewPort.isSelectable = this._isSelectable;
            this.dataViewPort.allowMultipleSelection = this._allowMultipleSelection;
            this.dataViewPort.selectedIndices = this._selectedIndices;
            this.dataViewPort.dataProvider = this._dataProvider;
            this.dataViewPort.itemRendererType = this._itemRendererType;
            this.dataViewPort.itemRendererFactory = this._itemRendererFactory;
            this.dataViewPort.itemRendererFactories = this._itemRendererFactories;
            this.dataViewPort.factoryIDFunction = this._factoryIDFunction;
            this.dataViewPort.itemRendererProperties = this._itemRendererProperties;
            this.dataViewPort.customItemRendererStyleName = this._customItemRendererStyleName;
            this.dataViewPort.typicalItem = this._typicalItem;
            this.dataViewPort.layout = this._layout;
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
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.ADD_ITEM, this.dataProvider_addItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.REMOVE_ITEM, this.dataProvider_removeItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.REPLACE_ITEM, this.dataProvider_replaceItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.RESET, this.dataProvider_resetHandler);
                this._dataProvider.removeEventListener(starling.events.Event.CHANGE, this.dataProvider_changeHandler);
            }
            this._dataProvider = arg1;
            if (this._dataProvider) 
            {
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.ADD_ITEM, this.dataProvider_addItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.REMOVE_ITEM, this.dataProvider_removeItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.REPLACE_ITEM, this.dataProvider_replaceItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.RESET, this.dataProvider_resetHandler);
                this._dataProvider.addEventListener(starling.events.Event.CHANGE, this.dataProvider_changeHandler);
            }
            this.horizontalScrollPosition = 0;
            this.verticalScrollPosition = 0;
            this.selectedIndex = -1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected override function handlePendingScroll():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=NaN;
            var loc4:*=NaN;
            if (this.pendingItemIndex >= 0) 
            {
                loc1 = null;
                if (this._dataProvider !== null) 
                {
                    loc1 = this._dataProvider.getItemAt(this.pendingItemIndex);
                }
                if (loc1 is Object) 
                {
                    loc2 = starling.utils.Pool.getPoint();
                    this.dataViewPort.getScrollPositionForIndex(this.pendingItemIndex, loc2);
                    this.pendingItemIndex = -1;
                    loc3 = loc2.x;
                    loc4 = loc2.y;
                    starling.utils.Pool.putPoint(loc2);
                    if (loc3 < this._minHorizontalScrollPosition) 
                    {
                        loc3 = this._minHorizontalScrollPosition;
                    }
                    else if (loc3 > this._maxHorizontalScrollPosition) 
                    {
                        loc3 = this._maxHorizontalScrollPosition;
                    }
                    if (loc4 < this._minVerticalScrollPosition) 
                    {
                        loc4 = this._minVerticalScrollPosition;
                    }
                    else if (loc4 > this._maxVerticalScrollPosition) 
                    {
                        loc4 = this._maxVerticalScrollPosition;
                    }
                    this.throwTo(loc3, loc4, this.pendingScrollDuration);
                }
            }
            super.handlePendingScroll();
            return;
        }

        public function get isSelectable():Boolean
        {
            return this._isSelectable;
        }

        public function set isSelectable(arg1:Boolean):void
        {
            if (this._isSelectable == arg1) 
            {
                return;
            }
            this._isSelectable = arg1;
            if (!this._isSelectable) 
            {
                this.selectedIndex = -1;
            }
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        protected override function stage_keyDownHandler(arg1:starling.events.KeyboardEvent):void
        {
            var loc2:*=null;
            if (!this._dataProvider) 
            {
                return;
            }
            var loc1:*=false;
            if (arg1.keyCode != flash.ui.Keyboard.HOME) 
            {
                if (arg1.keyCode != flash.ui.Keyboard.END) 
                {
                    if (arg1.keyCode != flash.ui.Keyboard.UP) 
                    {
                        if (arg1.keyCode == flash.ui.Keyboard.DOWN) 
                        {
                            this.selectedIndex = Math.min((this._dataProvider.length - 1), this._selectedIndex + 1);
                            loc1 = true;
                        }
                    }
                    else 
                    {
                        this.selectedIndex = Math.max(0, (this._selectedIndex - 1));
                        loc1 = true;
                    }
                }
                else 
                {
                    this.selectedIndex = (this._dataProvider.length - 1);
                    loc1 = true;
                }
            }
            else if (this._dataProvider.length > 0) 
            {
                this.selectedIndex = 0;
                loc1 = true;
            }
            if (loc1) 
            {
                loc2 = starling.utils.Pool.getPoint();
                this.dataViewPort.getNearestScrollPositionForIndex(this.selectedIndex, loc2);
                this.scrollToPosition(loc2.x, loc2.y, this._keyScrollDuration);
                starling.utils.Pool.putPoint(loc2);
            }
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
            if (arg1 >= 0) 
            {
                new Vector.<int>(1)[0] = arg1;
                this._selectedIndices.data = new Vector.<int>(1);
            }
            else 
            {
                this._selectedIndices.removeAll();
            }
            this.invalidate(INVALIDATION_FLAG_SELECTED);
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

        protected function dataProvider_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get allowMultipleSelection():Boolean
        {
            return this._allowMultipleSelection;
        }

        public function set allowMultipleSelection(arg1:Boolean):void
        {
            if (this._allowMultipleSelection == arg1) 
            {
                return;
            }
            this._allowMultipleSelection = arg1;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        protected function dataProvider_resetHandler(arg1:starling.events.Event):void
        {
            this.horizontalScrollPosition = 0;
            this.verticalScrollPosition = 0;
            this._selectedIndices.removeAll();
            return;
        }

        public function get selectedIndices():__AS3__.vec.Vector.<int>
        {
            return this._selectedIndices.data as Vector.<int>;
        }

        public function set selectedIndices(arg1:__AS3__.vec.Vector.<int>):void
        {
            var loc1:*=this._selectedIndices.data as Vector.<int>;
            if (loc1 == arg1) 
            {
                return;
            }
            if (arg1) 
            {
                if (!this._allowMultipleSelection && arg1.length > 0) 
                {
                    arg1.length = 1;
                }
                this._selectedIndices.data = arg1;
            }
            else 
            {
                if (this._selectedIndices.length == 0) 
                {
                    return;
                }
                this._selectedIndices.removeAll();
            }
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        public function get selectedItems():__AS3__.vec.Vector.<Object>
        {
            return this.getSelectedItems(new Vector.<Object>(0));
        }

        public function set selectedItems(arg1:__AS3__.vec.Vector.<Object>):void
        {
            var loc4:*=null;
            var loc5:*=0;
            if (!arg1 || !this._dataProvider) 
            {
                this.selectedIndex = -1;
                return;
            }
            var loc1:*=new Vector.<int>(0);
            var loc2:*=arg1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = arg1[loc3];
                loc5 = this._dataProvider.getItemIndex(loc4);
                if (loc5 >= 0) 
                {
                    loc1.push(loc5);
                }
                ++loc3;
            }
            this.selectedIndices = loc1;
            return;
        }

        public function getSelectedItems(arg1:__AS3__.vec.Vector.<Object>=null):__AS3__.vec.Vector.<Object>
        {
            var loc3:*=0;
            var loc4:*=null;
            if (arg1) 
            {
                arg1.length = 0;
            }
            else 
            {
                arg1 = new Vector.<Object>(0);
            }
            if (!this._dataProvider) 
            {
                return arg1;
            }
            var loc1:*=this._selectedIndices.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._selectedIndices.getItemAt(loc2) as int;
                loc4 = this._dataProvider.getItemAt(loc3);
                arg1[loc2] = loc4;
                ++loc2;
            }
            return arg1;
        }

        protected function dataProvider_addItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            var loc5:*=0;
            if (this._selectedIndex == -1) 
            {
                return;
            }
            var loc1:*=false;
            var loc2:*=new Vector.<int>(0);
            var loc3:*=this._selectedIndices.length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc5 = this._selectedIndices.getItemAt(loc4) as int;
                if (loc5 >= arg2) 
                {
                    ++loc5;
                    loc1 = true;
                }
                loc2.push(loc5);
                ++loc4;
            }
            if (loc1) 
            {
                this._selectedIndices.data = loc2;
            }
            return;
        }

        public function get itemRendererType():Class
        {
            return this._itemRendererType;
        }

        public function set itemRendererType(arg1:Class):void
        {
            if (this._itemRendererType == arg1) 
            {
                return;
            }
            this._itemRendererType = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get customItemRendererStyleName():String
        {
            return this._customItemRendererStyleName;
        }

        protected function dataProvider_removeItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            var loc5:*=0;
            if (this._selectedIndex == -1) 
            {
                return;
            }
            var loc1:*=false;
            var loc2:*=new Vector.<int>(0);
            var loc3:*=this._selectedIndices.length;
            var loc4:*=0;
            while (loc4 < loc3) 
            {
                loc5 = this._selectedIndices.getItemAt(loc4) as int;
                if (loc5 != arg2) 
                {
                    if (loc5 > arg2) 
                    {
                        --loc5;
                        loc1 = true;
                    }
                    loc2.push(loc5);
                }
                else 
                {
                    loc1 = true;
                }
                ++loc4;
            }
            if (loc1) 
            {
                this._selectedIndices.data = loc2;
            }
            return;
        }

        public function get itemRendererFactory():Function
        {
            return this._itemRendererFactory;
        }

        public function set itemRendererFactory(arg1:Function):void
        {
            if (this._itemRendererFactory === arg1) 
            {
                return;
            }
            this._itemRendererFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function dataProvider_replaceItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            if (this._selectedIndex == -1) 
            {
                return;
            }
            var loc1:*=this._selectedIndices.getItemIndex(arg2);
            if (loc1 >= 0) 
            {
                this._selectedIndices.removeItemAt(loc1);
            }
            return;
        }

        public function get factoryIDFunction():Function
        {
            return this._factoryIDFunction;
        }

        public function set factoryIDFunction(arg1:Function):void
        {
            if (this._factoryIDFunction === arg1) 
            {
                return;
            }
            this._factoryIDFunction = arg1;
            if (!(arg1 === null) && this._itemRendererFactories === null) 
            {
                this._itemRendererFactories = {};
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function selectedIndices_changeHandler(arg1:starling.events.Event):void
        {
            if (this._selectedIndices.length > 0) 
            {
                this._selectedIndex = this._selectedIndices.getItemAt(0) as int;
            }
            else 
            {
                if (this._selectedIndex < 0) 
                {
                    return;
                }
                this._selectedIndex = -1;
            }
            this.dispatchEventWith(starling.events.Event.CHANGE);
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
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        internal function layout_scrollHandler(arg1:starling.events.Event, arg2:flash.geom.Point):void
        {
            var loc1:*=feathers.layout.IVariableVirtualLayout(this._layout);
            if (!this.isScrolling || !loc1.useVirtualLayout || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            var loc2:*=arg2.x;
            this._startHorizontalScrollPosition = this._startHorizontalScrollPosition + loc2;
            this._horizontalScrollPosition = this._horizontalScrollPosition + loc2;
            if (this._horizontalAutoScrollTween) 
            {
                this._targetHorizontalScrollPosition = this._targetHorizontalScrollPosition + loc2;
                this.throwTo(this._targetHorizontalScrollPosition, NaN, this._horizontalAutoScrollTween.totalTime - this._horizontalAutoScrollTween.currentTime);
            }
            var loc3:*=arg2.y;
            this._startVerticalScrollPosition = this._startVerticalScrollPosition + loc3;
            this._verticalScrollPosition = this._verticalScrollPosition + loc3;
            if (this._verticalAutoScrollTween) 
            {
                this._targetVerticalScrollPosition = this._targetVerticalScrollPosition + loc3;
                this.throwTo(NaN, this._targetVerticalScrollPosition, this._verticalAutoScrollTween.totalTime - this._verticalAutoScrollTween.currentTime);
            }
            return;
        }

        public function scrollToDisplayIndex(arg1:int, arg2:Number=0):void
        {
            this.hasPendingHorizontalPageIndex = false;
            this.hasPendingVerticalPageIndex = false;
            this.pendingHorizontalScrollPosition = NaN;
            this.pendingVerticalScrollPosition = NaN;
            if (this.pendingItemIndex == arg1 && this.pendingScrollDuration == arg2) 
            {
                return;
            }
            this.pendingItemIndex = arg1;
            this.pendingScrollDuration = arg2;
            this.invalidate(INVALIDATION_FLAG_PENDING_SCROLL);
            return;
        }

        public function set customItemRendererStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customItemRendererStyleName === arg1) 
            {
                return;
            }
            this._customItemRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get itemRendererProperties():Object
        {
            if (!this._itemRendererProperties) 
            {
                this._itemRendererProperties = new feathers.core.PropertyProxy(childProperties_onChange);
            }
            return this._itemRendererProperties;
        }

        public function set itemRendererProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._itemRendererProperties == arg1) 
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
            if (this._itemRendererProperties) 
            {
                this._itemRendererProperties.removeOnChangeCallback(childProperties_onChange);
            }
            this._itemRendererProperties = feathers.core.PropertyProxy(arg1);
            if (this._itemRendererProperties) 
            {
                this._itemRendererProperties.addOnChangeCallback(childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get keyScrollDuration():Number
        {
            return this._keyScrollDuration;
        }

        public function set keyScrollDuration(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._keyScrollDuration = arg1;
            return;
        }

        public override function scrollToPosition(arg1:Number, arg2:Number, arg3:Number=NaN):void
        {
            this.pendingItemIndex = -1;
            super.scrollToPosition(arg1, arg2, arg3);
            return;
        }

        public override function scrollToPageIndex(arg1:int, arg2:int, arg3:Number=NaN):void
        {
            this.pendingItemIndex = -1;
            super.scrollToPageIndex(arg1, arg2, arg3);
            return;
        }

        public function getItemRendererFactoryWithID(arg1:String):Function
        {
            if (this._itemRendererFactories && arg1 in this._itemRendererFactories) 
            {
                return this._itemRendererFactories[arg1] as Function;
            }
            return null;
        }

        public function setItemRendererFactoryWithID(arg1:String, arg2:Function):void
        {
            if (arg1 === null) 
            {
                this.itemRendererFactory = arg2;
                return;
            }
            if (this._itemRendererFactories === null) 
            {
                this._itemRendererFactories = {};
            }
            if (arg2 === null) 
            {
                delete this._itemRendererFactories[arg1];
            }
            else 
            {
                this._itemRendererFactories[arg1] = arg2;
            }
            return;
        }

        public function itemToItemRenderer(arg1:Object):feathers.controls.renderers.IListItemRenderer
        {
            return this.dataViewPort.itemToItemRenderer(arg1);
        }

        public static const SCROLL_POLICY_AUTO:String="auto";

        public static const SCROLL_POLICY_ON:String="on";

        public static const SCROLL_POLICY_OFF:String="off";

        public static const SCROLL_BAR_DISPLAY_MODE_FLOAT:String="float";

        public static const SCROLL_BAR_DISPLAY_MODE_FIXED:String="fixed";

        public static const SCROLL_BAR_DISPLAY_MODE_FIXED_FLOAT:String="fixedFloat";

        public static const SCROLL_BAR_DISPLAY_MODE_NONE:String="none";

        public static const VERTICAL_SCROLL_BAR_POSITION_RIGHT:String="right";

        public static const VERTICAL_SCROLL_BAR_POSITION_LEFT:String="left";

        public static const INTERACTION_MODE_TOUCH:String="touch";

        public static const INTERACTION_MODE_MOUSE:String="mouse";

        public static const INTERACTION_MODE_TOUCH_AND_SCROLL_BARS:String="touchAndScrollBars";

        public static const MOUSE_WHEEL_SCROLL_DIRECTION_VERTICAL:String="vertical";

        public static const MOUSE_WHEEL_SCROLL_DIRECTION_HORIZONTAL:String="horizontal";

        public static const DECELERATION_RATE_NORMAL:Number=0.998;

        public static const DECELERATION_RATE_FAST:Number=0.99;

        protected var _itemRendererFactories:Object;

        protected var dataViewPort:feathers.controls.supportClasses.ListDataViewPort;

        protected var _isChildFocusEnabled:Boolean=true;

        protected var _layout:feathers.layout.ILayout;

        protected var _dataProvider:feathers.data.ListCollection;

        protected var _isSelectable:Boolean=true;

        protected var _selectedIndex:int=-1;

        protected var _allowMultipleSelection:Boolean=false;

        protected var _selectedIndices:feathers.data.ListCollection;

        protected var _itemRendererType:Class;

        protected var _itemRendererFactory:Function;

        protected var _factoryIDFunction:Function;

        protected var _typicalItem:Object=null;

        protected var _customItemRendererStyleName:String;

        protected var pendingItemIndex:int=-1;

        protected var _itemRendererProperties:feathers.core.PropertyProxy;

        protected var _keyScrollDuration:Number=0.25;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


