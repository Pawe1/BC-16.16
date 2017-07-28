//class Slider
package feathers.controls 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.utils.math.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.ui.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.events.*;
    
    public class Slider extends feathers.core.FeathersControl implements feathers.controls.IDirectionalScrollBar, feathers.core.IFocusDisplayObject
    {
        public function Slider()
        {
            super();
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.slider_removedFromStageHandler);
            return;
        }

        public function set thumbFactory(arg1:Function):void
        {
            if (this._thumbFactory == arg1) 
            {
                return;
            }
            this._thumbFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_THUMB_FACTORY);
            return;
        }

        public function get customThumbStyleName():String
        {
            return this._customThumbStyleName;
        }

        public function set customThumbStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customThumbStyleName === arg1) 
            {
                return;
            }
            this._customThumbStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_THUMB_FACTORY);
            return;
        }

        public function get thumbProperties():Object
        {
            if (!this._thumbProperties) 
            {
                this._thumbProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._thumbProperties;
        }

        public function set thumbProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._thumbProperties == arg1) 
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
            if (this._thumbProperties) 
            {
                this._thumbProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._thumbProperties = feathers.core.PropertyProxy(arg1);
            if (this._thumbProperties) 
            {
                this._thumbProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function initialize():void
        {
            if (this._value < this._minimum) 
            {
                this.value = this._minimum;
            }
            else if (this._value > this._maximum) 
            {
                this.value = this._maximum;
            }
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_FOCUS);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_LAYOUT);
            var loc6:*=this.isInvalid(INVALIDATION_FLAG_THUMB_FACTORY);
            var loc7:*=this.isInvalid(INVALIDATION_FLAG_MINIMUM_TRACK_FACTORY);
            var loc8:*=this.isInvalid(INVALIDATION_FLAG_MAXIMUM_TRACK_FACTORY);
            if (loc6) 
            {
                this.createThumb();
            }
            if (loc7) 
            {
                this.createMinimumTrack();
            }
            if (loc8 || loc5) 
            {
                this.createMaximumTrack();
            }
            if (loc6 || loc1) 
            {
                this.refreshThumbStyles();
            }
            if (loc7 || loc1) 
            {
                this.refreshMinimumTrackStyles();
            }
            if ((loc8 || loc5 || loc1) && this.maximumTrack) 
            {
                this.refreshMaximumTrackStyles();
            }
            if (loc3 || loc6 || loc7 || loc8) 
            {
                this.refreshEnabled();
            }
            loc2 = this.autoSizeIfNeeded() || loc2;
            this.layoutChildren();
            if (loc2 || loc4) 
            {
                this.refreshFocusIndicator();
            }
            return;
        }

        protected function autoSizeIfNeeded():Boolean
        {
            if (this._direction === feathers.layout.Direction.VERTICAL) 
            {
                return this.measureVertical();
            }
            return this.measureHorizontal();
        }

        protected function measureVertical():Boolean
        {
            var loc10:*=null;
            var loc11:*=NaN;
            var loc12:*=null;
            var loc13:*=null;
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            var loc5:*=this._trackLayoutMode === feathers.controls.TrackLayoutMode.SINGLE;
            if (loc2) 
            {
                this.minimumTrack.height = this._minimumTrackSkinExplicitHeight;
            }
            else if (loc5) 
            {
                this.minimumTrack.height = this._explicitHeight;
            }
            if (this.minimumTrack is feathers.core.IMeasureDisplayObject) 
            {
                loc10 = feathers.core.IMeasureDisplayObject(this.minimumTrack);
                if (loc4) 
                {
                    loc10.minHeight = this._minimumTrackSkinExplicitMinHeight;
                }
                else if (loc5) 
                {
                    loc11 = this._explicitMinHeight;
                    if (this._minimumTrackSkinExplicitMinHeight > loc11) 
                    {
                        loc11 = this._minimumTrackSkinExplicitMinHeight;
                    }
                    loc10.minHeight = loc11;
                }
            }
            if (!loc5) 
            {
                if (loc2) 
                {
                    this.maximumTrack.height = this._maximumTrackSkinExplicitHeight;
                }
                if (this.maximumTrack is feathers.core.IMeasureDisplayObject) 
                {
                    loc12 = feathers.core.IMeasureDisplayObject(this.maximumTrack);
                    if (loc4) 
                    {
                        loc12.minHeight = this._maximumTrackSkinExplicitMinHeight;
                    }
                }
            }
            if (this.minimumTrack is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.minimumTrack).validate();
            }
            if (this.maximumTrack is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.maximumTrack).validate();
            }
            if (this.thumb is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.thumb).validate();
            }
            var loc6:*=this._explicitWidth;
            var loc7:*=this._explicitHeight;
            var loc8:*=this._explicitMinWidth;
            var loc9:*=this._explicitMinHeight;
            if (loc1) 
            {
                loc6 = this.minimumTrack.width;
                if (!loc5 && this.maximumTrack.width > loc6) 
                {
                    loc6 = this.maximumTrack.width;
                }
                if (this.thumb.width > loc6) 
                {
                    loc6 = this.thumb.width;
                }
            }
            if (loc2) 
            {
                loc7 = this.minimumTrack.height;
                if (!loc5) 
                {
                    if (this.maximumTrack.height > loc7) 
                    {
                        loc7 = this.maximumTrack.height;
                    }
                    loc7 = loc7 + this.thumb.height / 2;
                }
            }
            if (loc3) 
            {
                if (loc10 === null) 
                {
                    loc8 = this.minimumTrack.width;
                }
                else 
                {
                    loc8 = loc10.minWidth;
                }
                if (!loc5) 
                {
                    if (loc12 === null) 
                    {
                        if (this.maximumTrack.width > loc8) 
                        {
                            loc8 = this.maximumTrack.width;
                        }
                    }
                    else if (loc12.minWidth > loc8) 
                    {
                        loc8 = loc12.minWidth;
                    }
                }
                if (this.thumb is feathers.core.IMeasureDisplayObject) 
                {
                    loc13 = feathers.core.IMeasureDisplayObject(this.thumb);
                    if (loc13.minWidth > loc8) 
                    {
                        loc8 = loc13.minWidth;
                    }
                }
                else if (this.thumb.width > loc8) 
                {
                    loc8 = this.thumb.width;
                }
            }
            if (loc4) 
            {
                if (loc10 === null) 
                {
                    loc9 = this.minimumTrack.height;
                }
                else 
                {
                    loc9 = loc10.minHeight;
                }
                if (!loc5) 
                {
                    if (loc12 === null) 
                    {
                        loc9 = this.maximumTrack.height;
                    }
                    else if (loc12.minHeight > loc9) 
                    {
                        loc9 = loc12.minHeight;
                    }
                    if (this.thumb is feathers.core.IMeasureDisplayObject) 
                    {
                        loc9 = loc9 + feathers.core.IMeasureDisplayObject(this.thumb).minHeight / 2;
                    }
                    else 
                    {
                        loc9 = loc9 + this.thumb.height / 2;
                    }
                }
            }
            return this.saveMeasurements(loc6, loc7, loc8, loc9);
        }

        protected function measureHorizontal():Boolean
        {
            var loc10:*=null;
            var loc11:*=NaN;
            var loc12:*=null;
            var loc13:*=null;
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            var loc5:*=this._trackLayoutMode === feathers.controls.TrackLayoutMode.SINGLE;
            if (loc1) 
            {
                this.minimumTrack.width = this._minimumTrackSkinExplicitWidth;
            }
            else if (loc5) 
            {
                this.minimumTrack.width = this._explicitWidth;
            }
            if (this.minimumTrack is feathers.core.IMeasureDisplayObject) 
            {
                loc10 = feathers.core.IMeasureDisplayObject(this.minimumTrack);
                if (loc3) 
                {
                    loc10.minWidth = this._minimumTrackSkinExplicitMinWidth;
                }
                else if (loc5) 
                {
                    loc11 = this._explicitMinWidth;
                    if (this._minimumTrackSkinExplicitMinWidth > loc11) 
                    {
                        loc11 = this._minimumTrackSkinExplicitMinWidth;
                    }
                    loc10.minWidth = loc11;
                }
            }
            if (!loc5) 
            {
                if (loc1) 
                {
                    this.maximumTrack.width = this._maximumTrackSkinExplicitWidth;
                }
                if (this.maximumTrack is feathers.core.IMeasureDisplayObject) 
                {
                    loc12 = feathers.core.IMeasureDisplayObject(this.maximumTrack);
                    if (loc3) 
                    {
                        loc12.minWidth = this._maximumTrackSkinExplicitMinWidth;
                    }
                }
            }
            if (this.minimumTrack is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.minimumTrack).validate();
            }
            if (this.maximumTrack is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.maximumTrack).validate();
            }
            if (this.thumb is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.thumb).validate();
            }
            var loc6:*=this._explicitWidth;
            var loc7:*=this._explicitHeight;
            var loc8:*=this._explicitMinWidth;
            var loc9:*=this._explicitMinHeight;
            if (loc1) 
            {
                loc6 = this.minimumTrack.width;
                if (!loc5) 
                {
                    if (this.maximumTrack.width > loc6) 
                    {
                        loc6 = this.maximumTrack.width;
                    }
                    loc6 = loc6 + this.thumb.width / 2;
                }
            }
            if (loc2) 
            {
                loc7 = this.minimumTrack.height;
                if (!loc5 && this.maximumTrack.height > loc7) 
                {
                    loc7 = this.maximumTrack.height;
                }
                if (this.thumb.height > loc7) 
                {
                    loc7 = this.thumb.height;
                }
            }
            if (loc3) 
            {
                if (loc10 === null) 
                {
                    loc8 = this.minimumTrack.width;
                }
                else 
                {
                    loc8 = loc10.minWidth;
                }
                if (!loc5) 
                {
                    if (loc12 === null) 
                    {
                        if (this.maximumTrack.width > loc8) 
                        {
                            loc8 = this.maximumTrack.width;
                        }
                    }
                    else if (loc12.minWidth > loc8) 
                    {
                        loc8 = loc12.minWidth;
                    }
                    if (this.thumb is feathers.core.IMeasureDisplayObject) 
                    {
                        loc8 = loc8 + feathers.core.IMeasureDisplayObject(this.thumb).minWidth / 2;
                    }
                    else 
                    {
                        loc8 = loc8 + this.thumb.width / 2;
                    }
                }
            }
            if (loc4) 
            {
                if (loc10 === null) 
                {
                    loc9 = this.minimumTrack.height;
                }
                else 
                {
                    loc9 = loc10.minHeight;
                }
                if (!loc5) 
                {
                    if (loc12 === null) 
                    {
                        if (this.maximumTrack.height > loc9) 
                        {
                            loc9 = this.maximumTrack.height;
                        }
                    }
                    else if (loc12.minHeight > loc9) 
                    {
                        loc9 = loc12.minHeight;
                    }
                }
                if (this.thumb is feathers.core.IMeasureDisplayObject) 
                {
                    loc13 = feathers.core.IMeasureDisplayObject(this.thumb);
                    if (loc13.minHeight > loc9) 
                    {
                        loc9 = loc13.minHeight;
                    }
                }
                else if (this.thumb.height > loc9) 
                {
                    loc9 = this.thumb.height;
                }
            }
            return this.saveMeasurements(loc6, loc7, loc8, loc9);
        }

        protected function createThumb():void
        {
            if (this.thumb) 
            {
                this.thumb.removeFromParent(true);
                this.thumb = null;
            }
            var loc1:*=this._thumbFactory == null ? defaultThumbFactory : this._thumbFactory;
            var loc2:*=this._customThumbStyleName == null ? this.thumbStyleName : this._customThumbStyleName;
            var loc3:*=feathers.controls.BasicButton(loc1());
            loc3.styleNameList.add(loc2);
            loc3.keepDownStateOnRollOut = true;
            loc3.addEventListener(starling.events.TouchEvent.TOUCH, this.thumb_touchHandler);
            this.addChild(loc3);
            this.thumb = loc3;
            return;
        }

        protected function createMinimumTrack():void
        {
            var loc4:*=null;
            if (this.minimumTrack) 
            {
                this.minimumTrack.removeFromParent(true);
                this.minimumTrack = null;
            }
            var loc1:*=this._minimumTrackFactory == null ? defaultMinimumTrackFactory : this._minimumTrackFactory;
            var loc2:*=this._customMinimumTrackStyleName == null ? this.minimumTrackStyleName : this._customMinimumTrackStyleName;
            var loc3:*=feathers.controls.BasicButton(loc1());
            loc3.styleNameList.add(loc2);
            loc3.keepDownStateOnRollOut = true;
            loc3.addEventListener(starling.events.TouchEvent.TOUCH, this.track_touchHandler);
            this.addChildAt(loc3, 0);
            this.minimumTrack = loc3;
            if (this.minimumTrack is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this.minimumTrack).initializeNow();
            }
            if (this.minimumTrack is feathers.core.IMeasureDisplayObject) 
            {
                loc4 = feathers.core.IMeasureDisplayObject(this.minimumTrack);
                this._minimumTrackSkinExplicitWidth = loc4.explicitWidth;
                this._minimumTrackSkinExplicitHeight = loc4.explicitHeight;
                this._minimumTrackSkinExplicitMinWidth = loc4.explicitMinWidth;
                this._minimumTrackSkinExplicitMinHeight = loc4.explicitMinHeight;
            }
            else 
            {
                this._minimumTrackSkinExplicitWidth = this.minimumTrack.width;
                this._minimumTrackSkinExplicitHeight = this.minimumTrack.height;
                this._minimumTrackSkinExplicitMinWidth = this._minimumTrackSkinExplicitWidth;
                this._minimumTrackSkinExplicitMinHeight = this._minimumTrackSkinExplicitHeight;
            }
            return;
        }

        protected function createMaximumTrack():void
        {
            var loc4:*=null;
            if (this.maximumTrack !== null) 
            {
                this.maximumTrack.removeFromParent(true);
                this.maximumTrack = null;
            }
            if (this._trackLayoutMode === feathers.controls.TrackLayoutMode.SINGLE) 
            {
                return;
            }
            var loc1:*=this._maximumTrackFactory == null ? defaultMaximumTrackFactory : this._maximumTrackFactory;
            var loc2:*=this._customMaximumTrackStyleName == null ? this.maximumTrackStyleName : this._customMaximumTrackStyleName;
            var loc3:*=feathers.controls.BasicButton(loc1());
            loc3.styleNameList.add(loc2);
            loc3.keepDownStateOnRollOut = true;
            loc3.addEventListener(starling.events.TouchEvent.TOUCH, this.track_touchHandler);
            this.addChildAt(loc3, 1);
            this.maximumTrack = loc3;
            if (this.maximumTrack is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this.maximumTrack).initializeNow();
            }
            if (this.maximumTrack is feathers.core.IMeasureDisplayObject) 
            {
                loc4 = feathers.core.IMeasureDisplayObject(this.maximumTrack);
                this._maximumTrackSkinExplicitWidth = loc4.explicitWidth;
                this._maximumTrackSkinExplicitHeight = loc4.explicitHeight;
                this._maximumTrackSkinExplicitMinWidth = loc4.explicitMinWidth;
                this._maximumTrackSkinExplicitMinHeight = loc4.explicitMinHeight;
            }
            else 
            {
                this._maximumTrackSkinExplicitWidth = this.maximumTrack.width;
                this._maximumTrackSkinExplicitHeight = this.maximumTrack.height;
                this._maximumTrackSkinExplicitMinWidth = this._maximumTrackSkinExplicitWidth;
                this._maximumTrackSkinExplicitMinHeight = this._maximumTrackSkinExplicitHeight;
            }
            return;
        }

        protected function refreshThumbStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._thumbProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._thumbProperties[loc1];
                this.thumb[loc1] = loc2;
            }
            this.thumb.visible = this._showThumb;
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.Slider.globalStyleProvider;
        }

        protected function refreshMinimumTrackStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._minimumTrackProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._minimumTrackProperties[loc1];
                this.minimumTrack[loc1] = loc2;
            }
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
            this.invalidate(INVALIDATION_FLAG_DATA);
            this.invalidate(INVALIDATION_FLAG_MINIMUM_TRACK_FACTORY);
            this.invalidate(INVALIDATION_FLAG_MAXIMUM_TRACK_FACTORY);
            this.invalidate(INVALIDATION_FLAG_THUMB_FACTORY);
            return;
        }

        protected function refreshMaximumTrackStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (!this.maximumTrack) 
            {
                return;
            }
            var loc3:*=0;
            var loc4:*=this._maximumTrackProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._maximumTrackProperties[loc1];
                this.maximumTrack[loc1] = loc2;
            }
            return;
        }

        public function get value():Number
        {
            return this._value;
        }

        public function set value(arg1:Number):void
        {
            if (!(this._step == 0) && !(arg1 == this._maximum) && !(arg1 == this._minimum)) 
            {
                arg1 = feathers.utils.math.roundToNearest(arg1 - this._minimum, this._step) + this._minimum;
            }
            arg1 = feathers.utils.math.clamp(arg1, this._minimum, this._maximum);
            if (this._value == arg1) 
            {
                return;
            }
            this._value = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            if (this.liveDragging || !this.isDragging) 
            {
                this.dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        protected function refreshEnabled():void
        {
            if (this.thumb is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this.thumb).isEnabled = this._isEnabled;
            }
            if (this.minimumTrack is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this.minimumTrack).isEnabled = this._isEnabled;
            }
            if (this.maximumTrack is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this.maximumTrack).isEnabled = this._isEnabled;
            }
            return;
        }

        public function get minimum():Number
        {
            return this._minimum;
        }

        public function set minimum(arg1:Number):void
        {
            if (this._minimum == arg1) 
            {
                return;
            }
            this._minimum = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function layoutChildren():void
        {
            this.layoutThumb();
            if (this._trackLayoutMode != feathers.controls.TrackLayoutMode.SPLIT) 
            {
                this.layoutTrackWithSingle();
            }
            else 
            {
                this.layoutTrackWithMinMax();
            }
            return;
        }

        public function get maximum():Number
        {
            return this._maximum;
        }

        public function set maximum(arg1:Number):void
        {
            if (this._maximum == arg1) 
            {
                return;
            }
            this._maximum = arg1;
            this.invalidate(INVALIDATION_FLAG_DATA);
            return;
        }

        protected function layoutThumb():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            if (this.thumb is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.thumb).validate();
            }
            if (this._minimum !== this._maximum) 
            {
                loc1 = (this._value - this._minimum) / (this._maximum - this._minimum);
                if (loc1 < 0) 
                {
                    loc1 = 0;
                }
                else if (loc1 > 1) 
                {
                    loc1 = 1;
                }
            }
            else 
            {
                loc1 = 1;
            }
            if (this._direction != feathers.layout.Direction.VERTICAL) 
            {
                loc3 = this.actualWidth - this.thumb.width - this._minimumPadding - this._maximumPadding;
                this.thumb.x = Math.round(this._minimumPadding + loc3 * loc1);
                this.thumb.y = Math.round((this.actualHeight - this.thumb.height) / 2) + this._thumbOffset;
            }
            else 
            {
                loc2 = this.actualHeight - this.thumb.height - this._minimumPadding - this._maximumPadding;
                this.thumb.x = Math.round((this.actualWidth - this.thumb.width) / 2) + this._thumbOffset;
                this.thumb.y = Math.round(this._maximumPadding + loc2 * (1 - loc1));
            }
            return;
        }

        public function get step():Number
        {
            return this._step;
        }

        public function set step(arg1:Number):void
        {
            if (this._step == arg1) 
            {
                return;
            }
            this._step = arg1;
            return;
        }

        protected function layoutTrackWithMinMax():void
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            if (this._direction !== feathers.layout.Direction.VERTICAL) 
            {
                loc2 = Math.round(this.thumb.x + this.thumb.width / 2);
                this.minimumTrack.x = 0;
                this.minimumTrack.width = loc2;
                this.maximumTrack.x = loc2;
                this.maximumTrack.width = this.actualWidth - loc2;
                if (this._trackScaleMode !== feathers.controls.TrackScaleMode.EXACT_FIT) 
                {
                    this.minimumTrack.height = this._minimumTrackSkinExplicitHeight;
                    this.maximumTrack.height = this._maximumTrackSkinExplicitHeight;
                }
                else 
                {
                    this.minimumTrack.y = 0;
                    this.minimumTrack.height = this.actualHeight;
                    this.maximumTrack.y = 0;
                    this.maximumTrack.height = this.actualHeight;
                }
                if (this.minimumTrack is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this.minimumTrack).validate();
                }
                if (this.maximumTrack is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this.maximumTrack).validate();
                }
                if (this._trackScaleMode === feathers.controls.TrackScaleMode.DIRECTIONAL) 
                {
                    this.minimumTrack.y = Math.round((this.actualHeight - this.minimumTrack.height) / 2);
                    this.maximumTrack.y = Math.round((this.actualHeight - this.maximumTrack.height) / 2);
                }
            }
            else 
            {
                loc1 = Math.round(this.thumb.y + this.thumb.height / 2);
                this.maximumTrack.y = 0;
                this.maximumTrack.height = loc1;
                this.minimumTrack.y = loc1;
                this.minimumTrack.height = this.actualHeight - loc1;
                if (this._trackScaleMode !== feathers.controls.TrackScaleMode.EXACT_FIT) 
                {
                    this.maximumTrack.width = this._maximumTrackSkinExplicitWidth;
                    this.minimumTrack.width = this._minimumTrackSkinExplicitWidth;
                }
                else 
                {
                    this.maximumTrack.x = 0;
                    this.maximumTrack.width = this.actualWidth;
                    this.minimumTrack.x = 0;
                    this.minimumTrack.width = this.actualWidth;
                }
                if (this.minimumTrack is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this.minimumTrack).validate();
                }
                if (this.maximumTrack is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this.maximumTrack).validate();
                }
                if (this._trackScaleMode === feathers.controls.TrackScaleMode.DIRECTIONAL) 
                {
                    this.maximumTrack.x = Math.round((this.actualWidth - this.maximumTrack.width) / 2);
                    this.minimumTrack.x = Math.round((this.actualWidth - this.minimumTrack.width) / 2);
                }
            }
            return;
        }

        public function get page():Number
        {
            return this._page;
        }

        public function set page(arg1:Number):void
        {
            if (this._page == arg1) 
            {
                return;
            }
            this._page = arg1;
            return;
        }

        protected function layoutTrackWithSingle():void
        {
            if (this._direction !== feathers.layout.Direction.VERTICAL) 
            {
                this.minimumTrack.x = 0;
                this.minimumTrack.width = this.actualWidth;
                if (this._trackScaleMode !== feathers.controls.TrackScaleMode.EXACT_FIT) 
                {
                    this.minimumTrack.height = this._minimumTrackSkinExplicitHeight;
                }
                else 
                {
                    this.minimumTrack.y = 0;
                    this.minimumTrack.height = this.actualHeight;
                }
                if (this.minimumTrack is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this.minimumTrack).validate();
                }
                if (this._trackScaleMode === feathers.controls.TrackScaleMode.DIRECTIONAL) 
                {
                    this.minimumTrack.y = Math.round((this.actualHeight - this.minimumTrack.height) / 2);
                }
            }
            else 
            {
                this.minimumTrack.y = 0;
                this.minimumTrack.height = this.actualHeight;
                if (this._trackScaleMode !== feathers.controls.TrackScaleMode.EXACT_FIT) 
                {
                    this.minimumTrack.width = this._minimumTrackSkinExplicitWidth;
                }
                else 
                {
                    this.minimumTrack.x = 0;
                    this.minimumTrack.width = this.actualWidth;
                }
                if (this.minimumTrack is feathers.core.IValidating) 
                {
                    feathers.core.IValidating(this.minimumTrack).validate();
                }
                if (this._trackScaleMode === feathers.controls.TrackScaleMode.DIRECTIONAL) 
                {
                    this.minimumTrack.x = Math.round((this.actualWidth - this.minimumTrack.width) / 2);
                }
            }
            return;
        }

        protected function locationToValue(arg1:flash.geom.Point):Number
        {
            var loc1:*=NaN;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            if (this._direction != feathers.layout.Direction.VERTICAL) 
            {
                loc5 = this.actualWidth - this.thumb.width - this._minimumPadding - this._maximumPadding;
                loc6 = arg1.x - this._touchStartX - this._minimumPadding;
                loc7 = Math.min(Math.max(0, this._thumbStartX + loc6), loc5);
                loc1 = loc7 / loc5;
            }
            else 
            {
                loc2 = this.actualHeight - this.thumb.height - this._minimumPadding - this._maximumPadding;
                loc3 = arg1.y - this._touchStartY - this._maximumPadding;
                loc4 = Math.min(Math.max(0, this._thumbStartY + loc3), loc2);
                loc1 = 1 - loc4 / loc2;
            }
            return this._minimum + loc1 * (this._maximum - this._minimum);
        }

        protected function startRepeatTimer(arg1:Function):void
        {
            this.currentRepeatAction = arg1;
            if (this._repeatDelay > 0) 
            {
                if (this._repeatTimer) 
                {
                    this._repeatTimer.reset();
                    this._repeatTimer.delay = this._repeatDelay * 1000;
                }
                else 
                {
                    this._repeatTimer = new flash.utils.Timer(this._repeatDelay * 1000);
                    this._repeatTimer.addEventListener(flash.events.TimerEvent.TIMER, this.repeatTimer_timerHandler);
                }
                this._repeatTimer.start();
            }
            return;
        }

        public function get showThumb():Boolean
        {
            return this._showThumb;
        }

        public function set showThumb(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._showThumb === arg1) 
            {
                return;
            }
            this._showThumb = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function adjustPage():void
        {
            var loc1:*=this._page;
            if (loc1 !== loc1) 
            {
                loc1 = this._step;
            }
            if (this._touchValue < this._value) 
            {
                this.value = Math.max(this._touchValue, this._value - loc1);
            }
            else if (this._touchValue > this._value) 
            {
                this.value = Math.min(this._touchValue, this._value + loc1);
            }
            return;
        }

        public function get thumbOffset():Number
        {
            return this._thumbOffset;
        }

        public function set thumbOffset(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._thumbOffset === arg1) 
            {
                return;
            }
            this._thumbOffset = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function childProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:Object):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get minimumPadding():Number
        {
            return this._minimumPadding;
        }

        public function set minimumPadding(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._minimumPadding === arg1) 
            {
                return;
            }
            this._minimumPadding = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function slider_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this._touchPointID = -1;
            var loc1:*=this.isDragging;
            this.isDragging = false;
            if (loc1 && !this.liveDragging) 
            {
                this.dispatchEventWith(starling.events.Event.CHANGE);
            }
            return;
        }

        public function get maximumPadding():Number
        {
            return this._maximumPadding;
        }

        public function set maximumPadding(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._maximumPadding === arg1) 
            {
                return;
            }
            this._maximumPadding = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function focusInHandler(arg1:starling.events.Event):void
        {
            super.focusInHandler(arg1);
            this.stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            return;
        }

        public function get trackLayoutMode():String
        {
            return this._trackLayoutMode;
        }

        public function set trackLayoutMode(arg1:String):void
        {
            if (arg1 === TRACK_LAYOUT_MODE_MIN_MAX) 
            {
                arg1 = feathers.controls.TrackLayoutMode.SPLIT;
            }
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._trackLayoutMode === arg1) 
            {
                return;
            }
            this._trackLayoutMode = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function focusOutHandler(arg1:starling.events.Event):void
        {
            super.focusOutHandler(arg1);
            this.stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            return;
        }

        public function get trackScaleMode():String
        {
            return this._trackScaleMode;
        }

        public function set trackScaleMode(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._trackScaleMode === arg1) 
            {
                return;
            }
            this._trackScaleMode = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function track_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc2:*=null;
            if (!this._isEnabled) 
            {
                this._touchPointID = -1;
                return;
            }
            var loc1:*=starling.display.DisplayObject(arg1.currentTarget);
            if (this._touchPointID >= 0) 
            {
                loc2 = arg1.getTouch(loc1, null, this._touchPointID);
                if (!loc2) 
                {
                    return;
                }
                if (loc2.phase !== starling.events.TouchPhase.MOVED) 
                {
                    if (loc2.phase === starling.events.TouchPhase.ENDED) 
                    {
                        if (this._repeatTimer) 
                        {
                            this._repeatTimer.stop();
                        }
                        this._touchPointID = -1;
                        this.isDragging = false;
                        if (!this.liveDragging) 
                        {
                            this.dispatchEventWith(starling.events.Event.CHANGE);
                        }
                        this.dispatchEventWith(feathers.events.FeathersEventType.END_INTERACTION);
                    }
                }
                else 
                {
                    loc2.getLocation(this, HELPER_POINT);
                    this.value = this.locationToValue(HELPER_POINT);
                }
            }
            else 
            {
                loc2 = arg1.getTouch(loc1, starling.events.TouchPhase.BEGAN);
                if (!loc2) 
                {
                    return;
                }
                loc2.getLocation(this, HELPER_POINT);
                this._touchPointID = loc2.id;
                if (this._direction != feathers.layout.Direction.VERTICAL) 
                {
                    this._thumbStartX = Math.min(this.actualWidth - this.thumb.width, Math.max(0, HELPER_POINT.x - this.thumb.width / 2));
                    this._thumbStartY = HELPER_POINT.y;
                }
                else 
                {
                    this._thumbStartX = HELPER_POINT.x;
                    this._thumbStartY = Math.min(this.actualHeight - this.thumb.height, Math.max(0, HELPER_POINT.y - this.thumb.height / 2));
                }
                this._touchStartX = HELPER_POINT.x;
                this._touchStartY = HELPER_POINT.y;
                this._touchValue = this.locationToValue(HELPER_POINT);
                this.isDragging = true;
                this.dispatchEventWith(feathers.events.FeathersEventType.BEGIN_INTERACTION);
                if (this._showThumb && this._trackInteractionMode === feathers.controls.TrackInteractionMode.BY_PAGE) 
                {
                    this.adjustPage();
                    this.startRepeatTimer(this.adjustPage);
                }
                else 
                {
                    this.value = this._touchValue;
                }
            }
            return;
        }

        public function get trackInteractionMode():String
        {
            return this._trackInteractionMode;
        }

        public function set trackInteractionMode(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._trackInteractionMode = arg1;
            return;
        }

        protected function thumb_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            if (!this._isEnabled) 
            {
                this._touchPointID = -1;
                return;
            }
            if (this._touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this.thumb, null, this._touchPointID);
                if (!loc1) 
                {
                    return;
                }
                if (loc1.phase != starling.events.TouchPhase.MOVED) 
                {
                    if (loc1.phase == starling.events.TouchPhase.ENDED) 
                    {
                        this._touchPointID = -1;
                        this.isDragging = false;
                        if (!this.liveDragging) 
                        {
                            this.dispatchEventWith(starling.events.Event.CHANGE);
                        }
                        this.dispatchEventWith(feathers.events.FeathersEventType.END_INTERACTION);
                    }
                }
                else 
                {
                    loc2 = feathers.events.ExclusiveTouch.forStage(this.stage);
                    loc3 = loc2.getClaim(this._touchPointID);
                    if (loc3 != this) 
                    {
                        if (loc3) 
                        {
                            return;
                        }
                        loc2.claimTouch(this._touchPointID, this);
                    }
                    loc1.getLocation(this, HELPER_POINT);
                    this.value = this.locationToValue(HELPER_POINT);
                }
            }
            else 
            {
                loc1 = arg1.getTouch(this.thumb, starling.events.TouchPhase.BEGAN);
                if (!loc1) 
                {
                    return;
                }
                loc1.getLocation(this, HELPER_POINT);
                this._touchPointID = loc1.id;
                this._thumbStartX = this.thumb.x;
                this._thumbStartY = this.thumb.y;
                this._touchStartX = HELPER_POINT.x;
                this._touchStartY = HELPER_POINT.y;
                this.isDragging = true;
                this.dispatchEventWith(feathers.events.FeathersEventType.BEGIN_INTERACTION);
            }
            return;
        }

        protected function stage_keyDownHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (arg1.keyCode == flash.ui.Keyboard.HOME) 
            {
                this.value = this._minimum;
                return;
            }
            if (arg1.keyCode == flash.ui.Keyboard.END) 
            {
                this.value = this._maximum;
                return;
            }
            var loc1:*=this._page;
            if (loc1 !== loc1) 
            {
                loc1 = this._step;
            }
            if (this._direction != feathers.layout.Direction.VERTICAL) 
            {
                if (arg1.keyCode != flash.ui.Keyboard.LEFT) 
                {
                    if (arg1.keyCode == flash.ui.Keyboard.RIGHT) 
                    {
                        if (arg1.shiftKey) 
                        {
                            this.value = this.value + loc1;
                        }
                        else 
                        {
                            this.value = this.value + this._step;
                        }
                    }
                }
                else if (arg1.shiftKey) 
                {
                    this.value = this.value - loc1;
                }
                else 
                {
                    this.value = this.value - this._step;
                }
            }
            else if (arg1.keyCode != flash.ui.Keyboard.UP) 
            {
                if (arg1.keyCode == flash.ui.Keyboard.DOWN) 
                {
                    if (arg1.shiftKey) 
                    {
                        this.value = this.value - loc1;
                    }
                    else 
                    {
                        this.value = this.value - this._step;
                    }
                }
            }
            else if (arg1.shiftKey) 
            {
                this.value = this.value + loc1;
            }
            else 
            {
                this.value = this.value + this._step;
            }
            return;
        }

        protected function repeatTimer_timerHandler(arg1:flash.events.TimerEvent):void
        {
            var loc1:*=feathers.events.ExclusiveTouch.forStage(this.stage);
            var loc2:*=loc1.getClaim(this._touchPointID);
            if (loc2 && !(loc2 == this)) 
            {
                return;
            }
            if (this._repeatTimer.currentCount < 5) 
            {
                return;
            }
            this.currentRepeatAction();
            return;
        }

        public function get repeatDelay():Number
        {
            return this._repeatDelay;
        }

        public function set repeatDelay(arg1:Number):void
        {
            if (this._repeatDelay == arg1) 
            {
                return;
            }
            this._repeatDelay = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected static function defaultMaximumTrackFactory():feathers.controls.BasicButton
        {
            return new feathers.controls.Button();
        }

        public function get minimumTrackFactory():Function
        {
            return this._minimumTrackFactory;
        }

        public function set minimumTrackFactory(arg1:Function):void
        {
            if (this._minimumTrackFactory == arg1) 
            {
                return;
            }
            this._minimumTrackFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_MINIMUM_TRACK_FACTORY);
            return;
        }

        protected static function defaultThumbFactory():feathers.controls.BasicButton
        {
            return new feathers.controls.Button();
        }

        public function get customMinimumTrackStyleName():String
        {
            return this._customMinimumTrackStyleName;
        }

        public function set customMinimumTrackStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customMinimumTrackStyleName === arg1) 
            {
                return;
            }
            this._customMinimumTrackStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_MINIMUM_TRACK_FACTORY);
            return;
        }

        protected static function defaultMinimumTrackFactory():feathers.controls.BasicButton
        {
            return new feathers.controls.Button();
        }

        public function get minimumTrackProperties():Object
        {
            if (!this._minimumTrackProperties) 
            {
                this._minimumTrackProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._minimumTrackProperties;
        }

        public function set minimumTrackProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._minimumTrackProperties == arg1) 
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
            if (this._minimumTrackProperties) 
            {
                this._minimumTrackProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._minimumTrackProperties = feathers.core.PropertyProxy(arg1);
            if (this._minimumTrackProperties) 
            {
                this._minimumTrackProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get maximumTrackFactory():Function
        {
            return this._maximumTrackFactory;
        }

        public function set maximumTrackFactory(arg1:Function):void
        {
            if (this._maximumTrackFactory == arg1) 
            {
                return;
            }
            this._maximumTrackFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_MAXIMUM_TRACK_FACTORY);
            return;
        }

        public function get customMaximumTrackStyleName():String
        {
            return this._customMaximumTrackStyleName;
        }

        public function set customMaximumTrackStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customMaximumTrackStyleName === arg1) 
            {
                return;
            }
            this._customMaximumTrackStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_MAXIMUM_TRACK_FACTORY);
            return;
        }

        public function get maximumTrackProperties():Object
        {
            if (!this._maximumTrackProperties) 
            {
                this._maximumTrackProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._maximumTrackProperties;
        }

        public function set maximumTrackProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._maximumTrackProperties == arg1) 
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
            if (this._maximumTrackProperties) 
            {
                this._maximumTrackProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._maximumTrackProperties = feathers.core.PropertyProxy(arg1);
            if (this._maximumTrackProperties) 
            {
                this._maximumTrackProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get thumbFactory():Function
        {
            return this._thumbFactory;
        }

        public static const TRACK_INTERACTION_MODE_BY_PAGE:String="byPage";

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        protected static const INVALIDATION_FLAG_MINIMUM_TRACK_FACTORY:String="minimumTrackFactory";

        protected static const INVALIDATION_FLAG_MAXIMUM_TRACK_FACTORY:String="maximumTrackFactory";

        public static const DIRECTION_HORIZONTAL:String="horizontal";

        public static const DIRECTION_VERTICAL:String="vertical";

        public static const TRACK_LAYOUT_MODE_SINGLE:String="single";

        public static const TRACK_LAYOUT_MODE_MIN_MAX:String="minMax";

        public static const TRACK_SCALE_MODE_EXACT_FIT:String="exactFit";

        public static const TRACK_SCALE_MODE_DIRECTIONAL:String="directional";

        public static const TRACK_INTERACTION_MODE_TO_VALUE:String="toValue";

        public static const DEFAULT_CHILD_STYLE_NAME_MINIMUM_TRACK:String="feathers-slider-minimum-track";

        public static const DEFAULT_CHILD_STYLE_NAME_MAXIMUM_TRACK:String="feathers-slider-maximum-track";

        public static const DEFAULT_CHILD_STYLE_NAME_THUMB:String="feathers-slider-thumb";

        protected static const INVALIDATION_FLAG_THUMB_FACTORY:String="thumbFactory";

        protected var _value:Number=0;

        protected var _minimum:Number=0;

        protected var _maximum:Number=0;

        protected var _step:Number=0;

        protected var _page:Number=NaN;

        protected var isDragging:Boolean=false;

        public var liveDragging:Boolean=true;

        protected var _showThumb:Boolean=true;

        protected var _thumbOffset:Number=0;

        protected var _minimumPadding:Number=0;

        protected var _maximumPadding:Number=0;

        protected var _trackLayoutMode:String="single";

        protected var _trackScaleMode:String="directional";

        protected var _trackInteractionMode:String="toValue";

        protected var currentRepeatAction:Function;

        protected var _repeatTimer:flash.utils.Timer;

        protected var _minimumTrackSkinExplicitHeight:Number;

        protected var _minimumTrackFactory:Function;

        protected var _customMinimumTrackStyleName:String;

        protected var _minimumTrackProperties:feathers.core.PropertyProxy;

        protected var _touchPointID:int=-1;

        protected var _touchStartX:Number=NaN;

        protected var _touchStartY:Number=NaN;

        protected var _thumbStartX:Number=NaN;

        protected var _thumbStartY:Number=NaN;

        protected var _touchValue:Number;

        protected var _customThumbStyleName:String;

        protected var _customMaximumTrackStyleName:String;

        protected var _thumbFactory:Function;

        protected var minimumTrackStyleName:String="feathers-slider-minimum-track";

        protected var _thumbProperties:feathers.core.PropertyProxy;

        protected var maximumTrackStyleName:String="feathers-slider-maximum-track";

        protected var thumbStyleName:String="feathers-slider-thumb";

        protected var thumb:starling.display.DisplayObject;

        protected var minimumTrack:starling.display.DisplayObject;

        protected var maximumTrack:starling.display.DisplayObject;

        protected var _minimumTrackSkinExplicitWidth:Number;

        protected var _minimumTrackSkinExplicitMinWidth:Number;

        protected var _minimumTrackSkinExplicitMinHeight:Number;

        protected var _maximumTrackSkinExplicitWidth:Number;

        protected var _repeatDelay:Number=0.05;

        protected var _maximumTrackSkinExplicitHeight:Number;

        protected var _maximumTrackSkinExplicitMinWidth:Number;

        protected var _maximumTrackSkinExplicitMinHeight:Number;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var _maximumTrackProperties:feathers.core.PropertyProxy;

        protected var _maximumTrackFactory:Function;

        protected var _direction:String="horizontal";
    }
}


