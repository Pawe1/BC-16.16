//class GroupedList
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
    
    public class GroupedList extends feathers.controls.Scroller implements feathers.core.IFocusContainer
    {
        public function GroupedList()
        {
            this._itemRendererType = feathers.controls.renderers.DefaultGroupedListItemRenderer;
            this._headerRendererType = feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
            this._footerRendererType = feathers.controls.renderers.DefaultGroupedListHeaderOrFooterRenderer;
            super();
            return;
        }

        public function get keyScrollDuration():Number
        {
            return this._keyScrollDuration;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.GroupedList.globalStyleProvider;
        }

        public override function get isFocusEnabled():Boolean
        {
            return (this._isSelectable || !(this._minHorizontalScrollPosition == this._maxHorizontalScrollPosition) || !(this._minVerticalScrollPosition == this._maxVerticalScrollPosition)) && this._isEnabled && this._isFocusEnabled;
        }

        public function set keyScrollDuration(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._keyScrollDuration === arg1) 
            {
                return;
            }
            this._keyScrollDuration = arg1;
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

        public override function dispose():void
        {
            this._selectedGroupIndex = -1;
            this._selectedItemIndex = -1;
            this.dataProvider = null;
            this.layout = null;
            super.dispose();
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

        public override function scrollToPosition(arg1:Number, arg2:Number, arg3:Number=NaN):void
        {
            this.pendingItemIndex = -1;
            super.scrollToPosition(arg1, arg2, arg3);
            return;
        }

        public function get dataProvider():feathers.data.HierarchicalCollection
        {
            return this._dataProvider;
        }

        public function set dataProvider(arg1:feathers.data.HierarchicalCollection):void
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
            this.setSelectedLocation(-1, -1);
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public override function scrollToPageIndex(arg1:int, arg2:int, arg3:Number=NaN):void
        {
            this.pendingGroupIndex = -1;
            this.pendingItemIndex = -1;
            super.scrollToPageIndex(arg1, arg2, arg3);
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
                this.setSelectedLocation(-1, -1);
            }
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        public function scrollToDisplayIndex(arg1:int, arg2:int=-1, arg3:Number=0):void
        {
            this.hasPendingHorizontalPageIndex = false;
            this.hasPendingVerticalPageIndex = false;
            this.pendingHorizontalScrollPosition = NaN;
            this.pendingVerticalScrollPosition = NaN;
            if (this.pendingGroupIndex == arg1 && this.pendingItemIndex == arg2 && this.pendingScrollDuration == arg3) 
            {
                return;
            }
            this.pendingGroupIndex = arg1;
            this.pendingItemIndex = arg2;
            this.pendingScrollDuration = arg3;
            this.invalidate(INVALIDATION_FLAG_PENDING_SCROLL);
            return;
        }

        public function get selectedGroupIndex():int
        {
            return this._selectedGroupIndex;
        }

        public function setSelectedLocation(arg1:int, arg2:int):void
        {
            if (this._selectedGroupIndex == arg1 && this._selectedItemIndex == arg2) 
            {
                return;
            }
            if (arg1 < 0 && arg2 >= 0 || arg1 >= 0 && arg2 < 0) 
            {
                throw new ArgumentError("To deselect items, group index and item index must both be < 0.");
            }
            this._selectedGroupIndex = arg1;
            this._selectedItemIndex = arg2;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        public function get selectedItemIndex():int
        {
            return this._selectedItemIndex;
        }

        public function get selectedItem():Object
        {
            if (!this._dataProvider || this._selectedGroupIndex < 0 || this._selectedItemIndex < 0) 
            {
                return null;
            }
            return this._dataProvider.getItemAt(this._selectedGroupIndex, this._selectedItemIndex);
        }

        public function set selectedItem(arg1:Object):void
        {
            if (!this._dataProvider) 
            {
                this.setSelectedLocation(-1, -1);
                return;
            }
            var loc1:*=this._dataProvider.getItemLocation(arg1);
            if (loc1.length != 2) 
            {
                this.setSelectedLocation(-1, -1);
            }
            else 
            {
                this.setSelectedLocation(loc1[0], loc1[1]);
            }
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

        public function getHeaderRendererFactoryWithID(arg1:String):Function
        {
            if (this._headerRendererFactories && arg1 in this._headerRendererFactories) 
            {
                return this._headerRendererFactories[arg1] as Function;
            }
            return null;
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

        public function setHeaderRendererFactoryWithID(arg1:String, arg2:Function):void
        {
            if (arg1 === null) 
            {
                this.headerRendererFactory = arg2;
                return;
            }
            if (this._headerRendererFactories === null) 
            {
                this._headerRendererFactories = {};
            }
            if (arg2 === null) 
            {
                delete this._headerRendererFactories[arg1];
            }
            else 
            {
                this._headerRendererFactories[arg1] = arg2;
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

        public function getFooterRendererFactoryWithID(arg1:String):Function
        {
            if (this._footerRendererFactories && arg1 in this._footerRendererFactories) 
            {
                return this._footerRendererFactories[arg1] as Function;
            }
            return null;
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

        public function setFooterRendererFactoryWithID(arg1:String, arg2:Function):void
        {
            if (arg1 === null) 
            {
                this.footerRendererFactory = arg2;
                return;
            }
            if (this._footerRendererFactories === null) 
            {
                this._footerRendererFactories = {};
            }
            if (arg2 === null) 
            {
                delete this._footerRendererFactories[arg1];
            }
            else 
            {
                this._footerRendererFactories[arg1] = arg2;
            }
            return;
        }

        public function get customItemRendererStyleName():String
        {
            return this._customItemRendererStyleName;
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

        public function groupToHeaderData(arg1:Object):Object
        {
            if (this._headerFunction != null) 
            {
                return this._headerFunction(arg1);
            }
            if (!(this._headerField == null) && arg1 && arg1.hasOwnProperty(this._headerField)) 
            {
                return arg1[this._headerField];
            }
            return null;
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

        public function groupToFooterData(arg1:Object):Object
        {
            if (this._footerFunction != null) 
            {
                return this._footerFunction(arg1);
            }
            if (!(this._footerField == null) && arg1 && arg1.hasOwnProperty(this._footerField)) 
            {
                return arg1[this._footerField];
            }
            return null;
        }

        public function get firstItemRendererType():Class
        {
            return this._firstItemRendererType;
        }

        public function set firstItemRendererType(arg1:Class):void
        {
            if (this._firstItemRendererType == arg1) 
            {
                return;
            }
            this._firstItemRendererType = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function itemToItemRenderer(arg1:Object):feathers.controls.renderers.IGroupedListItemRenderer
        {
            return this.dataViewPort.itemToItemRenderer(arg1);
        }

        public function get firstItemRendererFactory():Function
        {
            return this._firstItemRendererFactory;
        }

        public function set firstItemRendererFactory(arg1:Function):void
        {
            if (this._firstItemRendererFactory === arg1) 
            {
                return;
            }
            this._firstItemRendererFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function headerDataToHeaderRenderer(arg1:Object):feathers.controls.renderers.IGroupedListHeaderRenderer
        {
            return this.dataViewPort.headerDataToHeaderRenderer(arg1);
        }

        public function get customFirstItemRendererStyleName():String
        {
            return this._customFirstItemRendererStyleName;
        }

        public function set customFirstItemRendererStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customFirstItemRendererStyleName === arg1) 
            {
                return;
            }
            this._customFirstItemRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function footerDataToFooterRenderer(arg1:Object):feathers.controls.renderers.IGroupedListFooterRenderer
        {
            return this.dataViewPort.footerDataToFooterRenderer(arg1);
        }

        public function get lastItemRendererType():Class
        {
            return this._lastItemRendererType;
        }

        public function set lastItemRendererType(arg1:Class):void
        {
            if (this._lastItemRendererType == arg1) 
            {
                return;
            }
            this._lastItemRendererType = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function initialize():void
        {
            var loc2:*=null;
            var loc1:*=!(this._layout === null);
            super.initialize();
            if (!this.dataViewPort) 
            {
                var loc3:*;
                this.dataViewPort = loc3 = new feathers.controls.supportClasses.GroupedListDataViewPort();
                this.viewPort = loc3;
                this.dataViewPort.owner = this;
                this.dataViewPort.addEventListener(starling.events.Event.CHANGE, this.dataViewPort_changeHandler);
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
                loc2.stickyHeader = !this._styleNameList.contains(ALTERNATE_STYLE_NAME_INSET_GROUPED_LIST);
                this._layout = loc2;
            }
            return;
        }

        public function get lastItemRendererFactory():Function
        {
            return this._lastItemRendererFactory;
        }

        public function set lastItemRendererFactory(arg1:Function):void
        {
            if (this._lastItemRendererFactory === arg1) 
            {
                return;
            }
            this._lastItemRendererFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function draw():void
        {
            this.refreshDataViewPortProperties();
            super.draw();
            return;
        }

        public function get customLastItemRendererStyleName():String
        {
            return this._customLastItemRendererStyleName;
        }

        public function set customLastItemRendererStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customLastItemRendererStyleName === arg1) 
            {
                return;
            }
            this._customLastItemRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshDataViewPortProperties():void
        {
            this.dataViewPort.isSelectable = this._isSelectable;
            this.dataViewPort.setSelectedLocation(this._selectedGroupIndex, this._selectedItemIndex);
            this.dataViewPort.dataProvider = this._dataProvider;
            this.dataViewPort.typicalItem = this._typicalItem;
            this.dataViewPort.itemRendererType = this._itemRendererType;
            this.dataViewPort.itemRendererFactory = this._itemRendererFactory;
            this.dataViewPort.itemRendererFactories = this._itemRendererFactories;
            this.dataViewPort.factoryIDFunction = this._factoryIDFunction;
            this.dataViewPort.itemRendererProperties = this._itemRendererProperties;
            this.dataViewPort.customItemRendererStyleName = this._customItemRendererStyleName;
            this.dataViewPort.firstItemRendererType = this._firstItemRendererType;
            this.dataViewPort.firstItemRendererFactory = this._firstItemRendererFactory;
            this.dataViewPort.customFirstItemRendererStyleName = this._customFirstItemRendererStyleName;
            this.dataViewPort.lastItemRendererType = this._lastItemRendererType;
            this.dataViewPort.lastItemRendererFactory = this._lastItemRendererFactory;
            this.dataViewPort.customLastItemRendererStyleName = this._customLastItemRendererStyleName;
            this.dataViewPort.singleItemRendererType = this._singleItemRendererType;
            this.dataViewPort.singleItemRendererFactory = this._singleItemRendererFactory;
            this.dataViewPort.customSingleItemRendererStyleName = this._customSingleItemRendererStyleName;
            this.dataViewPort.headerRendererType = this._headerRendererType;
            this.dataViewPort.headerRendererFactory = this._headerRendererFactory;
            this.dataViewPort.headerRendererFactories = this._headerRendererFactories;
            this.dataViewPort.headerFactoryIDFunction = this._headerFactoryIDFunction;
            this.dataViewPort.headerRendererProperties = this._headerRendererProperties;
            this.dataViewPort.customHeaderRendererStyleName = this._customHeaderRendererStyleName;
            this.dataViewPort.footerRendererType = this._footerRendererType;
            this.dataViewPort.footerRendererFactory = this._footerRendererFactory;
            this.dataViewPort.footerRendererFactories = this._footerRendererFactories;
            this.dataViewPort.footerFactoryIDFunction = this._footerFactoryIDFunction;
            this.dataViewPort.footerRendererProperties = this._footerRendererProperties;
            this.dataViewPort.customFooterRendererStyleName = this._customFooterRendererStyleName;
            this.dataViewPort.layout = this._layout;
            return;
        }

        public function get singleItemRendererType():Class
        {
            return this._singleItemRendererType;
        }

        public function set singleItemRendererType(arg1:Class):void
        {
            if (this._singleItemRendererType == arg1) 
            {
                return;
            }
            this._singleItemRendererType = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function handlePendingScroll():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=NaN;
            var loc4:*=NaN;
            if (this.pendingGroupIndex >= 0) 
            {
                loc1 = null;
                if (this._dataProvider !== null) 
                {
                    if (this.pendingItemIndex >= 0) 
                    {
                        loc1 = this._dataProvider.getItemAt(this.pendingGroupIndex, this.pendingItemIndex);
                    }
                    else 
                    {
                        loc1 = this._dataProvider.getItemAt(this.pendingGroupIndex);
                    }
                }
                if (loc1 is Object) 
                {
                    loc2 = starling.utils.Pool.getPoint();
                    this.dataViewPort.getScrollPositionForIndex(this.pendingGroupIndex, this.pendingItemIndex, loc2);
                    this.pendingGroupIndex = -1;
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

        public function get singleItemRendererFactory():Function
        {
            return this._singleItemRendererFactory;
        }

        public function set singleItemRendererFactory(arg1:Function):void
        {
            if (this._singleItemRendererFactory === arg1) 
            {
                return;
            }
            this._singleItemRendererFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function stage_keyDownHandler(arg1:starling.events.KeyboardEvent):void
        {
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=null;
            if (!this._dataProvider) 
            {
                return;
            }
            var loc1:*=false;
            if (arg1.keyCode == flash.ui.Keyboard.HOME) 
            {
                if (this._dataProvider.getLength() > 0 && this._dataProvider.getLength(0) > 0) 
                {
                    this.setSelectedLocation(0, 0);
                    loc1 = true;
                }
            }
            if (arg1.keyCode != flash.ui.Keyboard.END) 
            {
                if (arg1.keyCode != flash.ui.Keyboard.UP) 
                {
                    if (arg1.keyCode == flash.ui.Keyboard.DOWN) 
                    {
                        loc2 = this._selectedGroupIndex;
                        if (loc2 < 0) 
                        {
                            loc3 = -1;
                        }
                        else 
                        {
                            loc3 = this._selectedItemIndex + 1;
                        }
                        if (loc2 < 0 || loc3 >= this._dataProvider.getLength(loc2)) 
                        {
                            loc3 = -1;
                            ++loc2;
                            loc4 = this._dataProvider.getLength();
                            while (loc2 < loc4 && loc3 < 0) 
                            {
                                if (this._dataProvider.getLength(loc2) > 0) 
                                {
                                    loc3 = 0;
                                    continue;
                                }
                                ++loc2;
                            }
                        }
                        if (loc2 >= 0 && loc3 >= 0) 
                        {
                            this.setSelectedLocation(loc2, loc3);
                            loc1 = true;
                        }
                    }
                }
                else 
                {
                    loc2 = this._selectedGroupIndex;
                    loc3 = (this._selectedItemIndex - 1);
                    if (loc3 < 0) 
                    {
                        do 
                        {
                            --loc2;
                            if (loc2 >= 0) 
                            {
                                loc3 = (this._dataProvider.getLength(loc2) - 1);
                            }
                        }
                        while (loc2 > 0 && loc3 < 0);
                    }
                    if (loc2 >= 0 && loc3 >= 0) 
                    {
                        this.setSelectedLocation(loc2, loc3);
                        loc1 = true;
                    }
                }
            }
            else 
            {
                loc2 = this._dataProvider.getLength();
                loc3 = -1;
                do 
                {
                    --loc2;
                    if (loc2 >= 0) 
                    {
                        loc3 = (this._dataProvider.getLength(loc2) - 1);
                    }
                }
                while (loc2 > 0 && loc3 < 0);
                if (loc2 >= 0 && loc3 >= 0) 
                {
                    this.setSelectedLocation(loc2, loc3);
                    loc1 = true;
                }
            }
            if (loc1) 
            {
                loc5 = starling.utils.Pool.getPoint();
                this.dataViewPort.getNearestScrollPositionForIndex(this._selectedGroupIndex, this.selectedItemIndex, loc5);
                this.scrollToPosition(loc5.x, loc5.y, this._keyScrollDuration);
                starling.utils.Pool.putPoint(loc5);
            }
            return;
        }

        public function get customSingleItemRendererStyleName():String
        {
            return this._customSingleItemRendererStyleName;
        }

        public function set customSingleItemRendererStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customSingleItemRendererStyleName === arg1) 
            {
                return;
            }
            this._customSingleItemRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function dataProvider_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get headerRendererType():Class
        {
            return this._headerRendererType;
        }

        public function set headerRendererType(arg1:Class):void
        {
            if (this._headerRendererType == arg1) 
            {
                return;
            }
            this._headerRendererType = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function dataProvider_resetHandler(arg1:starling.events.Event):void
        {
            this.horizontalScrollPosition = 0;
            this.verticalScrollPosition = 0;
            this.setSelectedLocation(-1, -1);
            return;
        }

        protected function dataProvider_addItemHandler(arg1:starling.events.Event, arg2:Array):void
        {
            var loc2:*=0;
            if (this._selectedGroupIndex == -1) 
            {
                return;
            }
            var loc1:*=arg2[0] as int;
            if (arg2.length > 1) 
            {
                loc2 = arg2[1] as int;
                if (this._selectedGroupIndex == loc1 && this._selectedItemIndex >= loc2) 
                {
                    this.setSelectedLocation(this._selectedGroupIndex, this._selectedItemIndex + 1);
                }
            }
            else 
            {
                this.setSelectedLocation(this._selectedGroupIndex + 1, this._selectedItemIndex);
            }
            return;
        }

        public function get headerRendererFactory():Function
        {
            return this._headerRendererFactory;
        }

        public function set headerRendererFactory(arg1:Function):void
        {
            if (this._headerRendererFactory === arg1) 
            {
                return;
            }
            this._headerRendererFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function dataProvider_removeItemHandler(arg1:starling.events.Event, arg2:Array):void
        {
            var loc2:*=0;
            if (this._selectedGroupIndex == -1) 
            {
                return;
            }
            var loc1:*=arg2[0] as int;
            if (arg2.length > 1) 
            {
                loc2 = arg2[1] as int;
                if (this._selectedGroupIndex == loc1) 
                {
                    if (this._selectedItemIndex != loc2) 
                    {
                        if (this._selectedItemIndex > loc2) 
                        {
                            this.setSelectedLocation(this._selectedGroupIndex, (this._selectedItemIndex - 1));
                        }
                    }
                    else 
                    {
                        this.setSelectedLocation(-1, -1);
                    }
                }
            }
            else if (this._selectedGroupIndex != loc1) 
            {
                if (this._selectedGroupIndex > loc1) 
                {
                    this.setSelectedLocation((this._selectedGroupIndex - 1), this._selectedItemIndex);
                }
            }
            else 
            {
                this.setSelectedLocation(-1, -1);
            }
            return;
        }

        public function get headerFactoryIDFunction():Function
        {
            return this._headerFactoryIDFunction;
        }

        public function set headerFactoryIDFunction(arg1:Function):void
        {
            if (this._headerFactoryIDFunction === arg1) 
            {
                return;
            }
            this._headerFactoryIDFunction = arg1;
            if (!(arg1 === null) && this._headerRendererFactories === null) 
            {
                this._headerRendererFactories = {};
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function dataProvider_replaceItemHandler(arg1:starling.events.Event, arg2:Array):void
        {
            var loc2:*=0;
            if (this._selectedGroupIndex == -1) 
            {
                return;
            }
            var loc1:*=arg2[0] as int;
            if (arg2.length > 1) 
            {
                loc2 = arg2[1] as int;
                if (this._selectedGroupIndex == loc1 && this._selectedItemIndex == loc2) 
                {
                    this.setSelectedLocation(-1, -1);
                }
            }
            else if (this._selectedGroupIndex == loc1) 
            {
                this.setSelectedLocation(-1, -1);
            }
            return;
        }

        public function get customHeaderRendererStyleName():String
        {
            return this._customHeaderRendererStyleName;
        }

        public function set customHeaderRendererStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customHeaderRendererStyleName === arg1) 
            {
                return;
            }
            this._customHeaderRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function dataViewPort_changeHandler(arg1:starling.events.Event):void
        {
            this.setSelectedLocation(this.dataViewPort.selectedGroupIndex, this.dataViewPort.selectedItemIndex);
            return;
        }

        public function get headerRendererProperties():Object
        {
            if (!this._headerRendererProperties) 
            {
                this._headerRendererProperties = new feathers.core.PropertyProxy(childProperties_onChange);
            }
            return this._headerRendererProperties;
        }

        public function set headerRendererProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._headerRendererProperties == arg1) 
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
            if (this._headerRendererProperties) 
            {
                this._headerRendererProperties.removeOnChangeCallback(childProperties_onChange);
            }
            this._headerRendererProperties = feathers.core.PropertyProxy(arg1);
            if (this._headerRendererProperties) 
            {
                this._headerRendererProperties.addOnChangeCallback(childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
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

        public function get footerRendererType():Class
        {
            return this._footerRendererType;
        }

        public function set footerRendererType(arg1:Class):void
        {
            if (this._footerRendererType == arg1) 
            {
                return;
            }
            this._footerRendererType = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get footerRendererFactory():Function
        {
            return this._footerRendererFactory;
        }

        public function set footerRendererFactory(arg1:Function):void
        {
            if (this._footerRendererFactory === arg1) 
            {
                return;
            }
            this._footerRendererFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get footerFactoryIDFunction():Function
        {
            return this._footerFactoryIDFunction;
        }

        public function set footerFactoryIDFunction(arg1:Function):void
        {
            if (this._footerFactoryIDFunction === arg1) 
            {
                return;
            }
            this._footerFactoryIDFunction = arg1;
            if (!(arg1 === null) && this._footerRendererFactories === null) 
            {
                this._footerRendererFactories = {};
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get customFooterRendererStyleName():String
        {
            return this._customFooterRendererStyleName;
        }

        public function set customFooterRendererStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customFooterRendererStyleName === arg1) 
            {
                return;
            }
            this._customFooterRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get footerRendererProperties():Object
        {
            if (!this._footerRendererProperties) 
            {
                this._footerRendererProperties = new feathers.core.PropertyProxy(childProperties_onChange);
            }
            return this._footerRendererProperties;
        }

        public function set footerRendererProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._footerRendererProperties == arg1) 
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
            if (this._footerRendererProperties) 
            {
                this._footerRendererProperties.removeOnChangeCallback(childProperties_onChange);
            }
            this._footerRendererProperties = feathers.core.PropertyProxy(arg1);
            if (this._footerRendererProperties) 
            {
                this._footerRendererProperties.addOnChangeCallback(childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get headerField():String
        {
            return this._headerField;
        }

        public function set headerField(arg1:String):void
        {
            if (this._headerField == arg1) 
            {
                return;
            }
            this._headerField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get headerFunction():Function
        {
            return this._headerFunction;
        }

        public function set headerFunction(arg1:Function):void
        {
            if (this._headerFunction == arg1) 
            {
                return;
            }
            this._headerFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get footerField():String
        {
            return this._footerField;
        }

        public function set footerField(arg1:String):void
        {
            if (this._footerField == arg1) 
            {
                return;
            }
            this._footerField = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public function get footerFunction():Function
        {
            return this._footerFunction;
        }

        public function set footerFunction(arg1:Function):void
        {
            if (this._footerFunction == arg1) 
            {
                return;
            }
            this._footerFunction = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        public static const VERTICAL_SCROLL_BAR_POSITION_RIGHT:String="right";

        public static const ALTERNATE_STYLE_NAME_INSET_GROUPED_LIST:String="feathers-inset-grouped-list";

        public static const DEFAULT_CHILD_STYLE_NAME_HEADER_RENDERER:String="feathers-grouped-list-header-renderer";

        public static const ALTERNATE_CHILD_STYLE_NAME_INSET_HEADER_RENDERER:String="feathers-grouped-list-inset-header-renderer";

        public static const DEFAULT_CHILD_STYLE_NAME_FOOTER_RENDERER:String="feathers-grouped-list-footer-renderer";

        public static const ALTERNATE_CHILD_STYLE_NAME_INSET_FOOTER_RENDERER:String="feathers-grouped-list-inset-footer-renderer";

        public static const ALTERNATE_CHILD_STYLE_NAME_INSET_ITEM_RENDERER:String="feathers-grouped-list-inset-item-renderer";

        public static const ALTERNATE_CHILD_STYLE_NAME_INSET_FIRST_ITEM_RENDERER:String="feathers-grouped-list-inset-first-item-renderer";

        public static const ALTERNATE_CHILD_STYLE_NAME_INSET_LAST_ITEM_RENDERER:String="feathers-grouped-list-inset-last-item-renderer";

        public static const ALTERNATE_CHILD_STYLE_NAME_INSET_SINGLE_ITEM_RENDERER:String="feathers-grouped-list-inset-single-item-renderer";

        public static const SCROLL_POLICY_AUTO:String="auto";

        public static const SCROLL_POLICY_ON:String="on";

        public static const SCROLL_POLICY_OFF:String="off";

        public static const SCROLL_BAR_DISPLAY_MODE_FLOAT:String="float";

        public static const SCROLL_BAR_DISPLAY_MODE_FIXED:String="fixed";

        public static const SCROLL_BAR_DISPLAY_MODE_FIXED_FLOAT:String="fixedFloat";

        public static const SCROLL_BAR_DISPLAY_MODE_NONE:String="none";

        public static const VERTICAL_SCROLL_BAR_POSITION_LEFT:String="left";

        public static const INTERACTION_MODE_TOUCH:String="touch";

        public static const INTERACTION_MODE_MOUSE:String="mouse";

        public static const INTERACTION_MODE_TOUCH_AND_SCROLL_BARS:String="touchAndScrollBars";

        public static const MOUSE_WHEEL_SCROLL_DIRECTION_VERTICAL:String="vertical";

        public static const MOUSE_WHEEL_SCROLL_DIRECTION_HORIZONTAL:String="horizontal";

        public static const DECELERATION_RATE_NORMAL:Number=0.998;

        public static const DECELERATION_RATE_FAST:Number=0.99;

        protected var _headerRendererFactory:Function;

        protected var _headerFactoryIDFunction:Function;

        protected var _customHeaderRendererStyleName:String="feathers-grouped-list-header-renderer";

        protected var _headerRendererProperties:feathers.core.PropertyProxy;

        protected var _footerRendererType:Class;

        protected var _footerFunction:Function;

        protected var _footerFactoryIDFunction:Function;

        protected var _footerRendererFactories:Object;

        protected var _keyScrollDuration:Number=0.25;

        protected var _itemRendererFactories:Object;

        protected var _footerRendererProperties:feathers.core.PropertyProxy;

        protected var pendingGroupIndex:int=-1;

        protected var pendingItemIndex:int=-1;

        protected var _footerRendererFactory:Function;

        protected var _footerField:String="footer";

        protected var _customFooterRendererStyleName:String="feathers-grouped-list-footer-renderer";

        protected var _headerField:String="header";

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var dataViewPort:feathers.controls.supportClasses.GroupedListDataViewPort;

        protected var _isChildFocusEnabled:Boolean=true;

        protected var _layout:feathers.layout.ILayout;

        protected var _dataProvider:feathers.data.HierarchicalCollection;

        protected var _isSelectable:Boolean=true;

        protected var _selectedGroupIndex:int=-1;

        protected var _selectedItemIndex:int=-1;

        protected var _itemRendererType:Class;

        protected var _itemRendererFactory:Function;

        protected var _factoryIDFunction:Function;

        protected var _typicalItem:Object=null;

        protected var _customItemRendererStyleName:String;

        protected var _itemRendererProperties:feathers.core.PropertyProxy;

        protected var _firstItemRendererType:Class;

        protected var _firstItemRendererFactory:Function;

        protected var _customFirstItemRendererStyleName:String;

        protected var _headerFunction:Function;

        protected var _lastItemRendererType:Class;

        protected var _lastItemRendererFactory:Function;

        protected var _customLastItemRendererStyleName:String;

        protected var _singleItemRendererType:Class;

        protected var _singleItemRendererFactory:Function;

        protected var _customSingleItemRendererStyleName:String;

        protected var _headerRendererType:Class;

        protected var _headerRendererFactories:Object;
    }
}


