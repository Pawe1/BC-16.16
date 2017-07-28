//class ListDataViewPort
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
    
    public class ListDataViewPort extends feathers.core.FeathersControl implements feathers.controls.supportClasses.IViewPort
    {
        public function ListDataViewPort()
        {
            this._viewPortBounds = new feathers.layout.ViewPortBounds();
            this._layoutResult = new feathers.layout.LayoutBoundsResult();
            this._unrenderedData = [];
            this._layoutItems = new Vector.<starling.display.DisplayObject>(0);
            this._defaultStorage = new ItemRendererFactoryStorage();
            this._rendererMap = new flash.utils.Dictionary(true);
            super();
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.removedFromStageHandler);
            this.addEventListener(starling.events.TouchEvent.TOUCH, this.touchHandler);
            return;
        }

        internal function invalidateParent(arg1:String="all"):void
        {
            feathers.controls.Scroller(this.parent).invalidate(arg1);
            return;
        }

        internal function validateItemRenderers():void
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

        internal function refreshLayoutTypicalItem():void
        {
            var loc5:*=null;
            var loc6:*=false;
            var loc7:*=false;
            var loc8:*=null;
            var loc1:*=this._layout as feathers.layout.IVirtualLayout;
            if (!loc1 || !loc1.useVirtualLayout) 
            {
                if (!this._typicalItemIsInDataProvider && this._typicalItemRenderer) 
                {
                    this.destroyRenderer(this._typicalItemRenderer);
                    this._typicalItemRenderer = null;
                }
                return;
            }
            var loc2:*=0;
            var loc3:*=false;
            var loc4:*=this._typicalItem;
            if (loc4 === null) 
            {
                loc3 = true;
                if (this._dataProvider && this._dataProvider.length > 0) 
                {
                    loc4 = this._dataProvider.getItemAt(0);
                }
            }
            else 
            {
                if (this._dataProvider) 
                {
                    loc2 = this._dataProvider.getItemIndex(loc4);
                    loc3 = loc2 >= 0;
                }
                if (loc2 < 0) 
                {
                    loc2 = 0;
                }
            }
            if (loc4 !== null) 
            {
                loc5 = feathers.controls.renderers.IListItemRenderer(this._rendererMap[loc4]);
                if (loc5) 
                {
                    loc5.index = loc2;
                }
                if (!loc5 && this._typicalItemRenderer) 
                {
                    loc6 = !this._typicalItemIsInDataProvider;
                    loc7 = this._typicalItemIsInDataProvider && this._dataProvider && this._dataProvider.getItemIndex(this._typicalItemRenderer.data) < 0;
                    if (!loc6 && loc7) 
                    {
                        loc6 = true;
                    }
                    if (loc6) 
                    {
                        loc8 = null;
                        if (this._factoryIDFunction !== null) 
                        {
                            loc8 = this.getFactoryID(loc4, loc2);
                        }
                        if (this._typicalItemRenderer.factoryID !== loc8) 
                        {
                            loc6 = false;
                        }
                    }
                    if (loc6) 
                    {
                        if (this._typicalItemIsInDataProvider) 
                        {
                            delete this._rendererMap[this._typicalItemRenderer.data];
                        }
                        loc5 = this._typicalItemRenderer;
                        loc5.data = loc4;
                        loc5.index = loc2;
                        if (loc3) 
                        {
                            this._rendererMap[loc4] = loc5;
                        }
                    }
                }
                if (!loc5) 
                {
                    loc5 = this.createRenderer(loc4, loc2, false, !loc3);
                    if (!this._typicalItemIsInDataProvider && this._typicalItemRenderer) 
                    {
                        this.destroyRenderer(this._typicalItemRenderer);
                        this._typicalItemRenderer = null;
                    }
                }
            }
            loc1.typicalItem = starling.display.DisplayObject(loc5);
            this._typicalItemRenderer = loc5;
            this._typicalItemIsInDataProvider = loc3;
            if (this._typicalItemRenderer && !this._typicalItemIsInDataProvider) 
            {
                this._typicalItemRenderer.addEventListener(feathers.events.FeathersEventType.RESIZE, this.renderer_resizeHandler);
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
                loc2 = loc1 as feathers.controls.renderers.IListItemRenderer;
                if (!loc2) 
                {
                    continue;
                }
                this.refreshOneItemRendererStyles(loc2);
            }
            return;
        }

        internal function refreshOneItemRendererStyles(arg1:feathers.controls.renderers.IListItemRenderer):void
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
                if (!(this.explicitVisibleWidth === this.explicitVisibleWidth) && (this.actualVisibleWidth < arg1 || this.actualVisibleWidth === loc2)) 
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
                loc2 = loc1 as feathers.controls.renderers.IListItemRenderer;
                if (!loc2) 
                {
                    continue;
                }
                loc2.isSelected = this._selectedIndices.getItemIndex(loc2.index) >= 0;
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
            if (!(this.explicitVisibleWidth === this.explicitVisibleWidth) && (this.actualVisibleWidth > arg1 || this.actualVisibleWidth === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
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

        internal function refreshViewPortBounds():void
        {
            var loc1:*=!(this._explicitMinVisibleWidth === this._explicitMinVisibleWidth);
            var loc2:*=!(this._explicitMinVisibleHeight === this._explicitMinVisibleHeight);
            this._viewPortBounds.x = 0;
            this._viewPortBounds.y = 0;
            this._viewPortBounds.scrollX = this._horizontalScrollPosition;
            this._viewPortBounds.scrollY = this._verticalScrollPosition;
            this._viewPortBounds.explicitWidth = this.explicitVisibleWidth;
            this._viewPortBounds.explicitHeight = this.explicitVisibleHeight;
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

        public function get visibleWidth():Number
        {
            return this.actualVisibleWidth;
        }

        public function set visibleWidth(arg1:Number):void
        {
            if (this.explicitVisibleWidth == arg1 || !(arg1 === arg1) && !(this.explicitVisibleWidth === this.explicitVisibleWidth)) 
            {
                return;
            }
            this.explicitVisibleWidth = arg1;
            if (this.actualVisibleWidth !== arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function refreshInactiveRenderers(arg1:String, arg2:Boolean):void
        {
            var loc2:*=null;
            if (arg1 === null) 
            {
                loc2 = this._defaultStorage;
            }
            else 
            {
                loc2 = ItemRendererFactoryStorage(this._storageMap[arg1]);
            }
            var loc1:*=loc2.inactiveItemRenderers;
            loc2.inactiveItemRenderers = loc2.activeItemRenderers;
            loc2.activeItemRenderers = loc1;
            if (loc2.activeItemRenderers.length > 0) 
            {
                throw new flash.errors.IllegalOperationError("ListDataViewPort: active renderers should be empty.");
            }
            if (arg2) 
            {
                this.recoverInactiveRenderers(loc2);
                this.freeInactiveRenderers(loc2, 0);
                if (this._typicalItemRenderer && this._typicalItemRenderer.factoryID === arg1) 
                {
                    if (this._typicalItemIsInDataProvider) 
                    {
                        delete this._rendererMap[this._typicalItemRenderer.data];
                    }
                    this.destroyRenderer(this._typicalItemRenderer);
                    this._typicalItemRenderer = null;
                    this._typicalItemIsInDataProvider = false;
                }
            }
            this._layoutItems.length = 0;
            return;
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
                if (!(this.explicitVisibleHeight === this.explicitVisibleHeight) && (this.actualVisibleHeight < arg1 || this.actualVisibleHeight === loc2)) 
                {
                    this.invalidate(INVALIDATION_FLAG_SIZE);
                }
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
            if (this._typicalItemRenderer) 
            {
                if (this._typicalItemIsInDataProvider) 
                {
                    loc1 = this.factoryIDToStorage(this._typicalItemRenderer.factoryID);
                    loc2 = loc1.inactiveItemRenderers;
                    loc3 = loc1.activeItemRenderers;
                    loc4 = loc2.indexOf(this._typicalItemRenderer);
                    if (loc4 >= 0) 
                    {
                        loc2[loc4] = null;
                    }
                    loc5 = loc3.length;
                    if (loc5 === 0) 
                    {
                        loc3[loc5] = this._typicalItemRenderer;
                    }
                }
                this.refreshOneItemRendererStyles(this._typicalItemRenderer);
            }
            this.findUnrenderedData();
            this.recoverInactiveRenderers(this._defaultStorage);
            if (this._storageMap) 
            {
                var loc7:*=0;
                var loc8:*=this._storageMap;
                for (loc6 in loc8) 
                {
                    loc1 = ItemRendererFactoryStorage(this._storageMap[loc6]);
                    this.recoverInactiveRenderers(loc1);
                }
            }
            this.renderUnrenderedData();
            this.freeInactiveRenderers(this._defaultStorage, this._minimumItemCount);
            if (this._storageMap) 
            {
                loc7 = 0;
                loc8 = this._storageMap;
                for (loc6 in loc8) 
                {
                    loc1 = ItemRendererFactoryStorage(this._storageMap[loc6]);
                    this.freeInactiveRenderers(loc1, 1);
                }
            }
            this._updateForDataReset = false;
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
            if (!(this.explicitVisibleHeight === this.explicitVisibleHeight) && (this.actualVisibleHeight > arg1 || this.actualVisibleHeight === loc1)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function findUnrenderedData():void
        {
            var loc7:*=null;
            var loc8:*=0;
            var loc9:*=0;
            var loc10:*=0;
            var loc11:*=0;
            var loc12:*=0;
            var loc13:*=null;
            var loc14:*=0;
            var loc15:*=null;
            var loc16:*=null;
            var loc17:*=null;
            var loc18:*=null;
            var loc19:*=null;
            var loc20:*=0;
            var loc1:*=this._dataProvider ? this._dataProvider.length : 0;
            var loc2:*=this._layout as feathers.layout.IVirtualLayout;
            var loc3:*=loc2 && loc2.useVirtualLayout;
            if (loc3) 
            {
                loc7 = starling.utils.Pool.getPoint();
                loc2.measureViewPort(loc1, this._viewPortBounds, loc7);
                loc2.getVisibleIndicesAtScrollPosition(this._horizontalScrollPosition, this._verticalScrollPosition, loc7.x, loc7.y, loc1, HELPER_VECTOR);
                starling.utils.Pool.putPoint(loc7);
            }
            var loc4:*=loc3 ? HELPER_VECTOR.length : loc1;
            if (loc3 && this._typicalItemIsInDataProvider && this._typicalItemRenderer && HELPER_VECTOR.indexOf(this._typicalItemRenderer.index) >= 0) 
            {
                this._minimumItemCount = loc4 + 1;
            }
            else 
            {
                this._minimumItemCount = loc4;
            }
            var loc5:*=this._layout is feathers.layout.ITrimmedVirtualLayout && loc3 && (!(this._layout is feathers.layout.IVariableVirtualLayout) || !feathers.layout.IVariableVirtualLayout(this._layout).hasVariableItemDimensions) && loc4 > 0;
            if (loc5) 
            {
                loc8 = HELPER_VECTOR[0];
                loc9 = loc8;
                loc10 = 1;
                while (loc10 < loc4) 
                {
                    loc14 = HELPER_VECTOR[loc10];
                    if (loc14 < loc8) 
                    {
                        loc8 = loc14;
                    }
                    if (loc14 > loc9) 
                    {
                        loc9 = loc14;
                    }
                    ++loc10;
                }
                --loc11;
                if (loc11 < 0) 
                {
                    loc11 = 0;
                }
                loc12 = (loc1 - 1) - loc9;
                loc13 = feathers.layout.ITrimmedVirtualLayout(this._layout);
                loc13.beforeVirtualizedItemCount = loc11;
                loc13.afterVirtualizedItemCount = loc12;
                this._layoutItems.length = loc1 - loc11 - loc12;
                this._layoutIndexOffset = -loc11;
            }
            else 
            {
                this._layoutIndexOffset = 0;
                this._layoutItems.length = loc1;
            }
            var loc6:*=this._unrenderedData.length;
            loc10 = 0;
            while (loc10 < loc4) 
            {
                loc14 = loc3 ? HELPER_VECTOR[loc10] : loc10;
                if (!(loc14 < 0 || loc14 >= loc1)) 
                {
                    loc15 = this._dataProvider.getItemAt(loc14);
                    loc16 = feathers.controls.renderers.IListItemRenderer(this._rendererMap[loc15]);
                    if (loc16) 
                    {
                        loc16.index = loc14;
                        loc16.visible = true;
                        if (this._updateForDataReset) 
                        {
                            loc16.data = null;
                            loc16.data = loc15;
                        }
                        if (this._typicalItemRenderer != loc16) 
                        {
                            loc17 = this.factoryIDToStorage(loc16.factoryID);
                            loc18 = loc17.activeItemRenderers;
                            loc19 = loc17.inactiveItemRenderers;
                            loc18[loc18.length] = loc16;
                            loc20 = loc19.indexOf(loc16);
                            if (loc20 >= 0) 
                            {
                                loc19[loc20] = null;
                            }
                            else 
                            {
                                throw new flash.errors.IllegalOperationError("ListDataViewPort: renderer map contains bad data. This may be caused by duplicate items in the data provider, which is not allowed.");
                            }
                        }
                        this._layoutItems[loc14 + this._layoutIndexOffset] = starling.display.DisplayObject(loc16);
                    }
                    else 
                    {
                        this._unrenderedData[loc6] = loc15;
                        ++loc6;
                    }
                }
                ++loc10;
            }
            if (this._typicalItemRenderer) 
            {
                if (loc3 && this._typicalItemIsInDataProvider) 
                {
                    loc14 = HELPER_VECTOR.indexOf(this._typicalItemRenderer.index);
                    if (loc14 >= 0) 
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

        internal function renderUnrenderedData():void
        {
            var loc3:*=null;
            var loc4:*=0;
            var loc5:*=null;
            var loc1:*=this._unrenderedData.length;
            var loc2:*=0;
            while (loc2 < loc1) 
            {
                loc3 = this._unrenderedData.shift();
                loc4 = this._dataProvider.getItemIndex(loc3);
                loc5 = this.createRenderer(loc3, loc4, true, false);
                loc5.visible = true;
                this._layoutItems[loc4 + this._layoutIndexOffset] = starling.display.DisplayObject(loc5);
                ++loc2;
            }
            return;
        }

        public function get visibleHeight():Number
        {
            return this.actualVisibleHeight;
        }

        public function set visibleHeight(arg1:Number):void
        {
            if (this.explicitVisibleHeight == arg1 || !(arg1 === arg1) && !(this.explicitVisibleHeight === this.explicitVisibleHeight)) 
            {
                return;
            }
            this.explicitVisibleHeight = arg1;
            if (this.actualVisibleHeight !== arg1) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function recoverInactiveRenderers(arg1:ItemRendererFactoryStorage):void
        {
            var loc4:*=null;
            var loc1:*=arg1.inactiveItemRenderers;
            var loc2:*=loc1.length;
            var loc3:*=0;
            while (loc3 < loc2) 
            {
                loc4 = loc1[loc3];
                if (!(!loc4 || loc4.index < 0)) 
                {
                    this._owner.dispatchEventWith(feathers.events.FeathersEventType.RENDERER_REMOVE, false, loc4);
                    delete this._rendererMap[loc4.data];
                }
                ++loc3;
            }
            return;
        }

        public function get contentX():Number
        {
            return this._contentX;
        }

        internal function freeInactiveRenderers(arg1:ItemRendererFactoryStorage, arg2:int):void
        {
            var loc7:*=null;
            var loc1:*=arg1.inactiveItemRenderers;
            var loc2:*=arg1.activeItemRenderers;
            var loc3:*=loc2.length;
            var loc4:*=loc1.length;
            var loc5:*=arg2 - loc3;
            if (loc5 > loc4) 
            {
                loc5 = loc4;
            }
            var loc6:*=0;
            while (loc6 < loc5) 
            {
                loc7 = loc1.shift();
                if (loc7) 
                {
                    loc7.data = null;
                    loc7.index = -1;
                    loc7.visible = false;
                    loc2[loc3] = loc7;
                    ++loc3;
                }
                else 
                {
                    ++loc5;
                    if (loc4 < loc5) 
                    {
                        loc5 = loc4;
                    }
                }
                ++loc6;
            }
            loc4 = loc4 - loc5;
            loc6 = 0;
            while (loc6 < loc4) 
            {
                loc7 = loc1.shift();
                if (loc7) 
                {
                    this.destroyRenderer(loc7);
                }
                ++loc6;
            }
            return;
        }

        public function get contentY():Number
        {
            return this._contentY;
        }

        internal function createRenderer(arg1:Object, arg2:int, arg3:Boolean, arg4:Boolean):feathers.controls.renderers.IListItemRenderer
        {
            var loc6:*=null;
            var loc1:*=null;
            if (this._factoryIDFunction !== null) 
            {
                loc1 = this.getFactoryID(arg1, arg2);
            }
            var loc2:*=this.factoryIDToFactory(loc1);
            var loc3:*=this.factoryIDToStorage(loc1);
            var loc4:*=loc3.inactiveItemRenderers;
            var loc5:*=loc3.activeItemRenderers;
            do 
            {
                if (!arg3 || arg4 || loc4.length === 0) 
                {
                    if (loc2 === null) 
                    {
                        loc6 = feathers.controls.renderers.IListItemRenderer(new this._itemRendererType());
                    }
                    else 
                    {
                        loc6 = feathers.controls.renderers.IListItemRenderer(loc2());
                    }
                    if (this._customItemRendererStyleName && this._customItemRendererStyleName.length > 0) 
                    {
                        loc6.styleNameList.add(this._customItemRendererStyleName);
                    }
                    this.addChild(starling.display.DisplayObject(loc6));
                }
                else 
                {
                    loc6 = loc4.shift();
                }
            }
            while (!loc6);
            loc6.data = arg1;
            loc6.index = arg2;
            loc6.owner = this._owner;
            loc6.factoryID = loc1;
            if (!arg4) 
            {
                this._rendererMap[arg1] = loc6;
                loc5[loc5.length] = loc6;
                loc6.addEventListener(starling.events.Event.TRIGGERED, this.renderer_triggeredHandler);
                loc6.addEventListener(starling.events.Event.CHANGE, this.renderer_changeHandler);
                loc6.addEventListener(feathers.events.FeathersEventType.RESIZE, this.renderer_resizeHandler);
                this._owner.dispatchEventWith(feathers.events.FeathersEventType.RENDERER_ADD, false, loc6);
            }
            return loc6;
        }

        internal function destroyRenderer(arg1:feathers.controls.renderers.IListItemRenderer):void
        {
            arg1.removeEventListener(starling.events.Event.TRIGGERED, this.renderer_triggeredHandler);
            arg1.removeEventListener(starling.events.Event.CHANGE, this.renderer_changeHandler);
            arg1.removeEventListener(feathers.events.FeathersEventType.RESIZE, this.renderer_resizeHandler);
            arg1.owner = null;
            arg1.data = null;
            arg1.factoryID = null;
            this.removeChild(starling.display.DisplayObject(arg1), true);
            return;
        }

        internal function getFactoryID(arg1:Object, arg2:int):String
        {
            if (this._factoryIDFunction === null) 
            {
                return null;
            }
            if (this._factoryIDFunction.length === 1) 
            {
                return this._factoryIDFunction(arg1);
            }
            return this._factoryIDFunction(arg1, arg2);
        }

        internal function factoryIDToFactory(arg1:String):Function
        {
            if (arg1 !== null) 
            {
                if (arg1 in this._itemRendererFactories) 
                {
                    return this._itemRendererFactories[arg1] as Function;
                }
                throw new ReferenceError("Cannot find item renderer factory for ID \"" + arg1 + "\".");
            }
            return this._itemRendererFactory;
        }

        internal function factoryIDToStorage(arg1:String):ItemRendererFactoryStorage
        {
            var loc1:*=null;
            if (arg1 !== null) 
            {
                if (arg1 in this._storageMap) 
                {
                    return ItemRendererFactoryStorage(this._storageMap[arg1]);
                }
                loc1 = new ItemRendererFactoryStorage();
                this._storageMap[arg1] = loc1;
                return loc1;
            }
            return this._defaultStorage;
        }

        internal function childProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:String):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        internal function dataProvider_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        internal function dataProvider_addItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            loc1.addToVariableVirtualCacheAtIndex(arg2);
            return;
        }

        internal function dataProvider_removeItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            loc1.removeFromVariableVirtualCacheAtIndex(arg2);
            return;
        }

        internal function dataProvider_replaceItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            loc1.resetVariableVirtualCacheAtIndex(arg2);
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

        public function get owner():feathers.controls.List
        {
            return this._owner;
        }

        public function set owner(arg1:feathers.controls.List):void
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

        internal function dataProvider_updateItemHandler(arg1:starling.events.Event, arg2:int):void
        {
            var loc1:*=this._dataProvider.getItemAt(arg2);
            var loc2:*=feathers.controls.renderers.IListItemRenderer(this._rendererMap[loc1]);
            if (loc2 === null) 
            {
                return;
            }
            loc2.data = null;
            loc2.data = loc1;
            if (!(this.explicitVisibleWidth === this.explicitVisibleWidth) || !(this.explicitVisibleHeight === this.explicitVisibleHeight)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
                this.invalidateParent(INVALIDATION_FLAG_SIZE);
            }
            return;
        }

        internal function dataProvider_updateAllHandler(arg1:starling.events.Event):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._rendererMap;
            for (loc1 in loc4) 
            {
                loc2 = feathers.controls.renderers.IListItemRenderer(this._rendererMap[loc1]);
                if (loc2 === null) 
                {
                    continue;
                }
                loc2.data = null;
                loc2.data = loc1;
            }
            if (!(this.explicitVisibleWidth === this.explicitVisibleWidth) || !(this.explicitVisibleHeight === this.explicitVisibleHeight)) 
            {
                this.invalidate(INVALIDATION_FLAG_SIZE);
                this.invalidateParent(INVALIDATION_FLAG_SIZE);
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

        internal function renderer_resizeHandler(arg1:starling.events.Event):void
        {
            if (this._ignoreRendererResizing) 
            {
                return;
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            this.invalidateParent(INVALIDATION_FLAG_LAYOUT);
            if (arg1.currentTarget === this._typicalItemRenderer && !this._typicalItemIsInDataProvider) 
            {
                return;
            }
            var loc1:*=this._layout as feathers.layout.IVariableVirtualLayout;
            if (!loc1 || !loc1.hasVariableItemDimensions) 
            {
                return;
            }
            var loc2:*=feathers.controls.renderers.IListItemRenderer(arg1.currentTarget);
            loc1.resetVariableVirtualCacheAtIndex(loc2.index, starling.display.DisplayObject(loc2));
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

        internal function renderer_triggeredHandler(arg1:starling.events.Event):void
        {
            var loc1:*=feathers.controls.renderers.IListItemRenderer(arg1.currentTarget);
            this.parent.dispatchEventWith(starling.events.Event.TRIGGERED, false, loc1.data);
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
            if (arg1 !== null) 
            {
                this._storageMap = {};
            }
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function renderer_changeHandler(arg1:starling.events.Event):void
        {
            var loc4:*=0;
            if (this._ignoreSelectionChanges) 
            {
                return;
            }
            var loc1:*=feathers.controls.renderers.IListItemRenderer(arg1.currentTarget);
            if (!this._isSelectable || this._isScrolling) 
            {
                loc1.isSelected = false;
                return;
            }
            var loc2:*=loc1.isSelected;
            var loc3:*=loc1.index;
            if (this._allowMultipleSelection) 
            {
                loc4 = this._selectedIndices.getItemIndex(loc3);
                if (loc2 && loc4 < 0) 
                {
                    this._selectedIndices.addItem(loc3);
                }
                else if (!loc2 && loc4 >= 0) 
                {
                    this._selectedIndices.removeItemAt(loc4);
                }
            }
            else if (loc2) 
            {
                new Vector.<int>(1)[0] = loc3;
                this._selectedIndices.data = new Vector.<int>(1);
            }
            else 
            {
                this._selectedIndices.removeAll();
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
            this.invalidate(INVALIDATION_FLAG_ITEM_RENDERER_FACTORY);
            return;
        }

        internal function selectedIndices_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_SELECTED);
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

        internal function removedFromStageHandler(arg1:starling.events.Event):void
        {
            this.touchPointID = -1;
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

        public function get itemRendererProperties():feathers.core.PropertyProxy
        {
            return this._itemRendererProperties;
        }

        internal function owner_scrollStartHandler(arg1:starling.events.Event):void
        {
            this._isScrolling = true;
            return;
        }

        public function get layout():feathers.layout.ILayout
        {
            return this._layout;
        }

        public function set layout(arg1:feathers.layout.ILayout):void
        {
            if (this._layout == arg1) 
            {
                return;
            }
            if (this._layout) 
            {
                starling.events.EventDispatcher(this._layout).removeEventListener(starling.events.Event.CHANGE, this.layout_changeHandler);
            }
            this._layout = arg1;
            if (this._layout) 
            {
                if (this._layout is feathers.layout.IVariableVirtualLayout) 
                {
                    feathers.layout.IVariableVirtualLayout(this._layout).resetVariableVirtualCache();
                }
                starling.events.EventDispatcher(this._layout).addEventListener(starling.events.Event.CHANGE, this.layout_changeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
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
            if (!arg1) 
            {
                this.selectedIndices = null;
            }
            return;
        }

        public function get allowMultipleSelection():Boolean
        {
            return this._allowMultipleSelection;
        }

        public function set allowMultipleSelection(arg1:Boolean):void
        {
            this._allowMultipleSelection = arg1;
            return;
        }

        public function get selectedIndices():feathers.data.ListCollection
        {
            return this._selectedIndices;
        }

        public function set selectedIndices(arg1:feathers.data.ListCollection):void
        {
            if (this._selectedIndices == arg1) 
            {
                return;
            }
            if (this._selectedIndices) 
            {
                this._selectedIndices.removeEventListener(starling.events.Event.CHANGE, this.selectedIndices_changeHandler);
            }
            this._selectedIndices = arg1;
            if (this._selectedIndices) 
            {
                this._selectedIndices.addEventListener(starling.events.Event.CHANGE, this.selectedIndices_changeHandler);
            }
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        public function get requiresMeasurementOnScroll():Boolean
        {
            return this._layout.requiresLayoutOnScroll && (!(this.explicitVisibleWidth === this.explicitVisibleWidth) || !(this.explicitVisibleHeight === this.explicitVisibleHeight));
        }

        public function getScrollPositionForIndex(arg1:int, arg2:flash.geom.Point=null):flash.geom.Point
        {
            if (!arg2) 
            {
                arg2 = new flash.geom.Point();
            }
            return this._layout.getScrollPositionForIndex(arg1, this._layoutItems, 0, 0, this.actualVisibleWidth, this.actualVisibleHeight, arg2);
        }

        public function getNearestScrollPositionForIndex(arg1:int, arg2:flash.geom.Point=null):flash.geom.Point
        {
            if (!arg2) 
            {
                arg2 = new flash.geom.Point();
            }
            return this._layout.getNearestScrollPositionForIndex(arg1, this._horizontalScrollPosition, this._verticalScrollPosition, this._layoutItems, 0, 0, this.actualVisibleWidth, this.actualVisibleHeight, arg2);
        }

        public function itemToItemRenderer(arg1:Object):feathers.controls.renderers.IListItemRenderer
        {
            return feathers.controls.renderers.IListItemRenderer(this._rendererMap[arg1]);
        }

        public override function dispose():void
        {
            var loc1:*=null;
            this.refreshInactiveRenderers(null, true);
            if (this._storageMap) 
            {
                var loc2:*=0;
                var loc3:*=this._storageMap;
                for (loc1 in loc3) 
                {
                    this.refreshInactiveRenderers(loc1, true);
                }
            }
            this.owner = null;
            this.layout = null;
            this.dataProvider = null;
            super.dispose();
            return;
        }

        protected override function draw():void
        {
            var loc12:*=null;
            var loc13:*=false;
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
                this.refreshInactiveRenderers(null, loc5);
                if (this._storageMap) 
                {
                    var loc14:*=0;
                    var loc15:*=this._storageMap;
                    for (loc12 in loc15) 
                    {
                        this.refreshInactiveRenderers(loc12, loc5);
                    }
                }
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
                this.refreshItemRendererStyles();
            }
            if (loc4 || loc9) 
            {
                loc13 = this._ignoreSelectionChanges;
                this._ignoreSelectionChanges = true;
                this.refreshSelection();
                this._ignoreSelectionChanges = loc13;
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
            this.actualVisibleWidth = this._layoutResult.viewPortWidth;
            this.actualVisibleHeight = this._layoutResult.viewPortHeight;
            this._actualMinVisibleWidth = this._layoutResult.viewPortWidth;
            this._actualMinVisibleHeight = this._layoutResult.viewPortHeight;
            this.validateItemRenderers();
            return;
        }

        internal static const HELPER_VECTOR:__AS3__.vec.Vector.<int>=new Vector.<int>(0);

        internal static const INVALIDATION_FLAG_ITEM_RENDERER_FACTORY:String="itemRendererFactory";

        internal var _layoutResult:feathers.layout.LayoutBoundsResult;

        internal var _actualMinVisibleWidth:Number=0;

        internal var _explicitMinVisibleWidth:Number;

        internal var _maxVisibleWidth:Number=Infinity;

        internal var actualVisibleWidth:Number=0;

        internal var explicitVisibleWidth:Number=NaN;

        internal var _actualMinVisibleHeight:Number=0;

        internal var _maxVisibleHeight:Number=Infinity;

        internal var actualVisibleHeight:Number=0;

        internal var explicitVisibleHeight:Number=NaN;

        protected var _contentX:Number=0;

        protected var _contentY:Number=0;

        internal var _typicalItemIsInDataProvider:Boolean=false;

        internal var _typicalItemRenderer:feathers.controls.renderers.IListItemRenderer;

        internal var _unrenderedData:Array;

        internal var _layoutItems:__AS3__.vec.Vector.<starling.display.DisplayObject>;

        internal var _defaultStorage:ItemRendererFactoryStorage;

        internal var _storageMap:Object;

        internal var _rendererMap:flash.utils.Dictionary;

        internal var _minimumItemCount:int;

        internal var _layoutIndexOffset:int=0;

        internal var _isScrolling:Boolean=false;

        internal var _owner:feathers.controls.List;

        internal var _updateForDataReset:Boolean=false;

        internal var _dataProvider:feathers.data.ListCollection;

        internal var _itemRendererType:Class;

        internal var _itemRendererFactory:Function;

        internal var _itemRendererFactories:Object;

        internal var _factoryIDFunction:Function;

        internal var _customItemRendererStyleName:String;

        internal var _typicalItem:Object=null;

        internal var _itemRendererProperties:feathers.core.PropertyProxy;

        internal var _allowMultipleSelection:Boolean=false;

        internal var touchPointID:int=-1;

        internal var _ignoreLayoutChanges:Boolean=false;

        internal var _selectedIndices:feathers.data.ListCollection;

        internal var _horizontalScrollPosition:Number=0;

        internal var _explicitMinVisibleHeight:Number;

        internal var _verticalScrollPosition:Number=0;

        internal var _isSelectable:Boolean=true;

        internal var _ignoreRendererResizing:Boolean=false;

        internal var _layout:feathers.layout.ILayout;

        internal var _viewPortBounds:feathers.layout.ViewPortBounds;

        internal var _ignoreSelectionChanges:Boolean=false;
    }
}

import __AS3__.vec.*;
import feathers.controls.renderers.*;


class ItemRendererFactoryStorage extends Object
{
    public function ItemRendererFactoryStorage()
    {
        this.activeItemRenderers = new Vector.<feathers.controls.renderers.IListItemRenderer>(0);
        this.inactiveItemRenderers = new Vector.<feathers.controls.renderers.IListItemRenderer>(0);
        super();
        return;
    }

    public var activeItemRenderers:__AS3__.vec.Vector.<feathers.controls.renderers.IListItemRenderer>;

    public var inactiveItemRenderers:__AS3__.vec.Vector.<feathers.controls.renderers.IListItemRenderer>;
}

