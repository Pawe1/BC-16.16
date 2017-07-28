//class SpinnerList
package feathers.controls 
{
    import feathers.core.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import flash.ui.*;
    import starling.display.*;
    import starling.events.*;
    
    public class SpinnerList extends feathers.controls.List
    {
        public function SpinnerList()
        {
            super();
            this._scrollBarDisplayMode = feathers.controls.ScrollBarDisplayMode.NONE;
            this._snapToPages = true;
            this._snapOnComplete = true;
            this.decelerationRate = feathers.controls.DecelerationRate.FAST;
            this.addEventListener(starling.events.Event.TRIGGERED, this.spinnerList_triggeredHandler);
            this.addEventListener(feathers.events.FeathersEventType.SCROLL_COMPLETE, this.spinnerList_scrollCompleteHandler);
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            if (feathers.controls.SpinnerList.globalStyleProvider) 
            {
                return feathers.controls.SpinnerList.globalStyleProvider;
            }
            return feathers.controls.List.globalStyleProvider;
        }

        public override function set snapToPages(arg1:Boolean):void
        {
            if (!arg1) 
            {
                throw new ArgumentError("SpinnerList requires snapToPages to be true.");
            }
            super.snapToPages = arg1;
            return;
        }

        public override function set allowMultipleSelection(arg1:Boolean):void
        {
            if (arg1) 
            {
                throw new ArgumentError("SpinnerList requires allowMultipleSelection to be false.");
            }
            super.allowMultipleSelection = arg1;
            return;
        }

        public override function set isSelectable(arg1:Boolean):void
        {
            if (!arg1) 
            {
                throw new ArgumentError("SpinnerList requires isSelectable to be true.");
            }
            super.snapToPages = arg1;
            return;
        }

        public override function set layout(arg1:feathers.layout.ILayout):void
        {
            if (arg1 && !(arg1 is feathers.layout.ISpinnerLayout)) 
            {
                throw new ArgumentError("SpinnerList requires layouts to implement the ISpinnerLayout interface.");
            }
            super.layout = arg1;
            return;
        }

        public override function set selectedIndex(arg1:int):void
        {
            if (arg1 < 0 && !(this._dataProvider === null) && this._dataProvider.length > 0) 
            {
                return;
            }
            if (this._selectedIndex !== arg1) 
            {
                this.scrollToDisplayIndex(arg1, 0);
            }
            super.selectedIndex = arg1;
            return;
        }

        public override function set selectedItem(arg1:Object):void
        {
            if (this._dataProvider === null) 
            {
                this.selectedIndex = -1;
                return;
            }
            var loc1:*=this._dataProvider.getItemIndex(arg1);
            if (loc1 < 0) 
            {
                return;
            }
            this.selectedIndex = loc1;
            return;
        }

        public override function set dataProvider(arg1:feathers.data.ListCollection):void
        {
            if (this._dataProvider == arg1) 
            {
                return;
            }
            super.dataProvider = arg1;
            if (!this._dataProvider || this._dataProvider.length == 0) 
            {
                this.selectedIndex = -1;
            }
            else 
            {
                this.selectedIndex = 0;
            }
            return;
        }

        public function get selectionOverlaySkin():starling.display.DisplayObject
        {
            return this._selectionOverlaySkin;
        }

        public function set selectionOverlaySkin(arg1:starling.display.DisplayObject):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                if (arg1 !== null) 
                {
                    arg1.dispose();
                }
                return;
            }
            if (this._selectionOverlaySkin === arg1) 
            {
                return;
            }
            if (this._selectionOverlaySkin && this._selectionOverlaySkin.parent == this) 
            {
                this.removeRawChildInternal(this._selectionOverlaySkin);
            }
            this._selectionOverlaySkin = arg1;
            if (this._selectionOverlaySkin) 
            {
                this.addRawChildInternal(this._selectionOverlaySkin);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function initialize():void
        {
            var loc1:*=null;
            if (this._layout === null) 
            {
                if (this._hasElasticEdges && this._verticalScrollPolicy === feathers.controls.ScrollPolicy.AUTO && !(this._scrollBarDisplayMode === feathers.controls.ScrollBarDisplayMode.FIXED)) 
                {
                    this._verticalScrollPolicy = feathers.controls.ScrollPolicy.ON;
                }
                loc1 = new feathers.layout.VerticalSpinnerLayout();
                loc1.useVirtualLayout = true;
                loc1.padding = 0;
                loc1.gap = 0;
                loc1.horizontalAlign = feathers.layout.HorizontalAlign.JUSTIFY;
                loc1.requestedRowCount = 4;
                this._layout = loc1;
            }
            super.initialize();
            return;
        }

        protected override function refreshMinAndMaxScrollPositions():void
        {
            super.refreshMinAndMaxScrollPositions();
            if (this._maxVerticalScrollPosition == this._minVerticalScrollPosition) 
            {
                if (this._maxHorizontalScrollPosition != this._minHorizontalScrollPosition) 
                {
                    this.actualPageWidth = feathers.layout.ISpinnerLayout(this._layout).snapInterval;
                }
            }
            else 
            {
                this.actualPageHeight = feathers.layout.ISpinnerLayout(this._layout).snapInterval;
            }
            return;
        }

        protected override function handlePendingScroll():void
        {
            var loc1:*=0;
            if (this.pendingItemIndex >= 0) 
            {
                loc1 = this.pendingItemIndex;
                this.pendingItemIndex = -1;
                if (this._maxVerticalPageIndex == this._minVerticalPageIndex) 
                {
                    if (this._maxHorizontalPageIndex != this._minHorizontalPageIndex) 
                    {
                        this.pendingHorizontalPageIndex = this.calculateNearestPageIndexForItem(loc1, this._horizontalPageIndex, this._maxHorizontalPageIndex);
                        this.hasPendingHorizontalPageIndex = !(this.pendingHorizontalPageIndex === this._horizontalPageIndex);
                    }
                }
                else 
                {
                    this.pendingVerticalPageIndex = this.calculateNearestPageIndexForItem(loc1, this._verticalPageIndex, this._maxVerticalPageIndex);
                    this.hasPendingVerticalPageIndex = !(this.pendingVerticalPageIndex === this._verticalPageIndex);
                }
            }
            super.handlePendingScroll();
            return;
        }

        protected override function layoutChildren():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            super.layoutChildren();
            if (this._selectionOverlaySkin) 
            {
                if (this._selectionOverlaySkin is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this._selectionOverlaySkin).validate();
                }
                if (this._maxVerticalPageIndex == this._minVerticalPageIndex) 
                {
                    if (this._maxHorizontalPageIndex != this._minHorizontalPageIndex) 
                    {
                        loc2 = this.actualPageWidth;
                        if (loc2 > this.actualWidth) 
                        {
                            loc2 = this.actualWidth;
                        }
                        this._selectionOverlaySkin.width = loc2;
                        this._selectionOverlaySkin.height = this.actualHeight - this._topViewPortOffset - this._bottomViewPortOffset;
                        this._selectionOverlaySkin.x = Math.round(this._leftViewPortOffset + (this.actualWidth - this._leftViewPortOffset - this._rightViewPortOffset - loc2) / 2);
                        this._selectionOverlaySkin.y = this._topViewPortOffset;
                    }
                }
                else 
                {
                    this._selectionOverlaySkin.width = this.actualWidth - this._leftViewPortOffset - this._rightViewPortOffset;
                    loc1 = this.actualPageHeight;
                    if (loc1 > this.actualHeight) 
                    {
                        loc1 = this.actualHeight;
                    }
                    this._selectionOverlaySkin.height = loc1;
                    this._selectionOverlaySkin.x = this._leftViewPortOffset;
                    this._selectionOverlaySkin.y = Math.round(this._topViewPortOffset + (this.actualHeight - this._topViewPortOffset - this._bottomViewPortOffset - loc1) / 2);
                }
            }
            return;
        }

        protected function calculateNearestPageIndexForItem(arg1:int, arg2:int, arg3:int):int
        {
            var loc4:*=NaN;
            var loc5:*=NaN;
            if (arg3 != int.MAX_VALUE) 
            {
                return arg1;
            }
            var loc1:*=this._dataProvider.length;
            var loc2:*=arg2 / loc1;
            var loc3:*=arg2 % loc1;
            if (arg1 < loc3) 
            {
                loc4 = loc2 * loc1 + arg1;
                loc5 = (loc2 + 1) * loc1 + arg1;
            }
            else 
            {
                loc4 = (loc2 - 1) * loc1 + arg1;
                loc5 = loc2 * loc1 + arg1;
            }
            if (loc5 - arg2 < arg2 - loc4) 
            {
                return loc5;
            }
            return loc4;
        }

        protected function spinnerList_scrollCompleteHandler(arg1:starling.events.Event):void
        {
            var loc2:*=0;
            var loc1:*=this._dataProvider.length;
            if (this._maxVerticalPageIndex == this._minVerticalPageIndex) 
            {
                if (this._maxHorizontalPageIndex != this._minHorizontalPageIndex) 
                {
                    loc2 = this._horizontalPageIndex % loc1;
                }
            }
            else 
            {
                loc2 = this._verticalPageIndex % loc1;
            }
            if (loc2 < 0) 
            {
                loc2 = loc1 + loc2;
            }
            this.selectedIndex = loc2;
            return;
        }

        protected function spinnerList_triggeredHandler(arg1:starling.events.Event, arg2:Object):void
        {
            var loc1:*=this._dataProvider.getItemIndex(arg2);
            if (this._maxVerticalPageIndex == this._minVerticalPageIndex) 
            {
                if (this._maxHorizontalPageIndex != this._minHorizontalPageIndex) 
                {
                    loc1 = this.calculateNearestPageIndexForItem(loc1, this._horizontalPageIndex, this._maxHorizontalPageIndex);
                    this.throwToPage(loc1, this._verticalPageIndex, this._pageThrowDuration);
                }
            }
            else 
            {
                loc1 = this.calculateNearestPageIndexForItem(loc1, this._verticalPageIndex, this._maxVerticalPageIndex);
                this.throwToPage(this._horizontalPageIndex, loc1, this._pageThrowDuration);
            }
            return;
        }

        protected override function dataProvider_removeItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            var loc1:*=0;
            super.dataProvider_removeItemHandler(arg1, arg2);
            if (this._maxVerticalPageIndex == this._minVerticalPageIndex) 
            {
                if (this._maxHorizontalPageIndex != this._minHorizontalPageIndex) 
                {
                    loc1 = this.calculateNearestPageIndexForItem(this._selectedIndex, this._horizontalPageIndex, this._maxHorizontalPageIndex);
                    if (loc1 > this._dataProvider.length) 
                    {
                        loc1 = loc1 - this._dataProvider.length;
                    }
                    this.scrollToDisplayIndex(loc1, 0);
                }
            }
            else 
            {
                loc1 = this.calculateNearestPageIndexForItem(this._selectedIndex, this._verticalPageIndex, this._maxVerticalPageIndex);
                if (loc1 > this._dataProvider.length) 
                {
                    loc1 = loc1 - this._dataProvider.length;
                }
                this.scrollToDisplayIndex(loc1, 0);
            }
            return;
        }

        protected override function dataProvider_addItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            var loc1:*=0;
            super.dataProvider_addItemHandler(arg1, arg2);
            if (this._maxVerticalPageIndex == this._minVerticalPageIndex) 
            {
                if (this._maxHorizontalPageIndex != this._minHorizontalPageIndex) 
                {
                    loc1 = this.calculateNearestPageIndexForItem(this._selectedIndex, this._horizontalPageIndex, this._maxHorizontalPageIndex);
                    if (loc1 > this._dataProvider.length) 
                    {
                        loc1 = loc1 - this._dataProvider.length;
                    }
                    this.scrollToDisplayIndex(loc1, 0);
                }
            }
            else 
            {
                loc1 = this.calculateNearestPageIndexForItem(this._selectedIndex, this._verticalPageIndex, this._maxVerticalPageIndex);
                if (loc1 > this._dataProvider.length) 
                {
                    loc1 = loc1 - this._dataProvider.length;
                }
                this.scrollToDisplayIndex(loc1, 0);
            }
            return;
        }

        protected override function stage_keyDownHandler(arg1:starling.events.KeyboardEvent):void
        {
            var loc2:*=0;
            var loc3:*=0;
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
                            loc2 = this._selectedIndex + 1;
                            if (loc2 >= this._dataProvider.length) 
                            {
                                loc2 = loc2 - this._dataProvider.length;
                            }
                            this.selectedIndex = loc2;
                            loc1 = true;
                        }
                    }
                    else 
                    {
                        loc2 = (this._selectedIndex - 1);
                        if (loc2 < 0) 
                        {
                            loc2 = this._dataProvider.length + loc2;
                        }
                        this.selectedIndex = loc2;
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
                if (this._maxVerticalPageIndex == this._minVerticalPageIndex) 
                {
                    if (this._maxHorizontalPageIndex != this._minHorizontalPageIndex) 
                    {
                        loc3 = this.calculateNearestPageIndexForItem(this._selectedIndex, this._horizontalPageIndex, this._maxHorizontalPageIndex);
                        this.throwToPage(loc3, this._verticalPageIndex);
                    }
                }
                else 
                {
                    loc3 = this.calculateNearestPageIndexForItem(this._selectedIndex, this._verticalPageIndex, this._maxVerticalPageIndex);
                    this.throwToPage(this._horizontalPageIndex, loc3, this._pageThrowDuration);
                }
            }
            return;
        }

        protected var _selectionOverlaySkin:starling.display.DisplayObject;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;
    }
}


