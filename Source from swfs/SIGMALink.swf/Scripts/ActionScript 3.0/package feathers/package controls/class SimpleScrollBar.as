//class SimpleScrollBar
package feathers.controls 
{
    import feathers.core.*;
    import feathers.events.*;
    import feathers.layout.*;
    import feathers.skins.*;
    import feathers.utils.math.*;
    import flash.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.display.*;
    import starling.events.*;
    
    public class SimpleScrollBar extends feathers.core.FeathersControl implements feathers.controls.IDirectionalScrollBar
    {
        public function SimpleScrollBar()
        {
            super();
            this.addEventListener(starling.events.Event.REMOVED_FROM_STAGE, this.removedFromStageHandler);
            return;
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
                this._thumbProperties = new feathers.core.PropertyProxy(this.thumbProperties_onChange);
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
                this._thumbProperties.removeOnChangeCallback(this.thumbProperties_onChange);
            }
            this._thumbProperties = feathers.core.PropertyProxy(arg1);
            if (this._thumbProperties) 
            {
                this._thumbProperties.addOnChangeCallback(this.thumbProperties_onChange);
            }
            this.invalidate(INVALIDATION_FLAG_STYLES);
            return;
        }

        protected override function initialize():void
        {
            if (!this.track) 
            {
                this.track = new starling.display.Quad(10, 10, 16711935);
                this.track.alpha = 0;
                this.track.addEventListener(starling.events.TouchEvent.TOUCH, this.track_touchHandler);
                this.addChild(this.track);
            }
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
            var loc1:*=this.isInvalid(INVALIDATION_FLAG_DATA);
            var loc2:*=this.isInvalid(INVALIDATION_FLAG_STYLES);
            var loc3:*=this.isInvalid(INVALIDATION_FLAG_SIZE);
            var loc4:*=this.isInvalid(INVALIDATION_FLAG_STATE);
            var loc5:*=this.isInvalid(INVALIDATION_FLAG_THUMB_FACTORY);
            if (loc5) 
            {
                this.createThumb();
            }
            if (loc5 || loc2) 
            {
                this.refreshThumbStyles();
            }
            if (loc1 || loc5 || loc4) 
            {
                this.refreshEnabled();
            }
            loc3 = this.autoSizeIfNeeded() || loc3;
            this.layout();
            return;
        }

        protected function autoSizeIfNeeded():Boolean
        {
            var loc5:*=null;
            var loc1:*=!(this._explicitWidth === this._explicitWidth);
            var loc2:*=!(this._explicitHeight === this._explicitHeight);
            var loc3:*=!(this._explicitMinWidth === this._explicitMinWidth);
            var loc4:*=!(this._explicitMinHeight === this._explicitMinHeight);
            if (!loc1 && !loc2 && !loc3 && !loc4) 
            {
                return false;
            }
            this.thumb.width = this._thumbExplicitWidth;
            this.thumb.height = this._thumbExplicitHeight;
            if (this.thumb is feathers.core.IMeasureDisplayObject) 
            {
                loc5 = feathers.core.IMeasureDisplayObject(this.thumb);
                loc5.minWidth = this._thumbExplicitMinWidth;
                loc5.minHeight = this._thumbExplicitMinHeight;
            }
            if (this.thumb is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.thumb).validate();
            }
            var loc6:*=this._maximum - this._minimum;
            var loc7:*=this._page;
            if (loc7 === 0) 
            {
                loc7 = this._step;
            }
            if (loc7 > loc6) 
            {
                loc7 = loc6;
            }
            var loc8:*=this._explicitWidth;
            var loc9:*=this._explicitHeight;
            var loc10:*=this._explicitMinWidth;
            var loc11:*=this._explicitMinHeight;
            if (loc1) 
            {
                loc8 = this.thumb.width;
                if (!(this._direction === feathers.layout.Direction.VERTICAL) && !(loc7 === 0)) 
                {
                    loc8 = loc8 * loc6 / loc7;
                }
                loc8 = loc8 + (this._paddingLeft + this._paddingRight);
            }
            if (loc2) 
            {
                loc9 = this.thumb.height;
                if (this._direction === feathers.layout.Direction.VERTICAL && !(loc7 === 0)) 
                {
                    loc9 = loc9 * loc6 / loc7;
                }
                loc9 = loc9 + (this._paddingTop + this._paddingBottom);
            }
            if (loc3) 
            {
                if (loc5 === null) 
                {
                    loc10 = this.thumb.width;
                }
                else 
                {
                    loc10 = loc5.minWidth;
                }
                if (!(this._direction === feathers.layout.Direction.VERTICAL) && !(loc7 === 0)) 
                {
                    loc10 = loc10 * loc6 / loc7;
                }
                loc10 = loc10 + (this._paddingLeft + this._paddingRight);
            }
            if (loc4) 
            {
                if (loc5 === null) 
                {
                    loc11 = this.thumb.height;
                }
                else 
                {
                    loc11 = loc5.minHeight;
                }
                if (this._direction === feathers.layout.Direction.VERTICAL && !(loc7 === 0)) 
                {
                    loc11 = loc11 * loc6 / loc7;
                }
                loc11 = loc11 + (this._paddingTop + this._paddingBottom);
            }
            return this.saveMeasurements(loc8, loc9, loc10, loc11);
        }

        protected function createThumb():void
        {
            var loc4:*=null;
            if (this.thumb) 
            {
                this.thumb.removeFromParent(true);
                this.thumb = null;
            }
            var loc1:*=this._thumbFactory == null ? defaultThumbFactory : this._thumbFactory;
            var loc2:*=this._customThumbStyleName == null ? this.thumbStyleName : this._customThumbStyleName;
            var loc3:*=feathers.controls.BasicButton(loc1());
            loc3.styleNameList.add(loc2);
            if (loc3 is feathers.core.IFocusDisplayObject) 
            {
                loc3.isFocusEnabled = false;
            }
            loc3.keepDownStateOnRollOut = true;
            loc3.addEventListener(starling.events.TouchEvent.TOUCH, this.thumb_touchHandler);
            this.addChild(loc3);
            this.thumb = loc3;
            if (this.thumb is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this.thumb).initializeNow();
            }
            if (this.thumb is feathers.core.IMeasureDisplayObject) 
            {
                loc4 = feathers.core.IMeasureDisplayObject(this.thumb);
                this._thumbExplicitWidth = loc4.explicitWidth;
                this._thumbExplicitHeight = loc4.explicitHeight;
                this._thumbExplicitMinWidth = loc4.explicitMinWidth;
                this._thumbExplicitMinHeight = loc4.explicitMinHeight;
            }
            else 
            {
                this._thumbExplicitWidth = this.thumb.width;
                this._thumbExplicitHeight = this.thumb.height;
                this._thumbExplicitMinWidth = this._thumbExplicitWidth;
                this._thumbExplicitMinHeight = this._thumbExplicitHeight;
            }
            return;
        }

        protected override function get defaultStyleProvider():feathers.skins.IStyleProvider
        {
            return feathers.controls.SimpleScrollBar.globalStyleProvider;
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
            this.invalidate(INVALIDATION_FLAG_THUMB_FACTORY);
            return;
        }

        protected function refreshEnabled():void
        {
            if (this.thumb is feathers.core.IFeathersControl) 
            {
                feathers.core.IFeathersControl(this.thumb).isEnabled = this._isEnabled && this._maximum > this._minimum;
            }
            return;
        }

        protected function layout():void
        {
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc8:*=NaN;
            var loc9:*=NaN;
            var loc10:*=NaN;
            var loc11:*=NaN;
            var loc12:*=NaN;
            var loc13:*=NaN;
            var loc14:*=NaN;
            var loc15:*=NaN;
            this.track.width = this.actualWidth;
            this.track.height = this.actualHeight;
            var loc1:*=this._maximum - this._minimum;
            this.thumb.visible = loc1 > 0;
            if (!this.thumb.visible) 
            {
                return;
            }
            if (this.thumb is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.thumb).validate();
            }
            var loc2:*=this.actualWidth - this._paddingLeft - this._paddingRight;
            var loc3:*=this.actualHeight - this._paddingTop - this._paddingBottom;
            var loc4:*=this._page;
            if (this._page != 0) 
            {
                if (loc4 > loc1) 
                {
                    loc4 = loc1;
                }
            }
            else 
            {
                loc4 = this._step;
            }
            var loc5:*=0;
            if (this._value < this._minimum) 
            {
                loc5 = this._minimum - this._value;
            }
            if (this._value > this._maximum) 
            {
                loc5 = this._value - this._maximum;
            }
            if (this._direction != feathers.layout.Direction.VERTICAL) 
            {
                loc11 = this._thumbExplicitMinWidth;
                if (this.thumb is feathers.core.IMeasureDisplayObject) 
                {
                    loc11 = feathers.core.IMeasureDisplayObject(this.thumb).minWidth;
                }
                loc12 = loc2 * loc4 / loc1;
                loc13 = loc2 - loc12;
                if (loc13 > loc12) 
                {
                    loc13 = loc12;
                }
                loc13 = loc13 * loc5 / (loc1 * loc12 / loc2);
                loc12 = loc12 - loc13;
                if (loc12 < loc11) 
                {
                    loc12 = loc11;
                }
                this.thumb.width = loc12;
                this.thumb.height = loc3;
                loc14 = loc2 - this.thumb.width;
                loc15 = loc14 * (this._value - this._minimum) / loc1;
                if (loc15 > loc14) 
                {
                    loc15 = loc14;
                }
                else if (loc15 < 0) 
                {
                    loc15 = 0;
                }
                this.thumb.x = this._paddingLeft + loc15;
                this.thumb.y = this._paddingTop + (this.actualHeight - this._paddingTop - this._paddingBottom - this.thumb.height) / 2;
            }
            else 
            {
                this.thumb.width = loc2;
                loc6 = this._thumbExplicitMinHeight;
                if (this.thumb is feathers.core.IMeasureDisplayObject) 
                {
                    loc6 = feathers.core.IMeasureDisplayObject(this.thumb).minHeight;
                }
                loc7 = loc3 * loc4 / loc1;
                loc8 = loc3 - loc7;
                if (loc8 > loc7) 
                {
                    loc8 = loc7;
                }
                loc8 = loc8 * loc5 / (loc1 * loc7 / loc3);
                loc7 = loc7 - loc8;
                if (loc7 < loc6) 
                {
                    loc7 = loc6;
                }
                this.thumb.height = loc7;
                this.thumb.x = this._paddingLeft + (this.actualWidth - this._paddingLeft - this._paddingRight - this.thumb.width) / 2;
                loc9 = loc3 - this.thumb.height;
                loc10 = loc9 * (this._value - this._minimum) / loc1;
                if (loc10 > loc9) 
                {
                    loc10 = loc9;
                }
                else if (loc10 < 0) 
                {
                    loc10 = 0;
                }
                this.thumb.y = this._paddingTop + loc10;
            }
            if (this.thumb is feathers.core.IValidating) 
            {
                feathers.core.IValidating(this.thumb).validate();
            }
            return;
        }

        public function get value():Number
        {
            return this._value;
        }

        public function set value(arg1:Number):void
        {
            if (this.clampToRange) 
            {
                arg1 = feathers.utils.math.clamp(arg1, this._minimum, this._maximum);
            }
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

        protected function locationToValue(arg1:flash.geom.Point):Number
        {
            var loc2:*=NaN;
            var loc3:*=NaN;
            var loc4:*=NaN;
            var loc5:*=NaN;
            var loc6:*=NaN;
            var loc7:*=NaN;
            var loc1:*=0;
            if (this._direction != feathers.layout.Direction.VERTICAL) 
            {
                loc5 = this.actualWidth - this.thumb.width - this._paddingLeft - this._paddingRight;
                if (loc5 > 0) 
                {
                    loc6 = arg1.x - this._touchStartX - this._paddingLeft;
                    loc7 = Math.min(Math.max(0, this._thumbStartX + loc6), loc5);
                    loc1 = loc7 / loc5;
                }
            }
            else 
            {
                loc2 = this.actualHeight - this.thumb.height - this._paddingTop - this._paddingBottom;
                if (loc2 > 0) 
                {
                    loc3 = arg1.y - this._touchStartY - this._paddingTop;
                    loc4 = Math.min(Math.max(0, this._thumbStartY + loc3), loc2);
                    loc1 = loc4 / loc2;
                }
            }
            return this._minimum + loc1 * (this._maximum - this._minimum);
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

        protected function adjustPage():void
        {
            var loc3:*=NaN;
            var loc1:*=this._maximum - this._minimum;
            var loc2:*=this._page;
            if (loc2 === 0) 
            {
                loc2 = this._step;
            }
            if (loc2 > loc1) 
            {
                loc2 = loc1;
            }
            if (this._touchValue < this._value) 
            {
                loc3 = Math.max(this._touchValue, this._value - loc2);
                if (!(this._step == 0) && !(loc3 == this._maximum) && !(loc3 == this._minimum)) 
                {
                    loc3 = feathers.utils.math.roundToNearest(loc3, this._step);
                }
                this.value = loc3;
            }
            else if (this._touchValue > this._value) 
            {
                loc3 = Math.min(this._touchValue, this._value + loc2);
                if (!(this._step == 0) && !(loc3 == this._maximum) && !(loc3 == this._minimum)) 
                {
                    loc3 = feathers.utils.math.roundToNearest(loc3, this._step);
                }
                this.value = loc3;
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

        public function get step():Number
        {
            return this._step;
        }

        public function set step(arg1:Number):void
        {
            this._step = arg1;
            return;
        }

        protected function thumbProperties_onChange(arg1:feathers.core.PropertyProxy, arg2:Object):void
        {
            this.invalidate(INVALIDATION_FLAG_STYLES);
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
            this.invalidate(INVALIDATION_FLAG_DATA);
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

        protected function track_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            if (!this._isEnabled) 
            {
                this._touchPointID = -1;
                return;
            }
            if (this._touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this.track, starling.events.TouchPhase.ENDED, this._touchPointID);
                if (!loc1) 
                {
                    return;
                }
                this._touchPointID = -1;
                this._repeatTimer.stop();
            }
            else 
            {
                loc1 = arg1.getTouch(this.track, starling.events.TouchPhase.BEGAN);
                if (!loc1) 
                {
                    return;
                }
                this._touchPointID = loc1.id;
                loc1.getLocation(this, HELPER_POINT);
                this._touchStartX = HELPER_POINT.x;
                this._touchStartY = HELPER_POINT.y;
                this._thumbStartX = HELPER_POINT.x;
                this._thumbStartY = HELPER_POINT.y;
                this._touchValue = this.locationToValue(HELPER_POINT);
                this.adjustPage();
                this.startRepeatTimer(this.adjustPage);
            }
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

        public function get customThumbStyleName():String
        {
            return this._customThumbStyleName;
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

        protected function thumb_touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=NaN;
            if (!this._isEnabled) 
            {
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
                    loc1.getLocation(this, HELPER_POINT);
                    loc2 = this.locationToValue(HELPER_POINT);
                    if (!(this._step == 0) && !(loc2 == this._maximum) && !(loc2 == this._minimum)) 
                    {
                        loc2 = feathers.utils.math.roundToNearest(loc2, this._step);
                    }
                    this.value = loc2;
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

        protected function repeatTimer_timerHandler(arg1:flash.events.TimerEvent):void
        {
            if (this._repeatTimer.currentCount < 5) 
            {
                return;
            }
            this.currentRepeatAction();
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

        protected static function defaultThumbFactory():feathers.controls.BasicButton
        {
            return new feathers.controls.Button();
        }

        protected function removedFromStageHandler(arg1:starling.events.Event):void
        {
            this._touchPointID = -1;
            if (this._repeatTimer) 
            {
                this._repeatTimer.stop();
            }
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

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        protected static const INVALIDATION_FLAG_THUMB_FACTORY:String="thumbFactory";

        public static const DIRECTION_HORIZONTAL:String="horizontal";

        public static const DIRECTION_VERTICAL:String="vertical";

        public static const DEFAULT_CHILD_STYLE_NAME_THUMB:String="feathers-simple-scroll-bar-thumb";

        protected var thumb:starling.display.DisplayObject;

        protected var track:starling.display.Quad;

        protected var _direction:String="horizontal";

        public var clampToRange:Boolean=false;

        protected var _value:Number=0;

        protected var _minimum:Number=0;

        protected var _maximum:Number=0;

        protected var _step:Number=0;

        protected var _page:Number=0;

        protected var _paddingTop:Number=0;

        protected var _paddingBottom:Number=0;

        protected var _paddingLeft:Number=0;

        protected var currentRepeatAction:Function;

        protected var _repeatTimer:flash.utils.Timer;

        public var liveDragging:Boolean=true;

        protected var _thumbProperties:feathers.core.PropertyProxy;

        protected var _thumbFactory:Function;

        protected var _repeatDelay:Number=0.05;

        protected var _touchPointID:int=-1;

        protected var _touchStartX:Number=NaN;

        protected var _touchStartY:Number=NaN;

        protected var _thumbStartX:Number=NaN;

        protected var _paddingRight:Number=0;

        protected var _thumbStartY:Number=NaN;

        protected var _touchValue:Number;

        protected var isDragging:Boolean=false;

        protected var thumbStyleName:String="feathers-simple-scroll-bar-thumb";

        protected var _thumbExplicitWidth:Number;

        protected var _thumbExplicitHeight:Number;

        protected var _thumbExplicitMinWidth:Number;

        protected var _thumbExplicitMinHeight:Number;

        public static var globalStyleProvider:feathers.skins.IStyleProvider;

        protected var _customThumbStyleName:String;
    }
}


