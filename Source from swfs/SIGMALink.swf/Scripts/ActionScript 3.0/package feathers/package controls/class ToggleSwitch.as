//class ToggleSwitch
package feathers.controls 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.skins.*;
    import feathers.system.*;
    import feathers.text.*;
    import flash.geom.*;
    import flash.ui.*;
    import starling.animation.*;
    import starling.core.*;
    import starling.display.*;
    import starling.events.*;
    import starling.text.*;
    import starling.utils.*;
    
    public class ToggleSwitch extends feathers.core.FeathersControl implements feathers.core.IToggle, feathers.core.IFocusDisplayObject, feathers.core.ITextBaselineControl, feathers.core.IStateContext
    {
        public function ToggleSwitch()
        {
            super();
            if (this._onLabelFontStylesSet === null) 
            {
                this._onLabelFontStylesSet = new feathers.text.FontStylesSet();
                this._onLabelFontStylesSet.addEventListener(starling.events.Event.CHANGE, this.fontStyles_changeHandler);
            }
            if (this._offLabelFontStylesSet === null) 
            {
                this._offLabelFontStylesSet = new feathers.text.FontStylesSet();
                this._offLabelFontStylesSet.addEventListener(starling.events.Event.CHANGE, this.fontStyles_changeHandler);
            }
            this.addEventListener(starling.events.TouchEvent.TOUCH, this.toggleSwitch_touchHandler);
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.toggleSwitch_removedFromStageHandler);
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

        public function get baseline():Number
        {
            if (!this.onTextRenderer) 
            {
                return this.scaledActualHeight;
            }
            return this.scaleY * (this.onTextRenderer.y + this.onTextRenderer.baseline);
        }

        public function setSelectionWithAnimation(arg1:Boolean):void
        {
            if (this._isSelected == arg1) 
            {
                return;
            }
            this.isSelected = arg1;
            this._animateSelectionChange = true;
            return;
        }

        public function getOnLabelFontStylesForState(arg1:String):starling.text.TextFormat
        {
            if (this._onLabelFontStylesSet === null) 
            {
                return null;
            }
            return this._onLabelFontStylesSet.getFormatForState(arg1);
        }

        public function setOnLabelFontStylesForState(arg1:String, arg2:starling.text.TextFormat):void
        {
            this._onLabelFontStylesSet.setFormatForState(arg1, arg2);
            return;
        }

        public function getOffLabelFontStylesForState(arg1:String):starling.text.TextFormat
        {
            if (this._offLabelFontStylesSet === null) 
            {
                return null;
            }
            return this._offLabelFontStylesSet.getFormatForState(arg1);
        }

        public function setOffLabelFontStylesForState(arg1:String, arg2:starling.text.TextFormat):void
        {
            this._offLabelFontStylesSet.setFormatForState(arg1, arg2);
            return;
        }

        protected override function draw():void
        {
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_SELECTED);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_FOCUS);
            var loc6:*=this.isInvalid(INVALIDATION_FLAG_LAYOUT);
            var loc7:*=this.isInvalid(INVALIDATION_FLAG_TEXT_RENDERER);
            var loc8:*=this.isInvalid(INVALIDATION_FLAG_THUMB_FACTORY);
            var loc9:*=this.isInvalid(INVALIDATION_FLAG_ON_TRACK_FACTORY);
            var loc10:*=this.isInvalid(INVALIDATION_FLAG_OFF_TRACK_FACTORY);
            if (loc8) 
            {
                this.createThumb();
            }
            if (loc9) 
            {
                this.createOnTrack();
            }
            if (loc10 || loc6) 
            {
                this.createOffTrack();
            }
            if (loc7) 
            {
                this.createLabels();
            }
            if (loc7 || loc2 || loc4) 
            {
                this.refreshOnLabelStyles();
                this.refreshOffLabelStyles();
            }
            if (loc8 || loc2) 
            {
                this.refreshThumbStyles();
            }
            if (loc9 || loc2) 
            {
                this.refreshOnTrackStyles();
            }
            if ((loc10 || loc6 || loc2) && this.offTrack) 
            {
                this.refreshOffTrackStyles();
            }
            if (loc4 || loc6 || loc8 || loc9 || loc9 || loc7) 
            {
                this.refreshEnabled();
            }
            loc3 = this.autoSizeIfNeeded() || loc3;
            if (loc3 || loc2 || loc1) 
            {
                this.updateSelection();
            }
            this.layoutChildren();
            if (loc3 || loc5) 
            {
                this.refreshFocusIndicator();
            }
            return;
        }

        protected function autoSizeIfNeeded():Boolean
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
                this.onTrack.width = this._onTrackSkinExplicitWidth;
            }
            else if (loc5) 
            {
                this.onTrack.width = this._explicitWidth;
            }
            if (this.onTrack is feathers.core.IMeasureDisplayObject) 
            {
                loc10 = feathers.core.IMeasureDisplayObject(this.onTrack);
                if (loc3) 
                {
                    loc10.minWidth = this._onTrackSkinExplicitMinWidth;
                }
                else if (loc5) 
                {
                    loc11 = this._explicitMinWidth;
                    if (this._onTrackSkinExplicitMinWidth > loc11) 
                    {
                        loc11 = this._onTrackSkinExplicitMinWidth;
                    }
                    loc10.minWidth = loc11;
                }
            }
            if (!loc5) 
            {
                if (loc1) 
                {
                    this.offTrack.width = this._offTrackSkinExplicitWidth;
                }
                if (this.offTrack is feathers.core.IMeasureDisplayObject) 
                {
                    loc12 = feathers.core.IMeasureDisplayObject(this.offTrack);
                    if (loc3) 
                    {
                        loc12.minWidth = this._offTrackSkinExplicitMinWidth;
                    }
                }
            }
            if (this.onTrack is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.onTrack).validate();
            }
            if (this.offTrack is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.offTrack).validate();
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
                loc6 = this.onTrack.width;
                if (!loc5) 
                {
                    if (this.offTrack.width > loc6) 
                    {
                        loc6 = this.offTrack.width;
                    }
                    loc6 = loc6 + this.thumb.width / 2;
                }
            }
            if (loc2) 
            {
                loc7 = this.onTrack.height;
                if (!loc5 && this.offTrack.height > loc7) 
                {
                    loc7 = this.offTrack.height;
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
                    loc8 = this.onTrack.width;
                }
                else 
                {
                    loc8 = loc10.minWidth;
                }
                if (!loc5) 
                {
                    if (loc12 === null) 
                    {
                        if (this.offTrack.width > loc8) 
                        {
                            loc8 = this.offTrack.width;
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
                    loc9 = this.onTrack.height;
                }
                else 
                {
                    loc9 = loc10.minHeight;
                }
                if (!loc5) 
                {
                    if (loc12 === null) 
                    {
                        if (this.offTrack.height > loc9) 
                        {
                            loc9 = this.offTrack.height;
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

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return ToggleSwitch.globalStyleProvider;
        }

        protected function createThumb():void
        {
            if (this.thumb !== null) 
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

        public function get currentState():String
        {
            return this._currentState;
        }

        public override function set isEnabled(arg1:Boolean):void
        {
            if (this._isEnabled === arg1) 
            {
                return;
            }
            super.isEnabled = arg1;
            this.resetState();
            return;
        }

        protected function createOnTrack():void
        {
            var loc4:*=null;
            if (this.onTrack !== null) 
            {
                this.onTrack.removeFromParent(true);
                this.onTrack = null;
            }
            var loc1:*=this._onTrackFactory == null ? defaultOnTrackFactory : this._onTrackFactory;
            var loc2:*=this._customOnTrackStyleName == null ? this.onTrackStyleName : this._customOnTrackStyleName;
            var loc3:*=feathers.controls.BasicButton(loc1());
            loc3.styleNameList.add(loc2);
            loc3.keepDownStateOnRollOut = true;
            this.addChildAt(loc3, 0);
            this.onTrack = loc3;
            if (this.onTrack is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this.onTrack).initializeNow();
            }
            if (this.onTrack is feathers.core.IMeasureDisplayObject) 
            {
                loc4 = feathers.core.IMeasureDisplayObject(this.onTrack);
                this._onTrackSkinExplicitWidth = loc4.explicitWidth;
                this._onTrackSkinExplicitHeight = loc4.explicitHeight;
                this._onTrackSkinExplicitMinWidth = loc4.explicitMinWidth;
                this._onTrackSkinExplicitMinHeight = loc4.explicitMinHeight;
            }
            else 
            {
                this._onTrackSkinExplicitWidth = this.onTrack.width;
                this._onTrackSkinExplicitHeight = this.onTrack.height;
                this._onTrackSkinExplicitMinWidth = this._onTrackSkinExplicitWidth;
                this._onTrackSkinExplicitMinHeight = this._onTrackSkinExplicitHeight;
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

        protected function createOffTrack():void
        {
            var loc4:*=null;
            if (this.offTrack !== null) 
            {
                this.offTrack.removeFromParent(true);
                this.offTrack = null;
            }
            if (this._trackLayoutMode === feathers.controls.TrackLayoutMode.SINGLE) 
            {
                return;
            }
            var loc1:*=this._offTrackFactory == null ? defaultOffTrackFactory : this._offTrackFactory;
            var loc2:*=this._customOffTrackStyleName == null ? this.offTrackStyleName : this._customOffTrackStyleName;
            var loc3:*=feathers.controls.BasicButton(loc1());
            loc3.styleNameList.add(loc2);
            loc3.keepDownStateOnRollOut = true;
            this.addChildAt(loc3, 1);
            this.offTrack = loc3;
            if (this.offTrack is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this.offTrack).initializeNow();
            }
            if (this.offTrack is feathers.core.IMeasureDisplayObject) 
            {
                loc4 = feathers.core.IMeasureDisplayObject(this.offTrack);
                this._offTrackSkinExplicitWidth = loc4.explicitWidth;
                this._offTrackSkinExplicitHeight = loc4.explicitHeight;
                this._offTrackSkinExplicitMinWidth = loc4.explicitMinWidth;
                this._offTrackSkinExplicitMinHeight = loc4.explicitMinHeight;
            }
            else 
            {
                this._offTrackSkinExplicitWidth = this.offTrack.width;
                this._offTrackSkinExplicitHeight = this.offTrack.height;
                this._offTrackSkinExplicitMinWidth = this._offTrackSkinExplicitWidth;
                this._offTrackSkinExplicitMinHeight = this._offTrackSkinExplicitHeight;
            }
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

        protected function createLabels():void
        {
            if (this.offTextRenderer) 
            {
                this.removeChild(starling.display.DisplayObject(this.offTextRenderer), true);
                this.offTextRenderer = null;
            }
            if (this.onTextRenderer) 
            {
                this.removeChild(starling.display.DisplayObject(this.onTextRenderer), true);
                this.onTextRenderer = null;
            }
            var loc1:*=this.getChildIndex(this.thumb);
            var loc2:*=this._offLabelFactory;
            if (loc2 == null) 
            {
                loc2 = this._labelFactory;
            }
            if (loc2 == null) 
            {
                loc2 = feathers.core.FeathersControl.defaultTextRendererFactory;
            }
            this.offTextRenderer = feathers.core.ITextRenderer(loc2());
            this.offTextRenderer.stateContext = this;
            var loc3:*=this._customOffLabelStyleName == null ? this.offLabelStyleName : this._customOffLabelStyleName;
            this.offTextRenderer.styleNameList.add(loc3);
            var loc4:*=new starling.display.Quad(1, 1, 16711935);
            loc4.width = 0;
            loc4.height = 0;
            this.offTextRenderer.mask = loc4;
            this.addChildAt(starling.display.DisplayObject(this.offTextRenderer), loc1);
            var loc5:*=this._onLabelFactory;
            if (loc5 == null) 
            {
                loc5 = this._labelFactory;
            }
            if (loc5 == null) 
            {
                loc5 = feathers.core.FeathersControl.defaultTextRendererFactory;
            }
            this.onTextRenderer = feathers.core.ITextRenderer(loc5());
            this.onTextRenderer.stateContext = this;
            var loc6:*=this._customOnLabelStyleName == null ? this.onLabelStyleName : this._customOnLabelStyleName;
            this.onTextRenderer.styleNameList.add(loc6);
            loc4 = new starling.display.Quad(1, 1, 16711935);
            loc4.width = 0;
            loc4.height = 0;
            this.onTextRenderer.mask = loc4;
            this.addChildAt(starling.display.DisplayObject(this.onTextRenderer), loc1);
            return;
        }

        public function get showLabels():Boolean
        {
            return this._showLabels;
        }

        public function set showLabels(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._showLabels === arg1) 
            {
                return;
            }
            this._showLabels = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function changeState(arg1:String):void
        {
            if (this._currentState === arg1) 
            {
                return;
            }
            this._currentState = arg1;
            this.invalidate(INVALIDATION_FLAG_STATE);
            this.dispatchEventWith(feathers.events.FeathersEventType.STATE_CHANGE);
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

        protected function resetState():void
        {
            if (this._isEnabled) 
            {
                if (this._isSelected) 
                {
                    this.changeState(feathers.controls.ToggleState.SELECTED);
                }
                else 
                {
                    this.changeState(feathers.controls.ToggleState.NOT_SELECTED);
                }
            }
            else if (this._isSelected) 
            {
                this.changeState(feathers.controls.ToggleState.SELECTED_AND_DISABLED);
            }
            else 
            {
                this.changeState(feathers.controls.ToggleState.DISABLED);
            }
            return;
        }

        public function get trackLayoutMode():String
        {
            return this._trackLayoutMode;
        }

        public function set trackLayoutMode(arg1:String):void
        {
            if (arg1 === TRACK_LAYOUT_MODE_ON_OFF) 
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
            this.invalidate(INVALIDATION_FLAG_LAYOUT);
            return;
        }

        protected function layoutChildren():void
        {
            var loc3:*=NaN;
            if (this.thumb is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.thumb).validate();
            }
            this.thumb.y = (this.actualHeight - this.thumb.height) / 2;
            var loc1:*=Math.max(0, this.actualWidth - this.thumb.width - this._paddingLeft - this._paddingRight);
            var loc2:*=Math.max(this.onTextRenderer.height, this.offTextRenderer.height);
            if (this._labelAlign != LABEL_ALIGN_MIDDLE) 
            {
                loc3 = Math.max(this.onTextRenderer.baseline, this.offTextRenderer.baseline);
            }
            else 
            {
                loc3 = loc2;
            }
            var loc4:*=this.onTextRenderer.mask;
            loc4.width = loc1;
            loc4.height = loc2;
            this.onTextRenderer.y = (this.actualHeight - loc3) / 2;
            loc4 = this.offTextRenderer.mask;
            loc4.width = loc1;
            loc4.height = loc2;
            this.offTextRenderer.y = (this.actualHeight - loc3) / 2;
            this.layoutTracks();
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

        protected function layoutTracks():void
        {
            var loc1:*=Math.max(0, this.actualWidth - this.thumb.width - this._paddingLeft - this._paddingRight);
            var loc2:*=this.thumb.x - this._paddingLeft;
            var loc3:*=loc1 - loc2 - (loc1 - this.onTextRenderer.width) / 2;
            var loc4:*=this.onTextRenderer.mask;
            loc4.x = loc3;
            this.onTextRenderer.x = this._paddingLeft - loc3;
            var loc5:*=-loc2 - (loc1 - this.offTextRenderer.width) / 2;
            loc4 = this.offTextRenderer.mask;
            loc4.x = loc5;
            this.offTextRenderer.x = this.actualWidth - this._paddingRight - loc1 - loc5;
            if (this._trackLayoutMode != feathers.controls.TrackLayoutMode.SPLIT) 
            {
                this.layoutTrackWithSingle();
            }
            else 
            {
                this.layoutTrackWithOnOff();
            }
            return;
        }

        public function get defaultLabelProperties():Object
        {
            if (!this._defaultLabelProperties) 
            {
                this._defaultLabelProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._defaultLabelProperties;
        }

        public function set defaultLabelProperties(arg1:Object):void
        {
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            if (this._defaultLabelProperties) 
            {
                this._defaultLabelProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._defaultLabelProperties = feathers.core.PropertyProxy(arg1);
            if (this._defaultLabelProperties) 
            {
                this._defaultLabelProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function updateSelection():void
        {
            var loc2:*=null;
            if (this.thumb is feathers.core.IToggle) 
            {
                loc2 = feathers.core.IToggle(this.thumb);
                if (this._toggleThumbSelection) 
                {
                    loc2.isSelected = this._isSelected;
                }
                else 
                {
                    loc2.isSelected = false;
                }
            }
            if (this.thumb is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.thumb).validate();
            }
            var loc1:*=this._paddingLeft;
            if (this._isSelected) 
            {
                loc1 = this.actualWidth - this.thumb.width - this._paddingRight;
            }
            if (this._toggleTween) 
            {
                starling.core.Starling.juggler.remove(this._toggleTween);
                this._toggleTween = null;
            }
            if (this._animateSelectionChange) 
            {
                this._toggleTween = new starling.animation.Tween(this.thumb, this._toggleDuration, this._toggleEase);
                this._toggleTween.animate("x", loc1);
                this._toggleTween.onUpdate = this.selectionTween_onUpdate;
                this._toggleTween.onComplete = this.selectionTween_onComplete;
                starling.core.Starling.juggler.add(this._toggleTween);
            }
            else 
            {
                this.thumb.x = loc1;
            }
            this._animateSelectionChange = false;
            return;
        }

        public function get disabledLabelProperties():Object
        {
            if (!this._disabledLabelProperties) 
            {
                this._disabledLabelProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._disabledLabelProperties;
        }

        public function set disabledLabelProperties(arg1:Object):void
        {
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            if (this._disabledLabelProperties) 
            {
                this._disabledLabelProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._disabledLabelProperties = feathers.core.PropertyProxy(arg1);
            if (this._disabledLabelProperties) 
            {
                this._disabledLabelProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshOnLabelStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (!this._showLabels || !this._showThumb) 
            {
                this.onTextRenderer.visible = false;
                return;
            }
            this.onTextRenderer.fontStyles = this._onLabelFontStylesSet;
            if (!this._isEnabled) 
            {
                loc1 = this._disabledLabelProperties;
            }
            if (!loc1 && this._onLabelProperties) 
            {
                loc1 = this._onLabelProperties;
            }
            if (!loc1) 
            {
                loc1 = this._defaultLabelProperties;
            }
            this.onTextRenderer.text = this._onText;
            if (loc1) 
            {
                loc2 = starling.display.DisplayObject(this.onTextRenderer);
                var loc5:*=0;
                var loc6:*=loc1;
                for (loc3 in loc6) 
                {
                    loc4 = loc1[loc3];
                    loc2[loc3] = loc4;
                }
            }
            this.onTextRenderer.validate();
            this.onTextRenderer.visible = true;
            return;
        }

        public function get onLabelProperties():Object
        {
            if (!this._onLabelProperties) 
            {
                this._onLabelProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._onLabelProperties;
        }

        public function set onLabelProperties(arg1:Object):void
        {
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            if (this._onLabelProperties) 
            {
                this._onLabelProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._onLabelProperties = feathers.core.PropertyProxy(arg1);
            if (this._onLabelProperties) 
            {
                this._onLabelProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshOffLabelStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=null;
            var loc4:*=null;
            if (!this._showLabels || !this._showThumb) 
            {
                this.offTextRenderer.visible = false;
                return;
            }
            this.offTextRenderer.fontStyles = this._offLabelFontStylesSet;
            if (!this._isEnabled) 
            {
                loc1 = this._disabledLabelProperties;
            }
            if (!loc1 && this._offLabelProperties) 
            {
                loc1 = this._offLabelProperties;
            }
            if (!loc1) 
            {
                loc1 = this._defaultLabelProperties;
            }
            this.offTextRenderer.text = this._offText;
            if (loc1) 
            {
                loc2 = starling.display.DisplayObject(this.offTextRenderer);
                var loc5:*=0;
                var loc6:*=loc1;
                for (loc3 in loc6) 
                {
                    loc4 = loc1[loc3];
                    loc2[loc3] = loc4;
                }
            }
            this.offTextRenderer.validate();
            this.offTextRenderer.visible = true;
            return;
        }

        public function get offLabelProperties():Object
        {
            if (!this._offLabelProperties) 
            {
                this._offLabelProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._offLabelProperties;
        }

        public function set offLabelProperties(arg1:Object):void
        {
            if (!(arg1 is feathers.core.PropertyProxy)) 
            {
                arg1 = feathers.core.PropertyProxy.fromObject(arg1);
            }
            if (this._offLabelProperties) 
            {
                this._offLabelProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._offLabelProperties = feathers.core.PropertyProxy(arg1);
            if (this._offLabelProperties) 
            {
                this._offLabelProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
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

        public function get labelAlign():String
        {
            return this._labelAlign;
        }

        public function set labelAlign(arg1:String):void
        {
            if (this._labelAlign === arg1) 
            {
                return;
            }
            this._labelAlign = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected function refreshOnTrackStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            var loc3:*=0;
            var loc4:*=this._onTrackProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._onTrackProperties[loc1];
                this.onTrack[loc1] = loc2;
            }
            return;
        }

        public function get labelFactory():Function
        {
            return this._labelFactory;
        }

        public function set labelFactory(arg1:Function):void
        {
            if (this._labelFactory == arg1) 
            {
                return;
            }
            this._labelFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        protected function refreshOffTrackStyles():void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (!this.offTrack) 
            {
                return;
            }
            var loc3:*=0;
            var loc4:*=this._offTrackProperties;
            for (loc1 in loc4) 
            {
                loc2 = this._offTrackProperties[loc1];
                this.offTrack[loc1] = loc2;
            }
            return;
        }

        public function get onLabelFontStyles():starling.text.TextFormat
        {
            return this._onLabelFontStylesSet.format;
        }

        public function set onLabelFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._onLabelFontStylesSet.format = arg1;
            return;
        }

        public function get onLabelDisabledFontStyles():starling.text.TextFormat
        {
            return this._onLabelFontStylesSet.disabledFormat;
        }

        public function set onLabelDisabledFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._onLabelFontStylesSet.disabledFormat = arg1;
            return;
        }

        public function get onLabelSelectedFontStyles():starling.text.TextFormat
        {
            return this._onLabelFontStylesSet.selectedFormat;
        }

        public function set onLabelSelectedFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._onLabelFontStylesSet.selectedFormat = arg1;
            return;
        }

        protected function refreshEnabled():void
        {
            if (this.thumb is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this.thumb).isEnabled = this._isEnabled;
            }
            if (this.onTrack is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this.onTrack).isEnabled = this._isEnabled;
            }
            if (this.offTrack is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this.offTrack).isEnabled = this._isEnabled;
            }
            this.onTextRenderer.isEnabled = this._isEnabled;
            this.offTextRenderer.isEnabled = this._isEnabled;
            return;
        }

        public function get onLabelFactory():Function
        {
            return this._onLabelFactory;
        }

        public function set onLabelFactory(arg1:Function):void
        {
            if (this._onLabelFactory == arg1) 
            {
                return;
            }
            this._onLabelFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        protected function layoutTrackWithOnOff():void
        {
            var loc1:*=Math.round(this.thumb.x + this.thumb.width / 2);
            this.onTrack.x = 0;
            this.onTrack.width = loc1;
            this.offTrack.x = loc1;
            this.offTrack.width = this.actualWidth - loc1;
            if (this._trackScaleMode === feathers.controls.TrackScaleMode.EXACT_FIT) 
            {
                this.onTrack.y = 0;
                this.onTrack.height = this.actualHeight;
                this.offTrack.y = 0;
                this.offTrack.height = this.actualHeight;
            }
            if (this.onTrack is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.onTrack).validate();
            }
            if (this.offTrack is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.offTrack).validate();
            }
            if (this._trackScaleMode === feathers.controls.TrackScaleMode.DIRECTIONAL) 
            {
                this.onTrack.y = Math.round((this.actualHeight - this.onTrack.height) / 2);
                this.offTrack.y = Math.round((this.actualHeight - this.offTrack.height) / 2);
            }
            return;
        }

        public function get customOnLabelStyleName():String
        {
            return this._customOnLabelStyleName;
        }

        public function set customOnLabelStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customOnLabelStyleName === arg1) 
            {
                return;
            }
            this._customOnLabelStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        protected function layoutTrackWithSingle():void
        {
            this.onTrack.x = 0;
            this.onTrack.width = this.actualWidth;
            if (this._trackScaleMode !== feathers.controls.TrackScaleMode.EXACT_FIT) 
            {
                this.onTrack.height = this._onTrackSkinExplicitHeight;
            }
            else 
            {
                this.onTrack.y = 0;
                this.onTrack.height = this.actualHeight;
            }
            if (this.onTrack is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.onTrack).validate();
            }
            if (this._trackScaleMode === feathers.controls.TrackScaleMode.DIRECTIONAL) 
            {
                this.onTrack.y = Math.round((this.actualHeight - this.onTrack.height) / 2);
            }
            return;
        }

        public function get offLabelFontStyles():starling.text.TextFormat
        {
            return this._offLabelFontStylesSet.format;
        }

        public function set offLabelFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._offLabelFontStylesSet.format = arg1;
            return;
        }

        public function get offLabelDisabledFontStyles():starling.text.TextFormat
        {
            return this._offLabelFontStylesSet.disabledFormat;
        }

        public function set offLabelDisabledFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._offLabelFontStylesSet.disabledFormat = arg1;
            return;
        }

        public function get offLabelSelectedFontStyles():starling.text.TextFormat
        {
            return this._offLabelFontStylesSet.selectedFormat;
        }

        public function set offLabelSelectedFontStyles(arg1:starling.text.TextFormat):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._offLabelFontStylesSet.selectedFormat = arg1;
            return;
        }

        protected function childProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:Object):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get offLabelFactory():Function
        {
            return this._offLabelFactory;
        }

        public function set offLabelFactory(arg1:Function):void
        {
            if (this._offLabelFactory == arg1) 
            {
                return;
            }
            this._offLabelFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        protected function toggleSwitch_removedFromStageHandler(arg1:starling.events.Event):void
        {
            this._touchPointID = -1;
            return;
        }

        public function get customOffLabelStyleName():String
        {
            return this._customOffLabelStyleName;
        }

        public function set customOffLabelStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customOffLabelStyleName === arg1) 
            {
                return;
            }
            this._customOffLabelStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_TEXT_RENDERER);
            return;
        }

        protected override function focusInHandler(arg1:starling.events.Event):void
        {
            super.focusInHandler(arg1);
            this.stage.addEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            this.stage.addEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
            return;
        }

        protected override function focusOutHandler(arg1:starling.events.Event):void
        {
            super.focusOutHandler(arg1);
            this.stage.removeEventListener(starling.events.KeyboardEvent.KEY_DOWN, this.stage_keyDownHandler);
            this.stage.removeEventListener(starling.events.KeyboardEvent.KEY_UP, this.stage_keyUpHandler);
            return;
        }

        protected function toggleSwitch_touchHandler(arg1:starling.events.TouchEvent):void
        {
            if (this._ignoreTapHandler) 
            {
                this._ignoreTapHandler = false;
                return;
            }
            if (!this._isEnabled) 
            {
                this._touchPointID = -1;
                return;
            }
            var loc1:*=arg1.getTouch(this, starling.events.TouchPhase.ENDED);
            if (!loc1) 
            {
                return;
            }
            this._touchPointID = -1;
            loc1.getLocation(this.stage, HELPER_POINT);
            var loc2:*=this.contains(this.stage.hitTest(HELPER_POINT));
            if (loc2) 
            {
                this.setSelectionWithAnimation(!this._isSelected);
            }
            return;
        }

        protected function thumb_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
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
                loc1.getLocation(this, HELPER_POINT);
                loc2 = this.actualWidth - this._paddingLeft - this._paddingRight - this.thumb.width;
                if (loc1.phase != starling.events.TouchPhase.MOVED) 
                {
                    if (loc1.phase == starling.events.TouchPhase.ENDED) 
                    {
                        loc5 = Math.abs(HELPER_POINT.x - this._touchStartX);
                        loc6 = loc5 / feathers.system.DeviceCapabilities.dpi;
                        if (loc6 > MINIMUM_DRAG_DISTANCE || starling.utils.SystemUtil.isDesktop && loc5 >= 1) 
                        {
                            this._touchPointID = -1;
                            this._ignoreTapHandler = true;
                            this.setSelectionWithAnimation(this.thumb.x > this._paddingLeft + loc2 / 2);
                            this.invalidate(INVALIDATION_FLAG_SELECTED);
                        }
                    }
                }
                else 
                {
                    loc3 = HELPER_POINT.x - this._touchStartX;
                    loc4 = Math.min(Math.max(this._paddingLeft, this._thumbStartX + loc3), this._paddingLeft + loc2);
                    this.thumb.x = loc4;
                    this.layoutTracks();
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
                this._touchStartX = HELPER_POINT.x;
            }
            return;
        }

        protected function stage_keyDownHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (arg1.keyCode == flash.ui.Keyboard.ESCAPE) 
            {
                this._touchPointID = -1;
            }
            if (this._touchPointID >= 0 || !(arg1.keyCode == flash.ui.Keyboard.SPACE)) 
            {
                return;
            }
            this._touchPointID = int.MAX_VALUE;
            return;
        }

        protected function stage_keyUpHandler(arg1:starling.events.KeyboardEvent):void
        {
            if (!(this._touchPointID == int.MAX_VALUE) || !(arg1.keyCode == flash.ui.Keyboard.SPACE)) 
            {
                return;
            }
            this._touchPointID = -1;
            this.setSelectionWithAnimation(!this._isSelected);
            return;
        }

        protected function selectionTween_onUpdate():void
        {
            this.layoutTracks();
            return;
        }

        protected function selectionTween_onComplete():void
        {
            this._toggleTween = null;
            return;
        }

        protected function fontStyles_changeHandler(arg1:starling.events.Event):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get isSelected():Boolean
        {
            return this._isSelected;
        }

        public function set isSelected(arg1:Boolean):void
        {
            this._animateSelectionChange = false;
            if (this._isSelected == arg1) 
            {
                return;
            }
            this._isSelected = arg1;
            this.resetState();
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            this.dispatchEventWith(starling.events.Event.CHANGE);
            return;
        }

        protected static function defaultThumbFactory():feathers.controls.BasicButton
        {
            return new feathers.controls.Button();
        }

        public function get toggleThumbSelection():Boolean
        {
            return this._toggleThumbSelection;
        }

        public function set toggleThumbSelection(arg1:Boolean):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._toggleThumbSelection === arg1) 
            {
                return;
            }
            this._toggleThumbSelection = arg1;
            this.invalidate(INVALIDATION_FLAG_SELECTED);
            return;
        }

        protected static function defaultOnTrackFactory():feathers.controls.BasicButton
        {
            return new feathers.controls.Button();
        }

        public function get toggleDuration():Number
        {
            return this._toggleDuration;
        }

        public function set toggleDuration(arg1:Number):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._toggleDuration = arg1;
            return;
        }

        protected static function defaultOffTrackFactory():feathers.controls.BasicButton
        {
            return new feathers.controls.Button();
        }

        public function get toggleEase():Object
        {
            return this._toggleEase;
        }

        public function set toggleEase(arg1:Object):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            this._toggleEase = arg1;
            return;
        }

        public function get onText():String
        {
            return this._onText;
        }

        public function set onText(arg1:String):void
        {
            if (arg1 === null) 
            {
                arg1 = "";
            }
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._onText === arg1) 
            {
                return;
            }
            this._onText = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get offText():String
        {
            return this._offText;
        }

        public function set offText(arg1:String):void
        {
            if (arg1 === null) 
            {
                arg1 = "";
            }
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._offText === arg1) 
            {
                return;
            }
            this._offText = arg1;
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get onTrackFactory():Function
        {
            return this._onTrackFactory;
        }

        public function set onTrackFactory(arg1:Function):void
        {
            if (this._onTrackFactory == arg1) 
            {
                return;
            }
            this._onTrackFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_ON_TRACK_FACTORY);
            return;
        }

        public function get customOnTrackStyleName():String
        {
            return this._customOnTrackStyleName;
        }

        public function set customOnTrackStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customOnTrackStyleName === arg1) 
            {
                return;
            }
            this._customOnTrackStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_ON_TRACK_FACTORY);
            return;
        }

        public function get onTrackProperties():Object
        {
            if (!this._onTrackProperties) 
            {
                this._onTrackProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._onTrackProperties;
        }

        public function set onTrackProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._onTrackProperties == arg1) 
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
            if (this._onTrackProperties) 
            {
                this._onTrackProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._onTrackProperties = feathers.core.PropertyProxy(arg1);
            if (this._onTrackProperties) 
            {
                this._onTrackProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get offTrackFactory():Function
        {
            return this._offTrackFactory;
        }

        public function set offTrackFactory(arg1:Function):void
        {
            if (this._offTrackFactory == arg1) 
            {
                return;
            }
            this._offTrackFactory = arg1;
            this.invalidate(INVALIDATION_FLAG_OFF_TRACK_FACTORY);
            return;
        }

        public function get customOffTrackStyleName():String
        {
            return this._customOffTrackStyleName;
        }

        public function set customOffTrackStyleName(arg1:String):void
        {
            if (this.processStyleRestriction(arguments.callee)) 
            {
                return;
            }
            if (this._customOffTrackStyleName === arg1) 
            {
                return;
            }
            this._customOffTrackStyleName = arg1;
            this.invalidate(INVALIDATION_FLAG_OFF_TRACK_FACTORY);
            return;
        }

        public function get offTrackProperties():Object
        {
            if (!this._offTrackProperties) 
            {
                this._offTrackProperties = new feathers.core.PropertyProxy(this.childProperties_onChange);
            }
            return this._offTrackProperties;
        }

        public function set offTrackProperties(arg1:Object):void
        {
            var loc1:*=null;
            var loc2:*=null;
            if (this._offTrackProperties == arg1) 
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
            if (this._offTrackProperties) 
            {
                this._offTrackProperties.removeOnChangeCallback(this.childProperties_onChange);
            }
            this._offTrackProperties = feathers.core.PropertyProxy(arg1);
            if (this._offTrackProperties) 
            {
                this._offTrackProperties.addOnChangeCallback(this.childProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        public function get thumbFactory():Function
        {
            return this._thumbFactory;
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

        public static const TRACK_LAYOUT_MODE_ON_OFF:String="onOff";

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        internal static const MINIMUM_DRAG_DISTANCE:Number=0.04;

        protected static const INVALIDATION_FLAG_THUMB_FACTORY:String="thumbFactory";

        protected static const INVALIDATION_FLAG_ON_TRACK_FACTORY:String="onTrackFactory";

        protected static const INVALIDATION_FLAG_OFF_TRACK_FACTORY:String="offTrackFactory";

        public static const LABEL_ALIGN_MIDDLE:String="middle";

        public static const LABEL_ALIGN_BASELINE:String="baseline";

        public static const TRACK_LAYOUT_MODE_SINGLE:String="single";

        public static const DEFAULT_CHILD_STYLE_NAME_OFF_LABEL:String="feathers-toggle-switch-off-label";

        public static const DEFAULT_CHILD_STYLE_NAME_ON_LABEL:String="feathers-toggle-switch-on-label";

        public static const DEFAULT_CHILD_STYLE_NAME_OFF_TRACK:String="feathers-toggle-switch-off-track";

        public static const DEFAULT_CHILD_STYLE_NAME_ON_TRACK:String="feathers-toggle-switch-on-track";

        public static const DEFAULT_CHILD_STYLE_NAME_THUMB:String="feathers-toggle-switch-thumb";

        protected var _showThumb:Boolean=true;

        protected var _trackLayoutMode:String="single";

        protected var _trackScaleMode:String="directional";

        protected var _defaultLabelProperties:feathers.core.PropertyProxy;

        protected var _disabledLabelProperties:feathers.core.PropertyProxy;

        protected var _onLabelProperties:feathers.core.PropertyProxy;

        protected var _offLabelProperties:feathers.core.PropertyProxy;

        protected var _labelAlign:String="middle";

        protected var _labelFactory:Function;

        protected var _onLabelFontStylesSet:feathers.text.FontStylesSet;

        protected var _onLabelFactory:Function;

        protected var _customOnLabelStyleName:String;

        protected var _offLabelFontStylesSet:feathers.text.FontStylesSet;

        protected var _offLabelFactory:Function;

        protected var _customOffLabelStyleName:String;

        protected var _onTrackSkinExplicitWidth:Number;

        protected var _onTrackSkinExplicitHeight:Number;

        protected var _onTrackSkinExplicitMinWidth:Number;

        protected var _onTrackSkinExplicitMinHeight:Number;

        protected var _offTrackSkinExplicitWidth:Number;

        protected var _offTrackSkinExplicitHeight:Number;

        protected var _offTrackSkinExplicitMinWidth:Number;

        protected var _offTrackSkinExplicitMinHeight:Number;

        protected var _isSelected:Boolean=false;

        protected var _toggleThumbSelection:Boolean=false;

        protected var _toggleDuration:Number=0.15;

        protected var _toggleEase:Object="easeOut";

        protected var _offTrackProperties:feathers.core.PropertyProxy;

        protected var _offText:String="OFF";

        protected var _customOnTrackStyleName:String;

        protected var _thumbFactory:Function;

        protected var _toggleTween:starling.animation.Tween;

        protected var _ignoreTapHandler:Boolean=false;

        protected var _customThumbStyleName:String;

        protected var _onTrackProperties:feathers.core.PropertyProxy;

        protected var _touchPointID:int=-1;

        protected var _thumbProperties:feathers.core.PropertyProxy;

        protected var _thumbStartX:Number;

        protected var _offTrackFactory:Function;

        protected var _touchStartX:Number;

        protected var onLabelStyleName:String="feathers-toggle-switch-on-label";

        protected var offLabelStyleName:String="feathers-toggle-switch-off-label";

        protected var onTrackStyleName:String="feathers-toggle-switch-on-track";

        protected var offTrackStyleName:String="feathers-toggle-switch-off-track";

        protected var thumbStyleName:String="feathers-toggle-switch-thumb";

        protected var thumb:starling.display.DisplayObject;

        protected var onTextRenderer:feathers.core.ITextRenderer;

        protected var offTextRenderer:feathers.core.ITextRenderer;

        protected var onTrack:starling.display.DisplayObject;

        protected var _animateSelectionChange:Boolean=false;

        protected var offTrack:starling.display.DisplayObject;

        protected var _currentState:String="notSelected";

        protected var _paddingRight:Number=0;

        protected var _paddingLeft:Number=0;

        protected var _showLabels:Boolean=true;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var _customOffTrackStyleName:String;

        protected var _onTrackFactory:Function;

        protected var _onText:String="ON";
    }
}


