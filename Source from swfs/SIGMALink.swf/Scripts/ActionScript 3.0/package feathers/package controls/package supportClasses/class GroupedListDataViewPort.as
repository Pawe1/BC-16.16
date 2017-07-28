//class GroupedListDataViewPort
package feathers.controls.supportClasses 
{
    import __AS3__.vec.*;
    import feathers.controls.*;
    import feathers.controls.renderers.*;
    import feathers.core.*;
    import feathers.data.*;
    import feathers.events.*;
    import feathers.layout.*;
    import flash.errors.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.events.*;
    import starling.utils.*;
    
    public class GroupedListDataViewPort extends feathers.core.FeathersControl implements feathers.controls.supportClasses.IViewPort
    {
        public function GroupedListDataViewPort()
        {
            this._viewPortBounds = new feathers.layout.ViewPortBounds();
            this._layoutResult = new feathers.layout.LayoutBoundsResult();
            this._layoutItems = new Vector.<starling.display.DisplayObject>(0);
            this._unrenderedItems = new Vector.<int>(0);
            this._defaultItemRendererStorage = new ItemRendererFactoryStorage();
            this._itemStorageMap = {};
            this._itemRendererMap = new flash.utils.Dictionary(true);
            this._unrenderedHeaders = new Vector.<int>(0);
            this._defaultHeaderRendererStorage = new HeaderRendererFactoryStorage();
            this._headerRendererMap = new flash.utils.Dictionary(true);
            this._unrenderedFooters = new Vector.<int>(0);
            this._defaultFooterRendererStorage = new FooterRendererFactoryStorage();
            this._footerRendererMap = new flash.utils.Dictionary(true);
            this._headerIndices = new Vector.<int>(0);
            this._footerIndices = new Vector.<int>(0);
            super();
            this.addEventListener(starling.events.TouchEvent.TOUCH, this.touchHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.removedFromStageHandler);
            return;
        }

        internal function refreshHeaderRendererStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._layoutItems;
            for each (loc1 in loc4) 
            {
                loc2 = loc1 as feathers.controls.renderers.IGroupedListHeaderRenderer;
                if (!loc2) 
                {
                    continue;
                }
                this.refreshOneHeaderRendererStyles(loc2);
            }
            return;
        }

        internal function refreshFooterRendererStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._layoutItems;
            for each (loc1 in loc4) 
            {
                loc2 = loc1 as feathers.controls.renderers.IGroupedListFooterRenderer;
                if (!loc2) 
                {
                    continue;
                }
                this.refreshOneFooterRendererStyles(loc2);
            }
            return;
        }

        internal function refreshOneItemRendererStyles(arg1:feathers.controls.renderers.IGroupedListItemRenderer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=starling.display.DisplayObject(arg1);
            var loc4:*=0;
            var loc5:*=this._itemRendererProperties;
            for (loc2 in loc5) 
            {
                loc3 = this._itemRendererProperties[loc2];
                loc1[loc2] = loc3;
            }
            return;
        }

        internal function refreshOneHeaderRendererStyles(arg1:feathers.controls.renderers.IGroupedListHeaderRenderer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=starling.display.DisplayObject(arg1);
            var loc4:*=0;
            var loc5:*=this._headerRendererProperties;
            for (loc2 in loc5) 
            {
                loc3 = this._headerRendererProperties[loc2];
                loc1[loc2] = loc3;
            }
            return;
        }

        internal function refreshOneFooterRendererStyles(arg1:feathers.controls.renderers.IGroupedListFooterRenderer):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc1:*=starling.display.DisplayObject(arg1);
            var loc4:*=0;
            var loc5:*=this._footerRendererProperties;
            for (loc2 in loc5) 
            {
                loc3 = this._footerRendererProperties[loc2];
                loc1[loc2] = loc3;
            }
            return;
        }

        public function get minVisibleWidth():Number
        {
            if (this._explicitMinVisibleWidth !== this._explicitMinVisibleWidth) 
            {
                return this._actualMinVisibleWidth;
            }
            return this._explicitMinVisibleWidth;
        }

        public function set minVisibleWidth(arg1:Number):void
        {
            if (this._explicitMinVisibleWidth == arg1) 
            {
                return;
            }
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinVisibleWidth === this._explicitMinVisibleWidth)) 
            {
                return;
            }
            var loc2:*=this._explicitMinVisibleWidth;
            this._explicitMinVisibleWidth = arg1;
            if (loc1) 
            {
                this._actualMinVisibleWidth = 0;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this._actualMinVisibleWidth = arg1;
                if (!(this._explicitVisibleWidth === this._explicitVisibleWidth) && (this._actualVisibleWidth < arg1 || this._actualVisibleWidth === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        internal function refreshSelection():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._layoutItems;
            for each (loc1 in loc4) 
            {
                loc2 = loc1 as feathers.controls.renderers.IGroupedListItemRenderer;
                if (!loc2) 
                {
                    continue;
                }
                loc2.isSelected = loc2.groupIndex == this._selectedGroupIndex && loc2.itemIndex == this._selectedItemIndex;
            }
            return;
        }

        public function get maxVisibleWidth():Number
        {
            return this._maxVisibleWidth;
        }

        public function set maxVisibleWidth(arg1:Number):void
        {
            if (this._maxVisibleWidth == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("maxVisibleWidth cannot be NaN");
            }
            var loc1:*=this._maxVisibleWidth;
            this._maxVisibleWidth = arg1;
            if (!(this._explicitVisibleWidth === this._explicitVisibleWidth) && (this._actualVisibleWidth > arg1 || this._actualVisibleWidth === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function refreshViewPortBounds():void
        {
            var loc1:*=!(this._explicitMinVisibleWidth === this._explicitMinVisibleWidth);
            var loc2:*=!(this._explicitMinVisibleHeight === this._explicitMinVisibleHeight);
            this._viewPortBounds.x = 0;
            this._viewPortBounds.y = 0;
            this._viewPortBounds.scrollX = this._horizontalScrollPosition;
            this._viewPortBounds.scrollY = this._verticalScrollPosition;
            this._viewPortBounds.explicitWidth = this._explicitVisibleWidth;
            this._viewPortBounds.explicitHeight = this._explicitVisibleHeight;
            if (loc1) 
            {
                this._viewPortBounds.minWidth = 0;
            }
            else 
            {
                this._viewPortBounds.minWidth = this._explicitMinVisibleWidth;
            }
            if (loc2) 
            {
                this._viewPortBounds.minHeight = 0;
            }
            else 
            {
                this._viewPortBounds.minHeight = this._explicitMinVisibleHeight;
            }
            this._viewPortBounds.maxWidth = this._maxVisibleWidth;
            this._viewPortBounds.maxHeight = this._maxVisibleHeight;
            return;
        }

        internal function refreshInactiveRenderers(arg1:Boolean):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            this.refreshInactiveItemRenderers(this._defaultItemRendererStorage, arg1);
            var loc5:*=0;
            var loc6:*=this._itemStorageMap;
            for (loc1 in loc6) 
            {
                loc2 = ItemRendererFactoryStorage(this._itemStorageMap[loc1]);
                this.refreshInactiveItemRenderers(loc2, arg1);
            }
            this.refreshInactiveHeaderRenderers(this._defaultHeaderRendererStorage, arg1);
            loc5 = 0;
            loc6 = this._headerStorageMap;
            for (loc1 in loc6) 
            {
                loc3 = HeaderRendererFactoryStorage(this._headerStorageMap[loc1]);
                this.refreshInactiveHeaderRenderers(loc3, arg1);
            }
            this.refreshInactiveFooterRenderers(this._defaultFooterRendererStorage, arg1);
            loc5 = 0;
            loc6 = this._footerStorageMap;
            for (loc1 in loc6) 
            {
                loc4 = FooterRendererFactoryStorage(this._footerStorageMap[loc1]);
                this.refreshInactiveFooterRenderers(loc4, arg1);
            }
            if (arg1 && this._typicalItemRenderer) 
            {
                if (this._typicalItemIsInDataProvider) 
                {
                    delete this._itemRendererMap[this._typicalItemRenderer.data];
                }
                this.destroyItemRenderer(this._typicalItemRenderer);
                this._typicalItemRenderer = null;
                this._typicalItemIsInDataProvider = false;
            }
            this._headerIndices.length = 0;
            this._footerIndices.length = 0;
            return;
        }

        public function get visibleWidth():Number
        {
            return this._actualVisibleWidth;
        }

        public function set visibleWidth(arg1:Number):void
        {
            if (this._explicitVisibleWidth == arg1 || !(arg1 === arg1) && !(this._explicitVisibleWidth === this._explicitVisibleWidth)) 
            {
                return;
            }
            this._explicitVisibleWidth = arg1;
            if (this._actualVisibleWidth !== arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function refreshInactiveItemRenderers(arg1:ItemRendererFactoryStorage, arg2:Boolean):void
        {
            var loc1:*=arg1.inactiveItemRenderers;
            arg1.inactiveItemRenderers = arg1.activeItemRenderers;
            arg1.activeItemRenderers = loc1;
            if (arg1.activeItemRenderers.length > 0) 
            {
                throw new flash.errors.IllegalOperationError("GroupedListDataViewPort: active item renderers should be empty.");
            }
            if (arg2) 
            {
                this.recoverInactiveItemRenderers(arg1);
                this.freeInactiveItemRenderers(arg1, 0);
            }
            return;
        }

        internal function refreshInactiveHeaderRenderers(arg1:HeaderRendererFactoryStorage, arg2:Boolean):void
        {
            var loc1:*=arg1.inactiveHeaderRenderers;
            arg1.inactiveHeaderRenderers = arg1.activeHeaderRenderers;
            arg1.activeHeaderRenderers = loc1;
            if (arg1.activeHeaderRenderers.length > 0) 
            {
                throw new flash.errors.IllegalOperationError("GroupedListDataViewPort: active header renderers should be empty.");
            }
            if (arg2) 
            {
                this.recoverInactiveHeaderRenderers(arg1);
                this.freeInactiveHeaderRenderers(arg1, 0);
            }
            return;
        }

        public function get minVisibleHeight():Number
        {
            if (this._explicitMinVisibleHeight !== this._explicitMinVisibleHeight) 
            {
                return this._actualMinVisibleHeight;
            }
            return this._explicitMinVisibleHeight;
        }

        public function set minVisibleHeight(arg1:Number):void
        {
            if (this._explicitMinVisibleHeight == arg1) 
            {
                return;
            }
            var loc1:*=!(arg1 === arg1);
            if (loc1 && !(this._explicitMinVisibleHeight === this._explicitMinVisibleHeight)) 
            {
                return;
            }
            var loc2:*=this._explicitMinVisibleHeight;
            this._explicitMinVisibleHeight = arg1;
            if (loc1) 
            {
                this._actualMinVisibleHeight = 0;
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            else 
            {
                this._actualMinVisibleHeight = arg1;
                if (!(this._explicitVisibleHeight === this._explicitVisibleHeight) && (this._actualVisibleHeight < arg1 || this._actualVisibleHeight === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
            }
            return;
        }

        internal function refreshInactiveFooterRenderers(arg1:FooterRendererFactoryStorage, arg2:Boolean):void
        {
            var loc1:*=arg1.inactiveFooterRenderers;
            arg1.inactiveFooterRenderers = arg1.activeFooterRenderers;
            arg1.activeFooterRenderers = loc1;
            if (arg1.activeFooterRenderers.length > 0) 
            {
                throw new flash.errors.IllegalOperationError("GroupedListDataViewPort: active footer renderers should be empty.");
            }
            if (arg2) 
            {
                this.recoverInactiveFooterRenderers(arg1);
                this.freeInactiveFooterRenderers(arg1, 0);
            }
            return;
        }

        public function get maxVisibleHeight():Number
        {
            return this._maxVisibleHeight;
        }

        public function set maxVisibleHeight(arg1:Number):void
        {
            if (this._maxVisibleHeight == arg1) 
            {
                return;
            }
            if (arg1 !== arg1) 
            {
                throw new ArgumentError("maxVisibleHeight cannot be NaN");
            }
            var loc1:*=this._maxVisibleHeight;
            this._maxVisibleHeight = arg1;
            if (!(this._explicitVisibleHeight === this._explicitVisibleHeight) && (this._actualVisibleHeight > arg1 || this._actualVisibleHeight === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function refreshRenderers():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            if (this._typicalItemRenderer) 
            {
                if (this._typicalItemIsInDataProvider) 
                {
                    loc1 = this.factoryIDToStorage(this._typicalItemRenderer.factoryID, this._typicalItemRenderer.groupIndex, this._typicalItemRenderer.itemIndex);
                    loc2 = loc1.inactiveItemRenderers;
                    loc3 = loc1.activeItemRenderers;
                    loc4 = loc2.indexOf(this._typicalItemRenderer);
                    if (loc4 >= 0) 
                    {
                        loc2.removeAt(loc4);
                    }
                    loc5 = loc3.length;
                    if (loc5 == 0) 
                    {
                        loc3[loc5] = this._typicalItemRenderer;
                    }
                }
                this.refreshOneItemRendererStyles(this._typicalItemRenderer);
            }
            this.findUnrenderedData();
            this.recoverInactiveItemRenderers(this._defaultItemRendererStorage);
            if (this._itemStorageMap) 
            {
                var loc9:*=0;
                var loc10:*=this._itemStorageMap;
                for (loc6 in loc10) 
                {
                    loc1 = ItemRendererFactoryStorage(this._itemStorageMap[loc6]);
                    this.recoverInactiveItemRenderers(loc1);
                }
            }
            this.recoverInactiveHeaderRenderers(this._defaultHeaderRendererStorage);
            if (this._headerStorageMap) 
            {
                loc9 = 0;
                loc10 = this._headerStorageMap;
                for (loc6 in loc10) 
                {
                    loc7 = HeaderRendererFactoryStorage(this._headerStorageMap[loc6]);
                    this.recoverInactiveHeaderRenderers(loc7);
                }
            }
            this.recoverInactiveFooterRenderers(this._defaultFooterRendererStorage);
            if (this._footerStorageMap) 
            {
                loc9 = 0;
                loc10 = this._footerStorageMap;
                for (loc6 in loc10) 
                {
                    loc8 = FooterRendererFactoryStorage(this._footerStorageMap[loc6]);
                    this.recoverInactiveFooterRenderers(loc8);
                }
            }
            this.renderUnrenderedData();
            this.freeInactiveItemRenderers(this._defaultItemRendererStorage, this._minimumItemCount);
            if (this._itemStorageMap) 
            {
                loc9 = 0;
                loc10 = this._itemStorageMap;
                for (loc6 in loc10) 
                {
                    loc1 = ItemRendererFactoryStorage(this._itemStorageMap[loc6]);
                    this.freeInactiveItemRenderers(loc1, 1);
                }
            }
            this.freeInactiveHeaderRenderers(this._defaultHeaderRendererStorage, this._minimumHeaderCount);
            if (this._headerStorageMap) 
            {
                loc9 = 0;
                loc10 = this._headerStorageMap;
                for (loc6 in loc10) 
                {
                    loc7 = HeaderRendererFactoryStorage(this._headerStorageMap[loc6]);
                    this.freeInactiveHeaderRenderers(loc7, 1);
                }
            }
            this.freeInactiveFooterRenderers(this._defaultFooterRendererStorage, this._minimumFooterCount);
            if (this._footerStorageMap) 
            {
                loc9 = 0;
                loc10 = this._footerStorageMap;
                for (loc6 in loc10) 
                {
                    loc8 = FooterRendererFactoryStorage(this._footerStorageMap[loc6]);
                    this.freeInactiveFooterRenderers(loc8, 1);
                }
            }
            this._updateForDataReset = false;
            return;
        }

        internal function findUnrenderedData():void
        {
            var loc11:*=null;
            var loc12:*=0;
            var loc13:*=null;
            var loc14:*=NaN;
            var loc15:*=NaN;
            var loc16:*=NaN;
            var loc17:*=NaN;
            var loc18:*=null;
            var loc19:*=0;
            var loc20:*=null;
            var loc21:*=null;
            var loc22:*=0;
            var loc1:*=this._dataProvider ? this._dataProvider.getLength() : 0;
            var loc2:*=0;
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=0;
            while (loc7 < loc1) 
            {
                loc11 = this._dataProvider.getItemAt(loc7);
                if (this._owner.groupToHeaderData(loc11) !== null) 
                {
                    this._headerIndices[loc3] = loc2;
                    ++loc2;
                    ++loc3;
                }
                loc12 = this._dataProvider.getLength(loc7);
                loc2 = loc2 + loc12;
                loc6 = loc6 + loc12;
                if (loc12 == 0) 
                {
                    ++loc5;
                }
                if (this._owner.groupToFooterData(loc11) !== null) 
                {
                    this._footerIndices[loc4] = loc2;
                    ++loc2;
                    ++loc4;
                }
                ++loc7;
            }
            this._layoutItems.length = loc2;
            if (this._layout is feathers.layout.IGroupedLayout) 
            {
                feathers.layout.IGroupedLayout(this._layout).headerIndices = this._headerIndices;
            }
            var loc8:*=this._layout as feathers.layout.IVirtualLayout;
            var loc9:*=loc8 && loc8.useVirtualLayout;
            if (loc9) 
            {
                loc13 = starling.utils.Pool.getPoint();
                loc8.measureViewPort(loc2, this._viewPortBounds, loc13);
                loc14 = loc13.x;
                loc15 = loc13.y;
                starling.utils.Pool.putPoint(loc13);
                loc8.getVisibleIndicesAtScrollPosition(this._horizontalScrollPosition, this._verticalScrollPosition, loc14, loc15, loc2, HELPER_VECTOR);
                loc6 = loc6 / loc1;
                if (this._typicalItemRenderer) 
                {
                    loc16 = this._typicalItemRenderer.height;
                    if (this._typicalItemRenderer.width < loc16) 
                    {
                        loc16 = this._typicalItemRenderer.width;
                    }
                    loc17 = loc14;
                    if (loc15 > loc14) 
                    {
                        loc17 = loc15;
                    }
                    var loc23:*;
                    this._minimumFooterCount = loc23 = Math.ceil(loc17 / (loc16 * loc6));
                    this._minimumHeaderCount = loc23 = loc23;
                    this._minimumSingleItemCount = loc23 = loc23;
                    this._minimumFirstAndLastItemCount = loc23;
                    this._minimumHeaderCount = Math.min(this._minimumHeaderCount, loc3);
                    this._minimumFooterCount = Math.min(this._minimumFooterCount, loc4);
                    this._minimumSingleItemCount = Math.min(this._minimumSingleItemCount, loc5);
                    this._minimumItemCount = Math.ceil(loc17 / loc16) + 1;
                }
                else 
                {
                    this._minimumFirstAndLastItemCount = 1;
                    this._minimumHeaderCount = 1;
                    this._minimumFooterCount = 1;
                    this._minimumSingleItemCount = 1;
                    this._minimumItemCount = 1;
                }
            }
            var loc10:*=0;
            loc7 = 0;
            while (loc7 < loc1) 
            {
                loc11 = this._dataProvider.getItemAt(loc7);
                loc18 = this._owner.groupToHeaderData(loc11);
                if (loc18 !== null) 
                {
                    if (loc9 && HELPER_VECTOR.indexOf(loc10) < 0) 
                    {
                        this._layoutItems[loc10] = null;
                    }
                    else 
                    {
                        this.findRendererForHeader(loc18, loc7, loc10);
                    }
                    ++loc10;
                }
                loc12 = this._dataProvider.getLength(loc7);
                loc19 = 0;
                while (loc19 < loc12) 
                {
                    if (loc9 && HELPER_VECTOR.indexOf(loc10) < 0) 
                    {
                        if (this._typicalItemRenderer && this._typicalItemIsInDataProvider && this._typicalItemRenderer.groupIndex === loc7 && this._typicalItemRenderer.itemIndex === loc19) 
                        {
                            this._typicalItemRenderer.layoutIndex = loc10;
                        }
                        this._layoutItems[loc10] = null;
                    }
                    else 
                    {
                        loc21 = this._dataProvider.getItemAt(loc7, loc19);
                        this.findRendererForItem(loc21, loc7, loc19, loc10);
                    }
                    ++loc10;
                    ++loc19;
                }
                loc20 = this._owner.groupToFooterData(loc11);
                if (loc20 !== null) 
                {
                    if (loc9 && HELPER_VECTOR.indexOf(loc10) < 0) 
                    {
                        this._layoutItems[loc10] = null;
                    }
                    else 
                    {
                        this.findRendererForFooter(loc20, loc7, loc10);
                    }
                    ++loc10;
                }
                ++loc7;
            }
            if (this._typicalItemRenderer) 
            {
                if (loc9 && this._typicalItemIsInDataProvider) 
                {
                    loc22 = HELPER_VECTOR.indexOf(this._typicalItemRenderer.layoutIndex);
                    if (loc22 >= 0) 
                    {
                        this._typicalItemRenderer.visible = true;
                    }
                    else 
                    {
                        this._typicalItemRenderer.visible = false;
                    }
                }
                else 
                {
                    this._typicalItemRenderer.visible = this._typicalItemIsInDataProvider;
                }
            }
            HELPER_VECTOR.length = 0;
            return;
        }

        public function get visibleHeight():Number
        {
            return this._actualVisibleHeight;
        }

        public function set visibleHeight(arg1:Number):void
        {
            if (this._explicitVisibleHeight == arg1 || !(arg1 === arg1) && !(this._explicitVisibleHeight === this._explicitVisibleHeight)) 
            {
                return;
            }
            this._explicitVisibleHeight = arg1;
            if (this._actualVisibleHeight !== arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function findRendererForItem(arg1:Object, arg2:int, arg3:int, arg4:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=0;
            var loc1:*=feathers.controls.renderers.IGroupedListItemRenderer(this._itemRendererMap[arg1]);
            if (loc1) 
            {
                loc1.groupIndex = arg2;
                loc1.itemIndex = arg3;
                loc1.layoutIndex = arg4;
                if (this._updateForDataReset) 
                {
                    loc1.data = null;
                    loc1.data = arg1;
                }
                if (this._typicalItemRenderer != loc1) 
                {
                    loc2 = this.factoryIDToStorage(loc1.factoryID, loc1.groupIndex, loc1.itemIndex);
                    loc3 = loc2.activeItemRenderers;
                    loc4 = loc2.inactiveItemRenderers;
                    loc3[loc3.length] = loc1;
                    loc5 = loc4.indexOf(loc1);
                    if (loc5 >= 0) 
                    {
                        loc4.removeAt(loc5);
                    }
                    else 
                    {
                        throw new flash.errors.IllegalOperationError("GroupedListDataViewPort: renderer map contains bad data. This may be caused by duplicate items in the data provider, which is not allowed.");
                    }
                }
                loc1.visible = true;
                this._layoutItems[arg4] = starling.display.DisplayObject(loc1);
            }
            else 
            {
                loc6 = this._unrenderedItems.length;
                this._unrenderedItems[loc6] = arg2;
                ++loc6;
                this._unrenderedItems[loc6] = arg3;
                ++loc6;
                this._unrenderedItems[loc6] = arg4;
            }
            return;
        }

        public function get contentX():Number
        {
            return this._contentX;
        }

        internal function findRendererForHeader(arg1:Object, arg2:int, arg3:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc1:*=feathers.controls.renderers.IGroupedListHeaderRenderer(this._headerRendererMap[arg1]);
            if (loc1) 
            {
                loc1.groupIndex = arg2;
                loc1.layoutIndex = arg3;
                if (this._updateForDataReset) 
                {
                    loc1.data = null;
                    loc1.data = arg1;
                }
                loc2 = this.headerFactoryIDToStorage(loc1.factoryID);
                loc3 = loc2.activeHeaderRenderers;
                loc4 = loc2.inactiveHeaderRenderers;
                loc3[loc3.length] = loc1;
                loc4.removeAt(loc4.indexOf(loc1));
                loc1.visible = true;
                this._layoutItems[arg3] = starling.display.DisplayObject(loc1);
            }
            else 
            {
                loc5 = this._unrenderedHeaders.length;
                this._unrenderedHeaders[loc5] = arg2;
                ++loc5;
                this._unrenderedHeaders[loc5] = arg3;
            }
            return;
        }

        public function get contentY():Number
        {
            return this._contentY;
        }

        public function get horizontalScrollStep():Number
        {
            if (this._typicalItemRenderer === null) 
            {
                return 0;
            }
            var loc1:*=this._typicalItemRenderer.width;
            var loc2:*=this._typicalItemRenderer.height;
            if (loc1 < loc2) 
            {
                return loc1;
            }
            return loc2;
        }

        public function get verticalScrollStep():Number
        {
            if (this._typicalItemRenderer === null) 
            {
                return 0;
            }
            var loc1:*=this._typicalItemRenderer.width;
            var loc2:*=this._typicalItemRenderer.height;
            if (loc1 < loc2) 
            {
                return loc1;
            }
            return loc2;
        }

        internal function findRendererForFooter(arg1:Object, arg2:int, arg3:int):void
        {
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc1:*=feathers.controls.renderers.IGroupedListFooterRenderer(this._footerRendererMap[arg1]);
            if (loc1) 
            {
                loc1.groupIndex = arg2;
                loc1.layoutIndex = arg3;
                if (this._updateForDataReset) 
                {
                    loc1.data = null;
                    loc1.data = arg1;
                }
                loc2 = this.footerFactoryIDToStorage(loc1.factoryID);
                loc3 = loc2.activeFooterRenderers;
                loc4 = loc2.inactiveFooterRenderers;
                loc3[loc3.length] = loc1;
                loc4.removeAt(loc4.indexOf(loc1));
                loc1.visible = true;
                this._layoutItems[arg3] = starling.display.DisplayObject(loc1);
            }
            else 
            {
                loc5 = this._unrenderedFooters.length;
                this._unrenderedFooters[loc5] = arg2;
                ++loc5;
                this._unrenderedFooters[loc5] = arg3;
            }
            return;
        }

        internal function renderUnrenderedData():void
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=null;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc1:*=this._unrenderedItems.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._unrenderedItems.shift();
                loc4 = this._unrenderedItems.shift();
                loc5 = this._unrenderedItems.shift();
                loc6 = this._dataProvider.getItemAt(loc3, loc4);
                loc7 = this.createItemRenderer(loc6, loc3, loc4, loc5, true, false);
                this._layoutItems[loc5] = starling.display.DisplayObject(loc7);
                loc2 = loc2 + 3;
            }
            loc1 = this._unrenderedHeaders.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                loc3 = this._unrenderedHeaders.shift();
                loc5 = this._unrenderedHeaders.shift();
                loc6 = this._dataProvider.getItemAt(loc3);
                loc6 = this._owner.groupToHeaderData(loc6);
                loc8 = this.createHeaderRenderer(loc6, loc3, loc5, false);
                this._layoutItems[loc5] = starling.display.DisplayObject(loc8);
                loc2 = loc2 + 2;
            }
            loc1 = this._unrenderedFooters.length;
            loc2 = 0;
            while (loc2 < loc1) 
            {
                loc3 = this._unrenderedFooters.shift();
                loc5 = this._unrenderedFooters.shift();
                loc6 = this._dataProvider.getItemAt(loc3);
                loc6 = this._owner.groupToFooterData(loc6);
                loc9 = this.createFooterRenderer(loc6, loc3, loc5, false);
                this._layoutItems[loc5] = starling.display.DisplayObject(loc9);
                loc2 = loc2 + 2;
            }
            return;
        }

        internal function recoverInactiveItemRenderers(arg1:ItemRendererFactoryStorage):void
        {
            var loc4:*=null;
            var loc1:*=arg1.inactiveItemRenderers;
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                if (!(!loc4 || loc4.groupIndex < 0)) 
                {
                    this._owner.dispatchEventWith(feathers.events.FeathersEventType.RENDERER_REMOVE, false, loc4);
                    delete this._itemRendererMap[loc4.data];
                }
                ++loc3;
            }
            return;
        }

        internal function recoverInactiveHeaderRenderers(arg1:HeaderRendererFactoryStorage):void
        {
            var loc4:*=null;
            var loc1:*=arg1.inactiveHeaderRenderers;
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                if (loc4) 
                {
                    this._owner.dispatchEventWith(feathers.events.FeathersEventType.RENDERER_REMOVE, false, loc4);
                    delete this._headerRendererMap[loc4.data];
                }
                ++loc3;
            }
            return;
        }

        internal function recoverInactiveFooterRenderers(arg1:FooterRendererFactoryStorage):void
        {
            var loc4:*=null;
            var loc1:*=arg1.inactiveFooterRenderers;
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                if (loc4) 
                {
                    this._owner.dispatchEventWith(feathers.events.FeathersEventType.RENDERER_REMOVE, false, loc4);
                    delete this._footerRendererMap[loc4.data];
                }
                ++loc3;
            }
            return;
        }

        internal function freeInactiveItemRenderers(arg1:ItemRendererFactoryStorage, arg2:int):void
        {
            var loc7:*=null;
            var loc1:*=arg1.inactiveItemRenderers;
            var loc2:*=arg1.activeItemRenderers;
            var loc3:*=loc2.length;
            var loc4:*=arg2 - loc3;
            if (loc4 > loc1.length) 
            {
                loc4 = loc1.length;
            }
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc7 = loc1.shift();
                loc7.data = null;
                loc7.groupIndex = -1;
                loc7.itemIndex = -1;
                loc7.layoutIndex = -1;
                loc7.visible = false;
                loc2[loc3] = loc7;
                ++loc3;
                ++loc5;
            }
            var loc6:*=loc1.length;
            loc5 = 0;
            while (loc5 < loc6) 
            {
                loc7 = loc1.shift();
                if (loc7) 
                {
                    this.destroyItemRenderer(loc7);
                }
                ++loc5;
            }
            return;
        }

        internal function freeInactiveHeaderRenderers(arg1:HeaderRendererFactoryStorage, arg2:int):void
        {
            var loc7:*=null;
            var loc1:*=arg1.inactiveHeaderRenderers;
            var loc2:*=arg1.activeHeaderRenderers;
            var loc3:*=loc2.length;
            var loc4:*=arg2 - loc3;
            if (loc4 > loc1.length) 
            {
                loc4 = loc1.length;
            }
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc7 = loc1.shift();
                loc7.visible = false;
                loc7.data = null;
                loc7.groupIndex = -1;
                loc7.layoutIndex = -1;
                loc2[loc3] = loc7;
                ++loc3;
                ++loc5;
            }
            var loc6:*=loc1.length;
            loc5 = 0;
            while (loc5 < loc6) 
            {
                loc7 = loc1.shift();
                if (loc7) 
                {
                    this.destroyHeaderRenderer(loc7);
                }
                ++loc5;
            }
            return;
        }

        internal function freeInactiveFooterRenderers(arg1:FooterRendererFactoryStorage, arg2:int):void
        {
            var loc7:*=null;
            var loc1:*=arg1.inactiveFooterRenderers;
            var loc2:*=arg1.activeFooterRenderers;
            var loc3:*=loc2.length;
            var loc4:*=arg2 - loc3;
            if (loc4 > loc1.length) 
            {
                loc4 = loc1.length;
            }
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc7 = loc1.shift();
                loc7.visible = false;
                loc7.data = null;
                loc7.groupIndex = -1;
                loc7.layoutIndex = -1;
                loc2[loc3] = loc7;
                ++loc3;
                ++loc5;
            }
            var loc6:*=loc1.length;
            loc5 = 0;
            while (loc5 < loc6) 
            {
                loc7 = loc1.shift();
                if (loc7) 
                {
                    this.destroyFooterRenderer(loc7);
                }
                ++loc5;
            }
            return;
        }

        internal function createItemRenderer(arg1:Object, arg2:int, arg3:int, arg4:int, arg5:Boolean, arg6:Boolean):feathers.controls.renderers.IGroupedListItemRenderer
        {
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc1:*=this.getFactoryID(arg1, arg2, arg3);
            var loc2:*=this.factoryIDToFactory(loc1, arg2, arg3);
            var loc3:*=this.factoryIDToStorage(loc1, arg2, arg3);
            var loc4:*=this.indexToCustomStyleName(arg2, arg3);
            var loc5:*=loc3.inactiveItemRenderers;
            var loc6:*=loc3.activeItemRenderers;
            if (!arg5 || arg6 || loc5.length === 0) 
            {
                if (loc2 === null) 
                {
                    loc9 = this.indexToItemRendererType(arg2, arg3);
                    loc7 = feathers.controls.renderers.IGroupedListItemRenderer(new loc9());
                }
                else 
                {
                    loc7 = feathers.controls.renderers.IGroupedListItemRenderer(loc2());
                }
                loc8 = feathers.core.IFeathersControl(loc7);
                if (loc4 && loc4.length > 0) 
                {
                    loc8.styleNameList.add(loc4);
                }
                this.addChild(starling.display.DisplayObject(loc7));
            }
            else 
            {
                loc7 = loc5.shift();
            }
            loc7.data = arg1;
            loc7.groupIndex = arg2;
            loc7.itemIndex = arg3;
            loc7.layoutIndex = arg4;
            loc7.owner = this._owner;
            loc7.factoryID = loc1;
            loc7.visible = true;
            if (!arg6) 
            {
                this._itemRendererMap[arg1] = loc7;
                loc6.push(loc7);
                loc7.addEventListener(starling.events.Event.TRIGGERED, this.renderer_triggeredHandler);
                loc7.addEventListener(starling.events.Event.CHANGE, this.renderer_changeHandler);
                loc7.addEventListener(feathers.events.FeathersEventType.RESIZE, this.itemRenderer_resizeHandler);
                this._owner.dispatchEventWith(feathers.events.FeathersEventType.RENDERER_ADD, false, loc7);
            }
            return loc7;
        }

        internal function createHeaderRenderer(arg1:Object, arg2:int, arg3:int, arg4:Boolean=false):feathers.controls.renderers.IGroupedListHeaderRenderer
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=null;
            if (this._headerFactoryIDFunction !== null) 
            {
                if (this._headerFactoryIDFunction.length !== 1) 
                {
                    loc1 = this._headerFactoryIDFunction(arg1, arg2);
                }
                else 
                {
                    loc1 = this._headerFactoryIDFunction(arg1);
                }
            }
            var loc2:*=this.headerFactoryIDToFactory(loc1);
            var loc3:*=this.headerFactoryIDToStorage(loc1);
            var loc4:*=loc3.inactiveHeaderRenderers;
            var loc5:*=loc3.activeHeaderRenderers;
            if (arg4 || loc4.length === 0) 
            {
                if (loc2 === null) 
                {
                    loc6 = feathers.controls.renderers.IGroupedListHeaderRenderer(new this._headerRendererType());
                }
                else 
                {
                    loc6 = feathers.controls.renderers.IGroupedListHeaderRenderer(loc2());
                }
                loc7 = feathers.core.IFeathersControl(loc6);
                if (this._customHeaderRendererStyleName && this._customHeaderRendererStyleName.length > 0) 
                {
                    loc7.styleNameList.add(this._customHeaderRendererStyleName);
                }
                this.addChild(starling.display.DisplayObject(loc6));
            }
            else 
            {
                loc6 = loc4.shift();
            }
            loc6.data = arg1;
            loc6.groupIndex = arg2;
            loc6.layoutIndex = arg3;
            loc6.owner = this._owner;
            loc6.factoryID = loc1;
            loc6.visible = true;
            if (!arg4) 
            {
                this._headerRendererMap[arg1] = loc6;
                loc5.push(loc6);
                loc6.addEventListener(feathers.events.FeathersEventType.RESIZE, this.headerRenderer_resizeHandler);
                this._owner.dispatchEventWith(feathers.events.FeathersEventType.RENDERER_ADD, false, loc6);
            }
            return loc6;
        }

        internal function createFooterRenderer(arg1:Object, arg2:int, arg3:int, arg4:Boolean=false):feathers.controls.renderers.IGroupedListFooterRenderer
        {
            var loc6:*=null;
            var loc7:*=null;
            var loc1:*=null;
            if (this._footerFactoryIDFunction !== null) 
            {
                if (this._footerFactoryIDFunction.length !== 1) 
                {
                    loc1 = this._footerFactoryIDFunction(arg1, arg2);
                }
                else 
                {
                    loc1 = this._footerFactoryIDFunction(arg1);
                }
            }
            var loc2:*=this.footerFactoryIDToFactory(loc1);
            var loc3:*=this.footerFactoryIDToStorage(loc1);
            var loc4:*=loc3.inactiveFooterRenderers;
            var loc5:*=loc3.activeFooterRenderers;
            if (arg4 || loc4.length === 0) 
            {
                if (loc2 === null) 
                {
                    loc6 = feathers.controls.renderers.IGroupedListFooterRenderer(new this._footerRendererType());
                }
                else 
                {
                    loc6 = feathers.controls.renderers.IGroupedListFooterRenderer(loc2());
                }
                loc7 = feathers.core.IFeathersControl(loc6);
                if (this._customFooterRendererStyleName && this._customFooterRendererStyleName.length > 0) 
                {
                    loc7.styleNameList.add(this._customFooterRendererStyleName);
                }
                this.addChild(starling.display.DisplayObject(loc6));
            }
            else 
            {
                loc6 = loc4.shift();
            }
            loc6.data = arg1;
            loc6.groupIndex = arg2;
            loc6.layoutIndex = arg3;
            loc6.owner = this._owner;
            loc6.factoryID = loc1;
            loc6.visible = true;
            if (!arg4) 
            {
                this._footerRendererMap[arg1] = loc6;
                loc5[loc5.length] = loc6;
                loc6.addEventListener(feathers.events.FeathersEventType.RESIZE, this.footerRenderer_resizeHandler);
                this._owner.dispatchEventWith(feathers.events.FeathersEventType.RENDERER_ADD, false, loc6);
            }
            return loc6;
        }

        internal function destroyItemRenderer(arg1:feathers.controls.renderers.IGroupedListItemRenderer):void
        {
            arg1.removeEventListener(starling.events.Event.TRIGGERED, this.renderer_triggeredHandler);
            arg1.removeEventListener(starling.events.Event.CHANGE, this.renderer_changeHandler);
            arg1.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.itemRenderer_resizeHandler);
            arg1.owner = null;
            arg1.data = null;
            this.removeChild(starling.display.DisplayObject(arg1), true);
            return;
        }

        internal function destroyHeaderRenderer(arg1:feathers.controls.renderers.IGroupedListHeaderRenderer):void
        {
            arg1.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.headerRenderer_resizeHandler);
            arg1.owner = null;
            arg1.data = null;
            this.removeChild(starling.display.DisplayObject(arg1), true);
            return;
        }

        internal function destroyFooterRenderer(arg1:feathers.controls.renderers.IGroupedListFooterRenderer):void
        {
            arg1.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.footerRenderer_resizeHandler);
            arg1.owner = null;
            arg1.data = null;
            this.removeChild(starling.display.DisplayObject(arg1), true);
            return;
        }

        internal function groupToHeaderDisplayIndex(arg1:int):int
        {
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=null;
            var loc1:*=this._dataProvider.getItemAt(arg1);
            var loc2:*=this._owner.groupToHeaderData(loc1);
            if (!loc2) 
            {
                return -1;
            }
            var loc3:*=0;
            var loc4:*=this._dataProvider.getLength();
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc1 = this._dataProvider.getItemAt(loc5);
                loc2 = this._owner.groupToHeaderData(loc1);
                if (loc2) 
                {
                    if (arg1 == loc5) 
                    {
                        return loc3;
                    }
                    ++loc3;
                }
                loc6 = this._dataProvider.getLength(loc5);
                loc7 = 0;
                while (loc7 < loc6) 
                {
                    ++loc3;
                    ++loc7;
                }
                loc8 = this._owner.groupToFooterData(loc1);
                if (loc8) 
                {
                    ++loc3;
                }
                ++loc5;
            }
            return -1;
        }

        internal function groupToFooterDisplayIndex(arg1:int):int
        {
            var loc6:*=null;
            var loc7:*=0;
            var loc8:*=0;
            var loc1:*=this._dataProvider.getItemAt(arg1);
            var loc2:*=this._owner.groupToFooterData(loc1);
            if (!loc2) 
            {
                return -1;
            }
            var loc3:*=0;
            var loc4:*=this._dataProvider.getLength();
            var loc5:*=0;
            while (loc5 < loc4) 
            {
                loc1 = this._dataProvider.getItemAt(loc5);
                loc6 = this._owner.groupToHeaderData(loc1);
                if (loc6) 
                {
                    ++loc3;
                }
                loc7 = this._dataProvider.getLength(loc5);
                loc8 = 0;
                while (loc8 < loc7) 
                {
                    ++loc3;
                    ++loc8;
                }
                loc2 = this._owner.groupToFooterData(loc1);
                if (loc2) 
                {
                    if (arg1 == loc5) 
                    {
                        return loc3;
                    }
                    ++loc3;
                }
                ++loc5;
            }
            return -1;
        }

        internal function locationToDisplayIndex(arg1:int, arg2:int):int
        {
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=null;
            var loc1:*=0;
            var loc2:*=this._dataProvider.getLength();
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                if (arg2 < 0 && arg1 == loc3) 
                {
                    return loc1;
                }
                loc4 = this._dataProvider.getItemAt(loc3);
                loc5 = this._owner.groupToHeaderData(loc4);
                if (loc5) 
                {
                    ++loc1;
                }
                loc6 = this._dataProvider.getLength(loc3);
                loc7 = 0;
                while (loc7 < loc6) 
                {
                    if (arg1 == loc3 && arg2 == loc7) 
                    {
                        return loc1;
                    }
                    ++loc1;
                    ++loc7;
                }
                loc8 = this._owner.groupToFooterData(loc4);
                if (loc8) 
                {
                    ++loc1;
                }
                ++loc3;
            }
            return -1;
        }

        internal function indexToCustomStyleName(arg1:int, arg2:int):String
        {
            var loc1:*=0;
            if (!(this._dataProvider === null) && this._dataProvider.getLength() > 0) 
            {
                loc1 = this._dataProvider.getLength(arg1);
            }
            if (arg2 === 0) 
            {
                if (!(this._customSingleItemRendererStyleName === null) && loc1 === 1) 
                {
                    return this._customSingleItemRendererStyleName;
                }
                if (this._customFirstItemRendererStyleName !== null) 
                {
                    return this._customFirstItemRendererStyleName;
                }
            }
            if (!(this._customLastItemRendererStyleName === null) && arg2 === (loc1 - 1)) 
            {
                return this._customLastItemRendererStyleName;
            }
            return this._customItemRendererStyleName;
        }

        internal function getFactoryID(arg1:Object, arg2:int, arg3:int):String
        {
            var loc1:*=0;
            if (this._factoryIDFunction === null) 
            {
                loc1 = 0;
                if (!(this._dataProvider === null) && this._dataProvider.getLength() > 0) 
                {
                    loc1 = this._dataProvider.getLength(arg2);
                }
                if (arg3 === 0) 
                {
                    if ((!(this._singleItemRendererType === null) || !(this._singleItemRendererFactory === null) || !(this._customSingleItemRendererStyleName === null)) && loc1 === 1) 
                    {
                        return SINGLE_ITEM_RENDERER_FACTORY_ID;
                    }
                    if (!(this._firstItemRendererType === null) || !(this._firstItemRendererFactory === null) || !(this._customFirstItemRendererStyleName === null)) 
                    {
                        return FIRST_ITEM_RENDERER_FACTORY_ID;
                    }
                }
                if ((!(this._lastItemRendererType === null) || !(this._lastItemRendererFactory === null) || !(this._customLastItemRendererStyleName === null)) && arg3 === (loc1 - 1)) 
                {
                    return LAST_ITEM_RENDERER_FACTORY_ID;
                }
                return null;
            }
            if (this._factoryIDFunction.length === 1) 
            {
                return this._factoryIDFunction(arg1);
            }
            return this._factoryIDFunction(arg1, arg2, arg3);
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
            if (this._owner) 
            {
                this._owner.removeEventListener(feathers.events.FeathersEventType.SCROLL_START, this.owner_scrollStartHandler);
            }
            this._owner = arg1;
            if (this._owner) 
            {
                this._owner.addEventListener(feathers.events.FeathersEventType.SCROLL_START, this.owner_scrollStartHandler);
            }
            return;
        }

        internal function factoryIDToFactory(arg1:String, arg2:int, arg3:int):Function
        {
            if (arg1 !== null) 
            {
                if (arg1 === FIRST_ITEM_RENDERER_FACTORY_ID) 
                {
                    if (this._firstItemRendererFactory !== null) 
                    {
                        return this._firstItemRendererFactory;
                    }
                    return this._itemRendererFactory;
                }
                if (arg1 === LAST_ITEM_RENDERER_FACTORY_ID) 
                {
                    if (this._lastItemRendererFactory !== null) 
                    {
                        return this._lastItemRendererFactory;
                    }
                    return this._itemRendererFactory;
                }
                if (arg1 === SINGLE_ITEM_RENDERER_FACTORY_ID) 
                {
                    if (this._singleItemRendererFactory !== null) 
                    {
                        return this._singleItemRendererFactory;
                    }
                    return this._itemRendererFactory;
                }
                if (arg1 in this._itemRendererFactories) 
                {
                    return this._itemRendererFactories[arg1] as Function;
                }
                throw new ReferenceError("Cannot find item renderer factory for ID \"" + arg1 + "\".");
            }
            return this._itemRendererFactory;
        }

        internal function factoryIDToStorage(arg1:String, arg2:int, arg3:int):ItemRendererFactoryStorage
        {
            var loc1:*=null;
            if (arg1 !== null) 
            {
                if (arg1 in this._itemStorageMap) 
                {
                    return ItemRendererFactoryStorage(this._itemStorageMap[arg1]);
                }
                loc1 = new ItemRendererFactoryStorage();
                this._itemStorageMap[arg1] = loc1;
                return loc1;
            }
            return this._defaultItemRendererStorage;
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
                this._dataProvider.removeEventListener(starling.events.Event.CHANGE, this.dataProvider_changeHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.RESET, this.dataProvider_resetHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.ADD_ITEM, this.dataProvider_addItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.REMOVE_ITEM, this.dataProvider_removeItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.REPLACE_ITEM, this.dataProvider_replaceItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.UPDATE_ITEM, this.dataProvider_updateItemHandler);
                this._dataProvider.removeEventListener(feathers.events.CollectionEventType.UPDATE_ALL, this.dataProvider_updateAllHandler);
            }
            this._dataProvider = arg1;
            if (this._dataProvider) 
            {
                this._dataProvider.addEventListener(starling.events.Event.CHANGE, this.dataProvider_changeHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.RESET, this.dataProvider_resetHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.ADD_ITEM, this.dataProvider_addItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.REMOVE_ITEM, this.dataProvider_removeItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.REPLACE_ITEM, this.dataProvider_replaceItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.UPDATE_ITEM, this.dataProvider_updateItemHandler);
                this._dataProvider.addEventListener(feathers.events.CollectionEventType.UPDATE_ALL, this.dataProvider_updateAllHandler);
            }
            if (this._layout is feathers.layout.IVariableVirtualLayout) 
            {
                feathers.layout.IVariableVirtualLayout(this._layout).resetVariableVirtualCache();
            }
            this._updateForDataReset = true;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        internal function headerFactoryIDToFactory(arg1:String):Function
        {
            if (arg1 !== null) 
            {
                if (arg1 in this._headerRendererFactories) 
                {
                    return this._headerRendererFactories[arg1] as Function;
                }
                throw new ReferenceError("Cannot find header renderer factory for ID \"" + arg1 + "\".");
            }
            return this._headerRendererFactory;
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

        internal function headerFactoryIDToStorage(arg1:String):HeaderRendererFactoryStorage
        {
            var loc1:*=null;
            if (arg1 !== null) 
            {
                if (arg1 in this._headerStorageMap) 
                {
                    return HeaderRendererFactoryStorage(this._headerStorageMap[arg1]);
                }
                loc1 = new HeaderRendererFactoryStorage();
                this._headerStorageMap[arg1] = loc1;
                return loc1;
            }
            return this._defaultHeaderRendererStorage;
        }

        public function get selectedGroupIndex():int
        {
            return this._selectedGroupIndex;
        }

        internal function footerFactoryIDToFactory(arg1:String):Function
        {
            if (arg1 !== null) 
            {
                if (arg1 in this._footerRendererFactories) 
                {
                    return this._footerRendererFactories[arg1] as Function;
                }
                throw new ReferenceError("Cannot find footer renderer factory for ID \"" + arg1 + "\".");
            }
            return this._footerRendererFactory;
        }

        public function get selectedItemIndex():int
        {
            return this._selectedItemIndex;
        }

        internal function footerFactoryIDToStorage(arg1:String):FooterRendererFactoryStorage
        {
            var loc1:*=null;
            if (arg1 !== null) 
            {
                if (arg1 in this._footerStorageMap) 
                {
                    return FooterRendererFactoryStorage(this._footerStorageMap[arg1]);
                }
                loc1 = new FooterRendererFactoryStorage();
                this._footerStorageMap[arg1] = loc1;
                return loc1;
            }
            return this._defaultFooterRendererStorage;
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
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function childProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:String):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
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
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function owner_scrollStartHandler(arg1:starling.events.Event):void
        {
            this._isScrolling = true;
            return;
        }

        public function get itemRendererFactories():Object
        {
            return this._itemRendererFactories;
        }

        public function set itemRendererFactories(arg1:Object):void
        {
            if (this._itemRendererFactories === arg1) 
            {
                return;
            }
            this._itemRendererFactories = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function dataProvider_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_DATA);
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
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function dataProvider_addItemHandler(arg1:starling.events.Event, arg2:Array):void
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=0;
            var loc8:*=0;
            var loc9:*=0;
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            var loc2:*=arg2[0] as int;
            if (arg2.length > 1) 
            {
                loc3 = arg2[1] as int;
                loc4 = this.locationToDisplayIndex(loc2, loc3);
                loc1.addToVariableVirtualCacheAtIndex(loc4);
            }
            else 
            {
                loc5 = this.groupToHeaderDisplayIndex(loc2);
                if (loc5 >= 0) 
                {
                    loc1.addToVariableVirtualCacheAtIndex(loc5);
                }
                loc6 = this._dataProvider.getLength(loc2);
                if (loc6 > 0) 
                {
                    loc8 = loc5;
                    if (loc8 < 0) 
                    {
                        loc8 = this.locationToDisplayIndex(loc2, 0);
                    }
                    loc6 = loc6 + loc8;
                    loc9 = loc8;
                    while (loc9 < loc6) 
                    {
                        loc1.addToVariableVirtualCacheAtIndex(loc8);
                        ++loc9;
                    }
                }
                loc7 = this.groupToFooterDisplayIndex(loc2);
                if (loc7 >= 0) 
                {
                    loc1.addToVariableVirtualCacheAtIndex(loc7);
                }
            }
            return;
        }

        public function get customItemRendererStyleName():String
        {
            return this._customItemRendererStyleName;
        }

        public function set customItemRendererStyleName(arg1:String):void
        {
            if (this._customItemRendererStyleName == arg1) 
            {
                return;
            }
            this._customItemRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function dataProvider_removeItemHandler(arg1:starling.events.Event, arg2:Array):void
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            var loc2:*=arg2[0] as int;
            if (arg2.length > 1) 
            {
                loc3 = arg2[1] as int;
                loc4 = this.locationToDisplayIndex(loc2, loc3);
                loc1.removeFromVariableVirtualCacheAtIndex(loc4);
            }
            else 
            {
                loc1.resetVariableVirtualCache();
            }
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

        internal function dataProvider_replaceItemHandler(arg1:starling.events.Event, arg2:Array):void
        {
            var loc3:*=0;
            var loc4:*=0;
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            var loc2:*=arg2[0] as int;
            if (arg2.length > 1) 
            {
                loc3 = arg2[1] as int;
                loc4 = this.locationToDisplayIndex(loc2, loc3);
                loc1.resetVariableVirtualCacheAtIndex(loc4);
            }
            else 
            {
                loc1.resetVariableVirtualCache();
            }
            return;
        }

        public function get itemRendererProperties():feathers.core.PropertyProxy
        {
            return this._itemRendererProperties;
        }

        public function set itemRendererProperties(arg1:feathers.core.PropertyProxy):void
        {
            if (this._itemRendererProperties == arg1) 
            {
                return;
            }
            if (this._itemRendererProperties) 
            {
                this._itemRendererProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._itemRendererProperties = feathers.core.PropertyProxy(arg1);
            if (this._itemRendererProperties) 
            {
                this._itemRendererProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        internal function dataProvider_resetHandler(arg1:starling.events.Event):void
        {
            this._updateForDataReset = true;
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            loc1.resetVariableVirtualCache();
            return;
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
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function dataProvider_updateItemHandler(arg1:starling.events.Event, arg2:Array):void
        {
            var loc2:*=0;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=null;
            var loc8:*=null;
            var loc9:*=null;
            var loc10:*=null;
            var loc1:*=arg2[0] as int;
            if (arg2.length > 1) 
            {
                loc2 = arg2[1] as int;
                loc3 = this._dataProvider.getItemAt(loc1, loc2);
                loc4 = feathers.controls.renderers.IGroupedListItemRenderer(this._itemRendererMap[loc3]);
                if (loc4 !== null) 
                {
                    loc4.data = null;
                    loc4.data = loc3;
                    if (!(this._explicitVisibleWidth === this._explicitVisibleWidth) || !(this._explicitVisibleHeight === this._explicitVisibleHeight)) 
                    {
                        this.invalidate(INVALIDATION_FLAG_SIZE);
                        this.invalidateParent(INVALIDATION_FLAG_SIZE);
                    }
                }
            }
            else 
            {
                loc5 = this._dataProvider.getLength(loc1);
                loc6 = 0;
                while (loc6 < loc5) 
                {
                    loc3 = this._dataProvider.getItemAt(loc1, loc6);
                    if (loc3) 
                    {
                        loc4 = feathers.controls.renderers.IGroupedListItemRenderer(this._itemRendererMap[loc3]);
                        if (loc4) 
                        {
                            loc4.data = null;
                            loc4.data = loc3;
                        }
                    }
                    ++loc6;
                }
                loc7 = this._dataProvider.getItemAt(loc1);
                loc3 = this._owner.groupToHeaderData(loc7);
                if (loc3) 
                {
                    loc9 = feathers.controls.renderers.IGroupedListHeaderRenderer(this._headerRendererMap[loc3]);
                    if (loc9) 
                    {
                        loc9.data = null;
                        loc9.data = loc3;
                    }
                }
                loc3 = this._owner.groupToFooterData(loc7);
                if (loc3) 
                {
                    loc10 = feathers.controls.renderers.IGroupedListFooterRenderer(this._footerRendererMap[loc3]);
                    if (loc10) 
                    {
                        loc10.data = null;
                        loc10.data = loc3;
                    }
                }
                this.invalidate(INVALIDATION_FLAG_DATA);
                loc8 = this._layout as feathers.layout.IVariableVirtualLayout;
                if (loc8 === null || !loc8.hasVariableItemDimensions) 
                {
                    return;
                }
                loc8.resetVariableVirtualCache();
            }
            return;
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
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        public function get layout():feathers.layout.ILayout
        {
            return this._layout;
        }

        public function get customFirstItemRendererStyleName():String
        {
            return this._customFirstItemRendererStyleName;
        }

        public function set customFirstItemRendererStyleName(arg1:String):void
        {
            if (this._customFirstItemRendererStyleName == arg1) 
            {
                return;
            }
            this._customFirstItemRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function dataProvider_updateAllHandler(arg1:starling.events.Event):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            var loc5:*=null;
            var loc6:*=null;
            var loc7:*=0;
            var loc8:*=this._itemRendererMap;
            for (loc1 in loc8) 
            {
                loc4 = feathers.controls.renderers.IGroupedListItemRenderer(this._itemRendererMap[loc1]);
                if (loc4 === null) 
                {
                    continue;
                }
                loc4.data = null;
                loc4.data = loc1;
            }
            loc7 = 0;
            loc8 = this._headerRendererMap;
            for (loc2 in loc8) 
            {
                loc5 = feathers.controls.renderers.IGroupedListHeaderRenderer(this._headerRendererMap[loc2]);
                if (loc5 === null) 
                {
                    continue;
                }
                loc5.data = null;
                loc5.data = loc2;
            }
            loc7 = 0;
            loc8 = this._footerRendererMap;
            for (loc3 in loc8) 
            {
                loc6 = feathers.controls.renderers.IGroupedListFooterRenderer(this._footerRendererMap[loc3]);
                if (loc6 === null) 
                {
                    continue;
                }
                loc6.data = null;
                loc6.data = loc3;
            }
            return;
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
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function layout_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreLayoutChanges) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            this.invalidateParent(INVALIDATION_FLAG_LAYOUT);
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
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function itemRenderer_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreRendererResizing) 
            {
                return;
            }
            if (arg1.currentTarget === this._typicalItemRenderer && !this._typicalItemIsInDataProvider) 
            {
                return;
            }
            var loc1:*=feathers.controls.renderers.IGroupedListItemRenderer(arg1.currentTarget);
            if (loc1.layoutIndex < 0) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            this.invalidateParent(INVALIDATION_FLAG_LAYOUT);
            var loc2:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc2 || !loc2.hasVariableItemDimensions) 
            {
                return;
            }
            loc2.resetVariableVirtualCacheAtIndex(loc1.layoutIndex, starling.display.DisplayObject(loc1));
            return;
        }

        public function get customLastItemRendererStyleName():String
        {
            return this._customLastItemRendererStyleName;
        }

        public function set customLastItemRendererStyleName(arg1:String):void
        {
            if (this._customLastItemRendererStyleName == arg1) 
            {
                return;
            }
            this._customLastItemRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function headerRenderer_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreRendererResizing) 
            {
                return;
            }
            var loc1:*=feathers.controls.renderers.IGroupedListHeaderRenderer(arg1.currentTarget);
            if (loc1.layoutIndex < 0) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            this.invalidateParent(INVALIDATION_FLAG_LAYOUT);
            var loc2:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc2 || !loc2.hasVariableItemDimensions) 
            {
                return;
            }
            loc2.resetVariableVirtualCacheAtIndex(loc1.layoutIndex, starling.display.DisplayObject(loc1));
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
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function footerRenderer_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreRendererResizing) 
            {
                return;
            }
            var loc1:*=feathers.controls.renderers.IGroupedListFooterRenderer(arg1.currentTarget);
            if (loc1.layoutIndex < 0) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            this.invalidateParent(INVALIDATION_FLAG_LAYOUT);
            var loc2:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc2 || !loc2.hasVariableItemDimensions) 
            {
                return;
            }
            loc2.resetVariableVirtualCacheAtIndex(loc1.layoutIndex, starling.display.DisplayObject(loc1));
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
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function renderer_triggeredHandler(arg1:starling.events.Event):void
        {
            var loc1:*=feathers.controls.renderers.IGroupedListItemRenderer(arg1.currentTarget);
            this.parent.dispatchEventWith(starling.events.Event.TRIGGERED, false, loc1.data);
            return;
        }

        public function get customSingleItemRendererStyleName():String
        {
            return this._customSingleItemRendererStyleName;
        }

        public function set customSingleItemRendererStyleName(arg1:String):void
        {
            if (this._customSingleItemRendererStyleName == arg1) 
            {
                return;
            }
            this._customSingleItemRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function renderer_changeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreSelectionChanges) 
            {
                return;
            }
            var loc1:*=feathers.controls.renderers.IGroupedListItemRenderer(arg1.currentTarget);
            if (!this._isSelectable || this._isScrolling) 
            {
                loc1.isSelected = false;
                return;
            }
            if (loc1.isSelected) 
            {
                this.setSelectedLocation(loc1.groupIndex, loc1.itemIndex);
            }
            else 
            {
                this.setSelectedLocation(-1, -1);
            }
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
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.touchPointID = -1;
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
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (!this._isEnabled) 
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
            }
            else 
            {
                loc1 = arg1.getTouch(this, starling.events.TouchPhase.BEGAN);
                if (!loc1) 
                {
                    return;
                }
                this.touchPointID = loc1.id;
                this._isScrolling = false;
            }
            return;
        }

        public function get headerRendererFactories():Object
        {
            return this._headerRendererFactories;
        }

        public function set headerRendererFactories(arg1:Object):void
        {
            if (this._headerRendererFactories === arg1) 
            {
                return;
            }
            this._headerRendererFactories = arg1;
            if (arg1 !== null) 
            {
                this._headerStorageMap = {};
            }
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function indexToItemRendererType(arg1:int, arg2:int):Class
        {
            var loc1:*=0;
            if (!(this._dataProvider === null) && this._dataProvider.getLength() > 0) 
            {
                loc1 = this._dataProvider.getLength(arg1);
            }
            if (arg2 === 0) 
            {
                if (!(this._singleItemRendererType === null) && loc1 === 1) 
                {
                    return this._singleItemRendererType;
                }
                if (this._firstItemRendererType !== null) 
                {
                    return this._firstItemRendererType;
                }
            }
            if (!(this._lastItemRendererType === null) && arg2 === (loc1 - 1)) 
            {
                return this._lastItemRendererType;
            }
            return this._itemRendererType;
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
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        public function get customHeaderRendererStyleName():String
        {
            return this._customHeaderRendererStyleName;
        }

        public function set customHeaderRendererStyleName(arg1:String):void
        {
            if (this._customHeaderRendererStyleName == arg1) 
            {
                return;
            }
            this._customHeaderRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        public function get headerRendererProperties():feathers.core.PropertyProxy
        {
            return this._headerRendererProperties;
        }

        public function set headerRendererProperties(arg1:feathers.core.PropertyProxy):void
        {
            if (this._headerRendererProperties == arg1) 
            {
                return;
            }
            if (this._headerRendererProperties) 
            {
                this._headerRendererProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._headerRendererProperties = feathers.core.PropertyProxy(arg1);
            if (this._headerRendererProperties) 
            {
                this._headerRendererProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
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
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
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
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        public function get footerRendererFactories():Object
        {
            return this._footerRendererFactories;
        }

        public function set footerRendererFactories(arg1:Object):void
        {
            if (this._footerRendererFactories === arg1) 
            {
                return;
            }
            this._footerRendererFactories = arg1;
            if (arg1 !== null) 
            {
                this._footerStorageMap = {};
            }
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
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
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        public function get customFooterRendererStyleName():String
        {
            return this._customFooterRendererStyleName;
        }

        public function set customFooterRendererStyleName(arg1:String):void
        {
            if (this._customFooterRendererStyleName == arg1) 
            {
                return;
            }
            this._customFooterRendererStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        public function get footerRendererProperties():feathers.core.PropertyProxy
        {
            return this._footerRendererProperties;
        }

        public function set footerRendererProperties(arg1:feathers.core.PropertyProxy):void
        {
            if (this._footerRendererProperties == arg1) 
            {
                return;
            }
            if (this._footerRendererProperties) 
            {
                this._footerRendererProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._footerRendererProperties = feathers.core.PropertyProxy(arg1);
            if (this._footerRendererProperties) 
            {
                this._footerRendererProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function set layout(arg1:feathers.layout.ILayout):void
        {
            var loc1:*=null;
            if (this._layout == arg1) 
            {
                return;
            }
            if (this._layout) 
            {
                this._layout.removeEventListener(starling.events.Event.CHANGE, this.layout_changeHandler);
            }
            this._layout = arg1;
            if (this._layout) 
            {
                if (this._layout is feathers.layout.IVariableVirtualLayout) 
                {
                    loc1 = feathers.layout.IVariableVirtualLayout(this._layout);
                    loc1.hasVariableItemDimensions = true;
                    loc1.resetVariableVirtualCache();
                }
                this._layout.addEventListener(starling.events.Event.CHANGE, this.layout_changeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        public function get horizontalScrollPosition():Number
        {
            return this._horizontalScrollPosition;
        }

        public function set horizontalScrollPosition(arg1:Number):void
        {
            if (this._horizontalScrollPosition == arg1) 
            {
                return;
            }
            this._horizontalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        public function get verticalScrollPosition():Number
        {
            return this._verticalScrollPosition;
        }

        public function set verticalScrollPosition(arg1:Number):void
        {
            if (this._verticalScrollPosition == arg1) 
            {
                return;
            }
            this._verticalScrollPosition = arg1;
            this.invalidate(INVALIDATION_FLAG_SCROLL);
            return;
        }

        public function get requiresMeasurementOnScroll():Boolean
        {
            return this._layout.requiresLayoutOnScroll && (!(this._explicitVisibleWidth === this._explicitVisibleWidth) || !(this._explicitVisibleHeight === this._explicitVisibleHeight));
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

        public function getScrollPositionForIndex(arg1:int, arg2:int, arg3:flash.geom.Point=null):flash.geom.Point
        {
            if (!arg3) 
            {
                arg3 = new flash.geom.Point();
            }
            var loc1:*=this.locationToDisplayIndex(arg1, arg2);
            return this._layout.getScrollPositionForIndex(loc1, this._layoutItems, 0, 0, this._actualVisibleWidth, this._actualVisibleHeight, arg3);
        }

        public function getNearestScrollPositionForIndex(arg1:int, arg2:int, arg3:flash.geom.Point=null):flash.geom.Point
        {
            if (!arg3) 
            {
                arg3 = new flash.geom.Point();
            }
            var loc1:*=this.locationToDisplayIndex(arg1, arg2);
            return this._layout.getNearestScrollPositionForIndex(loc1, this._horizontalScrollPosition, this._verticalScrollPosition, this._layoutItems, 0, 0, this._actualVisibleWidth, this._actualVisibleHeight, arg3);
        }

        public function itemToItemRenderer(arg1:Object):feathers.controls.renderers.IGroupedListItemRenderer
        {
            return feathers.controls.renderers.IGroupedListItemRenderer(this._itemRendererMap[arg1]);
        }

        public function headerDataToHeaderRenderer(arg1:Object):feathers.controls.renderers.IGroupedListHeaderRenderer
        {
            return feathers.controls.renderers.IGroupedListHeaderRenderer(this._headerRendererMap[arg1]);
        }

        public function footerDataToFooterRenderer(arg1:Object):feathers.controls.renderers.IGroupedListFooterRenderer
        {
            return feathers.controls.renderers.IGroupedListFooterRenderer(this._footerRendererMap[arg1]);
        }

        public override function dispose():void
        {
            this.refreshInactiveRenderers(true);
            this.owner = null;
            this.dataProvider = null;
            this.layout = null;
            super.dispose();
            return;
        }

        protected override function draw():void
        {
            var loc12:*=false;
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_SCROLL);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_SELECTED);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            var loc6:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc7:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc8:*=this.isInvalid(INVALIDATION_FLAG_LAYOUT);
            if (!loc8 && loc2 && this._layout && this._layout.requiresLayoutOnScroll) 
            {
                loc8 = true;
            }
            var loc9:*=loc3 || loc1 || loc8 || loc5;
            var loc10:*=this._ignoreRendererResizing;
            this._ignoreRendererResizing = true;
            var loc11:*=this._ignoreLayoutChanges;
            this._ignoreLayoutChanges = true;
            if (loc2 || loc3) 
            {
                this.refreshViewPortBounds();
            }
            if (loc9) 
            {
                this.refreshInactiveRenderers(loc5);
            }
            if (loc1 || loc8 || loc5) 
            {
                this.refreshLayoutTypicalItem();
            }
            if (loc9) 
            {
                this.refreshRenderers();
            }
            if (loc6 || loc9) 
            {
                this.refreshHeaderRendererStyles();
                this.refreshFooterRendererStyles();
                this.refreshItemRendererStyles();
            }
            if (loc4 || loc9) 
            {
                loc12 = this._ignoreSelectionChanges;
                this._ignoreSelectionChanges = true;
                this.refreshSelection();
                this._ignoreSelectionChanges = loc12;
            }
            if (loc7 || loc9) 
            {
                this.refreshEnabled();
            }
            this._ignoreLayoutChanges = loc11;
            if (loc7 || loc4 || loc6 || loc9) 
            {
                this._layout.layout(this._layoutItems, this._viewPortBounds, this._layoutResult);
            }
            this._ignoreRendererResizing = loc10;
            this._contentX = this._layoutResult.contentX;
            this._contentY = this._layoutResult.contentY;
            this.saveMeasurements(this._layoutResult.contentWidth, this._layoutResult.contentHeight, this._layoutResult.contentWidth, this._layoutResult.contentHeight);
            this._actualVisibleWidth = this._layoutResult.viewPortWidth;
            this._actualVisibleHeight = this._layoutResult.viewPortHeight;
            this._actualMinVisibleWidth = this._layoutResult.viewPortWidth;
            this._actualMinVisibleHeight = this._layoutResult.viewPortHeight;
            this.validateRenderers();
            return;
        }

        internal function validateRenderers():void
        {
            var loc3:*=null;
            var loc1:*=this._layoutItems.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._layoutItems[loc2] as feathers.core.IValidating;
                if (loc3) 
                {
                    loc3.validate();
                }
                ++loc2;
            }
            return;
        }

        internal function refreshEnabled():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._layoutItems;
            for each (loc1 in loc4) 
            {
                loc2 = loc1 as feathers.core.IFeathersControl;
                if (!loc2) 
                {
                    continue;
                }
                loc2.isEnabled = this._isEnabled;
            }
            return;
        }

        internal function invalidateParent(arg1:String="all"):void
        {
            feathers.controls.Scroller(this.parent).invalidate(arg1);
            return;
        }

        internal function refreshLayoutTypicalItem():void
        {
            var loc8:*=0;
            var loc9:*=null;
            var loc10:*=false;
            var loc11:*=null;
            var loc1:*=this._layout as feathers.layout.IVirtualLayout;
            if (!loc1 || !loc1.useVirtualLayout) 
            {
                if (!this._typicalItemIsInDataProvider && this._typicalItemRenderer) 
                {
                    this.destroyItemRenderer(this._typicalItemRenderer);
                    this._typicalItemRenderer = null;
                }
                return;
            }
            var loc2:*=false;
            var loc3:*=this._typicalItem;
            var loc4:*=0;
            var loc5:*=0;
            var loc6:*=0;
            var loc7:*=0;
            if (this._dataProvider) 
            {
                if (loc3 === null) 
                {
                    loc4 = this._dataProvider.getLength();
                    if (loc4 > 0) 
                    {
                        loc8 = 0;
                        while (loc8 < loc4) 
                        {
                            loc5 = this._dataProvider.getLength(loc8);
                            if (loc5 > 0) 
                            {
                                loc2 = true;
                                loc6 = loc8;
                                loc3 = this._dataProvider.getItemAt(loc8, 0);
                            }
                            ++loc8;
                        }
                    }
                }
                else 
                {
                    this._dataProvider.getItemLocation(loc3, HELPER_VECTOR);
                    if (HELPER_VECTOR.length > 1) 
                    {
                        loc2 = true;
                        loc6 = HELPER_VECTOR[0];
                        loc7 = HELPER_VECTOR[1];
                    }
                }
            }
            if (loc3 !== null) 
            {
                loc9 = feathers.controls.renderers.IGroupedListItemRenderer(this._itemRendererMap[loc3]);
                if (loc9) 
                {
                    loc9.groupIndex = loc6;
                    loc9.itemIndex = loc7;
                }
                if (!loc9 && this._typicalItemRenderer) 
                {
                    loc10 = !this._typicalItemIsInDataProvider;
                    if (loc10) 
                    {
                        loc11 = this.getFactoryID(loc3, loc6, loc7);
                        if (this._typicalItemRenderer.factoryID !== loc11) 
                        {
                            loc10 = false;
                        }
                    }
                    if (loc10) 
                    {
                        loc9 = this._typicalItemRenderer;
                        loc9.data = loc3;
                        loc9.groupIndex = loc6;
                        loc9.itemIndex = loc7;
                    }
                }
                if (!loc9) 
                {
                    loc9 = this.createItemRenderer(loc3, 0, 0, 0, false, !loc2);
                    if (!this._typicalItemIsInDataProvider && this._typicalItemRenderer) 
                    {
                        this.destroyItemRenderer(this._typicalItemRenderer);
                        this._typicalItemRenderer = null;
                    }
                }
            }
            loc1.typicalItem = starling.display.DisplayObject(loc9);
            this._typicalItemRenderer = loc9;
            this._typicalItemIsInDataProvider = loc2;
            if (this._typicalItemRenderer && !this._typicalItemIsInDataProvider) 
            {
                this._typicalItemRenderer.addEventListener(feathers.events.FeathersEventType.RESIZE, this.itemRenderer_resizeHandler);
            }
            return;
        }

        internal function refreshItemRendererStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._layoutItems;
            for each (loc1 in loc4) 
            {
                loc2 = loc1 as feathers.controls.renderers.IGroupedListItemRenderer;
                if (!loc2) 
                {
                    continue;
                }
                this.refreshOneItemRendererStyles(loc2);
            }
            return;
        }

        internal static const HELPER_VECTOR:__AS3__.vec.Vector.<int>=new Vector.<int>(0);

        internal static const INVALIDATION_FLAG_ITEM_RENDERER_FACTORY:String="itemRendererFactory";

        internal static const FIRST_ITEM_RENDERER_FACTORY_ID:String="GroupedListDataViewPort-first";

        internal static const SINGLE_ITEM_RENDERER_FACTORY_ID:String="GroupedListDataViewPort-single";

        internal static const LAST_ITEM_RENDERER_FACTORY_ID:String="GroupedListDataViewPort-last";

        internal var _maxVisibleWidth:Number=Infinity;

        internal var _actualVisibleWidth:Number=NaN;

        internal var _explicitVisibleWidth:Number=NaN;

        internal var _actualMinVisibleHeight:Number=0;

        internal var _explicitMinVisibleHeight:Number;

        internal var _maxVisibleHeight:Number=Infinity;

        internal var _actualVisibleHeight:Number;

        internal var _explicitVisibleHeight:Number=NaN;

        protected var _contentX:Number=0;

        protected var _contentY:Number=0;

        internal var _layoutItems:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        internal var _typicalItemIsInDataProvider:Boolean=false;

        internal var _typicalItemRenderer:feathers.controls.renderers.IGroupedListItemRenderer;

        internal var _unrenderedItems:__AS3__.vec.Vector.<int>;

        internal var _defaultItemRendererStorage:ItemRendererFactoryStorage;

        internal var _itemStorageMap:Object;

        internal var _itemRendererMap:flash.utils.Dictionary;

        internal var _unrenderedHeaders:__AS3__.vec.Vector.<int>;

        internal var _defaultHeaderRendererStorage:HeaderRendererFactoryStorage;

        internal var _headerStorageMap:Object;

        internal var _headerRendererMap:flash.utils.Dictionary;

        internal var _unrenderedFooters:__AS3__.vec.Vector.<int>;

        internal var _defaultFooterRendererStorage:FooterRendererFactoryStorage;

        internal var _footerStorageMap:Object;

        internal var _footerRendererMap:flash.utils.Dictionary;

        internal var _headerIndices:__AS3__.vec.Vector.<int>;

        internal var _footerIndices:__AS3__.vec.Vector.<int>;

        internal var _isScrolling:Boolean=false;

        internal var _owner:feathers.controls.GroupedList;

        internal var _updateForDataReset:Boolean=false;

        internal var _dataProvider:feathers.data.HierarchicalCollection;

        internal var _isSelectable:Boolean=true;

        internal var _selectedGroupIndex:int=-1;

        internal var _selectedItemIndex:int=-1;

        internal var _itemRendererType:Class;

        internal var _itemRendererFactory:Function;

        internal var _itemRendererFactories:Object;

        internal var _factoryIDFunction:Function;

        internal var _customItemRendererStyleName:String;

        internal var _typicalItem:Object=null;

        internal var _itemRendererProperties:feathers.core.PropertyProxy;

        internal var _firstItemRendererType:Class;

        internal var _firstItemRendererFactory:Function;

        internal var _lastItemRendererType:Class;

        internal var _lastItemRendererFactory:Function;

        internal var _customLastItemRendererStyleName:String;

        internal var _singleItemRendererType:Class;

        internal var _singleItemRendererFactory:Function;

        internal var _customSingleItemRendererStyleName:String;

        internal var _headerRendererType:Class;

        internal var _headerRendererFactory:Function;

        internal var _headerRendererFactories:Object;

        internal var _customFooterRendererStyleName:String;

        internal var _verticalScrollPosition:Number=0;

        internal var _footerRendererFactories:Object;

        internal var _headerRendererProperties:feathers.core.PropertyProxy;

        internal var _footerRendererProperties:feathers.core.PropertyProxy;

        internal var touchPointID:int=-1;

        internal var _minimumHeaderCount:int;

        internal var _minimumFooterCount:int;

        internal var _minimumFirstAndLastItemCount:int;

        internal var _minimumSingleItemCount:int;

        internal var _ignoreSelectionChanges:Boolean=false;

        internal var _footerRendererFactory:Function;

        internal var _footerFactoryIDFunction:Function;

        internal var _ignoreLayoutChanges:Boolean=false;

        internal var _ignoreRendererResizing:Boolean=false;

        internal var _minimumItemCount:int;

        internal var _customFirstItemRendererStyleName:String;

        internal var _headerFactoryIDFunction:Function;

        internal var _footerRendererType:Class;

        internal var _horizontalScrollPosition:Number=0;

        internal var _customHeaderRendererStyleName:String;

        internal var _viewPortBounds:feathers.layout.ViewPortBounds;

        internal var _layoutResult:feathers.layout.LayoutBoundsResult;

        internal var _actualMinVisibleWidth:Number=0;

        internal var _explicitMinVisibleWidth:Number;

        internal var _layout:feathers.layout.ILayout;
    }
}

import __AS3__.vec.*;
import feathers.controls.renderers.*;


class ItemRendererFactoryStorage extends Object
{
    public function ItemRendererFactoryStorage()
    {
        this.activeItemRenderers = new Vector.<feathers.controls.renderers.IGroupedListItemRenderer>(0);
        this.inactiveItemRenderers = new Vector.<feathers.controls.renderers.IGroupedListItemRenderer>(0);
        super();
        return;
    }

    public var activeItemRenderers:__AS3__.vec.Vector.<feathers.controls.renderers.IGroupedListItemRenderer>;

    public var inactiveItemRenderers:__AS3__.vec.Vector.<feathers.controls.renderers.IGroupedListItemRenderer>;
}

class HeaderRendererFactoryStorage extends Object
{
    public function HeaderRendererFactoryStorage()
    {
        this.activeHeaderRenderers = new Vector.<feathers.controls.renderers.IGroupedListHeaderRenderer>(0);
        this.inactiveHeaderRenderers = new Vector.<feathers.controls.renderers.IGroupedListHeaderRenderer>(0);
        super();
        return;
    }

    public var activeHeaderRenderers:__AS3__.vec.Vector.<feathers.controls.renderers.IGroupedListHeaderRenderer>;

    public var inactiveHeaderRenderers:__AS3__.vec.Vector.<feathers.controls.renderers.IGroupedListHeaderRenderer>;
}

class FooterRendererFactoryStorage extends Object
{
    public function FooterRendererFactoryStorage()
    {
        this.activeFooterRenderers = new Vector.<feathers.controls.renderers.IGroupedListFooterRenderer>(0);
        this.inactiveFooterRenderers = new Vector.<feathers.controls.renderers.IGroupedListFooterRenderer>(0);
        super();
        return;
    }

    public var activeFooterRenderers:__AS3__.vec.Vector.<feathers.controls.renderers.IGroupedListFooterRenderer>;

    public var inactiveFooterRenderers:__AS3__.vec.Vector.<feathers.controls.renderers.IGroupedListFooterRenderer>;
}

