//package core
//  class CustomLayout
package frontend.components.core 
{
    import feathers.controls.*;
    
    public class CustomLayout extends Object
    {
        public function CustomLayout(arg1:feathers.controls.LayoutGroup)
        {
            super();
            this._control = arg1;
            return;
        }

        public function get gap():Number
        {
            return this._gap;
        }

        public function set gap(arg1:Number):void
        {
            this._gap = arg1;
            this.setLayoutProp("gap", arg1);
            return;
        }

        public function get horizontalAlign():String
        {
            return this._horizontalAlign;
        }

        public function set horizontalAlign(arg1:String):void
        {
            this._horizontalAlign = arg1;
            this.setLayoutProp("horizontalAlign", arg1);
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

        public function get paddingBottom():Number
        {
            return this._paddingBottom;
        }

        public function set paddingBottom(arg1:Number):void
        {
            this._paddingBottom = arg1;
            this.setLayoutProp("paddingBottom", arg1);
            return;
        }

        public function get paddingLeft():Number
        {
            return this._paddingLeft;
        }

        public function set paddingLeft(arg1:Number):void
        {
            this._paddingLeft = arg1;
            this.setLayoutProp("paddingLeft", arg1);
            return;
        }

        public function get paddingRight():Number
        {
            return this._paddingRight;
        }

        public function set paddingRight(arg1:Number):void
        {
            this._paddingRight = arg1;
            this.setLayoutProp("paddingRight", arg1);
            return;
        }

        public function get paddingTop():Number
        {
            return this._paddingTop;
        }

        public function set paddingTop(arg1:Number):void
        {
            this._paddingTop = arg1;
            this.setLayoutProp("paddingTop", arg1);
            return;
        }

        public function get verticalAlign():String
        {
            return this._verticalAlign;
        }

        public function set verticalAlign(arg1:String):void
        {
            this._verticalAlign = arg1;
            this.setLayoutProp("verticalAlign", arg1);
            return;
        }

        protected function setLayoutProp(arg1:String, arg2:*):void
        {
            if (this._control.layout && Object(this._control.layout).hasOwnProperty(arg1) && (arg2 is Number && !isNaN(arg2) || arg2 is String && !(arg2 == ""))) 
            {
                this._control.layout[arg1] = arg2;
            }
            return;
        }

        internal var _gap:Number=NaN;

        internal var _horizontalAlign:String;

        internal var _paddingBottom:Number=NaN;

        internal var _paddingLeft:Number=NaN;

        internal var _paddingRight:Number=NaN;

        internal var _paddingTop:Number=NaN;

        internal var _verticalAlign:String;

        internal var _control:feathers.controls.LayoutGroup;
    }
}


//  class CustomLayoutData
package frontend.components.core 
{
    import feathers.controls.*;
    import feathers.layout.*;
    import starling.events.*;
    
    public class CustomLayoutData extends Object
    {
        public function CustomLayoutData(arg1:feathers.layout.ILayoutDisplayObject)
        {
            super();
            this._control = arg1;
            if (this._control.stage) 
            {
                this.initLayoutData();
            }
            else 
            {
                this._control.addEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStageHandler);
            }
            return;
        }

        public function get bottom():Number
        {
            return this._bottom;
        }

        public function set bottom(arg1:Number):void
        {
            if (this._bottom == arg1) 
            {
                return;
            }
            this._bottom = arg1;
            this.setLayoutDataProp("bottom", arg1);
            return;
        }

        public function get horizontalCenter():Number
        {
            return this._horizontalCenter;
        }

        public function set horizontalCenter(arg1:Number):void
        {
            if (this._horizontalCenter == arg1) 
            {
                return;
            }
            this._horizontalCenter = arg1;
            this.setLayoutDataProp("horizontalCenter", arg1);
            return;
        }

        public function get left():Number
        {
            return this._left;
        }

        public function set left(arg1:Number):void
        {
            if (this._left == arg1) 
            {
                return;
            }
            this._left = arg1;
            this.setLayoutDataProp("left", arg1);
            return;
        }

        public function get percentHeight():Number
        {
            return this._percentHeight;
        }

        public function set percentHeight(arg1:Number):void
        {
            this._percentHeight = arg1;
            this.setLayoutDataProp("percentHeight", arg1);
            return;
        }

        public function get percentWidth():Number
        {
            return this._percentWidth;
        }

        public function set percentWidth(arg1:Number):void
        {
            this._percentWidth = arg1;
            this.setLayoutDataProp("percentWidth", arg1);
            return;
        }

        public function get right():Number
        {
            return this._right;
        }

        public function set right(arg1:Number):void
        {
            if (this._right == arg1) 
            {
                return;
            }
            this._right = arg1;
            this.setLayoutDataProp("right", arg1);
            return;
        }

        public function get top():Number
        {
            return this._top;
        }

        public function set top(arg1:Number):void
        {
            this._top = arg1;
            this.setLayoutDataProp("top", arg1);
            return;
        }

        public function get verticalCenter():Number
        {
            return this._verticalCenter;
        }

        public function set verticalCenter(arg1:Number):void
        {
            if (this._verticalCenter == arg1) 
            {
                return;
            }
            this._verticalCenter = arg1;
            this.setLayoutDataProp("verticalCenter", arg1);
            return;
        }

        internal function get layoutData():feathers.layout.ILayoutData
        {
            return this._control.layoutData;
        }

        internal function onAddedToStageHandler(arg1:starling.events.Event):void
        {
            this._control.removeEventListener(starling.events.Event.ADDED_TO_STAGE, this.onAddedToStageHandler);
            this.initLayoutData();
            return;
        }

        internal function initLayoutData():void
        {
            if (this.layoutData) 
            {
                this.setLayoutDataProp("top", this._top);
                this.setLayoutDataProp("right", this._right);
                this.setLayoutDataProp("bottom", this._bottom);
                this.setLayoutDataProp("left", this._left);
                this.setLayoutDataProp("horizontalCenter", this._horizontalCenter);
                this.setLayoutDataProp("verticalCenter", this._verticalCenter);
            }
            else if (this._control.parent && this._control.parent is feathers.controls.LayoutGroup && feathers.controls.LayoutGroup(this._control.parent).layout) 
            {
                if (feathers.controls.LayoutGroup(this._control.parent).layout is feathers.layout.AnchorLayout) 
                {
                    this._control.layoutData = new feathers.layout.AnchorLayoutData(this._top, this._right, this._bottom, this._left, this._horizontalCenter, this._verticalCenter);
                }
                else if (feathers.controls.LayoutGroup(this._control.parent).layout is feathers.layout.VerticalLayout || feathers.controls.LayoutGroup(this._control.parent).layout is feathers.layout.HorizontalLayout) 
                {
                    this._control.layoutData = feathers.controls.LayoutGroup(this._control.parent).layout is feathers.layout.VerticalLayout ? new feathers.layout.VerticalLayoutData() : new feathers.layout.HorizontalLayoutData();
                }
            }
            else 
            {
                this._control.layoutData = new feathers.layout.AnchorLayoutData(this._top, this._right, this._bottom, this._left, this._horizontalCenter, this._verticalCenter);
            }
            this.setLayoutDataProp("percentWidth", this._percentWidth);
            this.setLayoutDataProp("percentHeight", this._percentHeight);
            return;
        }

        internal function setLayoutDataProp(arg1:String, arg2:*):void
        {
            if (this.layoutData && Object(this.layoutData).hasOwnProperty(arg1) && !isNaN(arg2)) 
            {
                this.layoutData[arg1] = arg2;
            }
            return;
        }

        protected var _bottom:Number=NaN;

        protected var _horizontalCenter:Number=NaN;

        protected var _left:Number=NaN;

        internal var _percentHeight:Number=NaN;

        internal var _percentWidth:Number=NaN;

        protected var _right:Number=NaN;

        protected var _top:Number=NaN;

        protected var _verticalCenter:Number=NaN;

        internal var _control:feathers.layout.ILayoutDisplayObject;
    }
}


//  class Group
package frontend.components.core 
{
    import feathers.controls.*;
    import feathers.layout.*;
    
    public class Group extends feathers.controls.LayoutGroup
    {
        public function Group()
        {
            super();
            this._customLayout = new frontend.components.core.CustomLayout(this);
            this.initLayout();
            return;
        }

        public function get bottom():Number
        {
            return this.customLayoutData.bottom;
        }

        public function set bottom(arg1:Number):void
        {
            this.customLayoutData.bottom = arg1;
            return;
        }

        public override function set height(arg1:Number):void
        {
            super.height = arg1;
            return;
        }

        public function get horizontalCenter():Number
        {
            return this.customLayoutData.horizontalCenter;
        }

        public function set horizontalCenter(arg1:Number):void
        {
            this.customLayoutData.horizontalCenter = arg1;
            return;
        }

        public function get left():Number
        {
            return this.customLayoutData.left;
        }

        public function set left(arg1:Number):void
        {
            this.customLayoutData.left = arg1;
            return;
        }

        public function get percentHeight():Number
        {
            return this.customLayoutData.percentHeight;
        }

        public function set percentHeight(arg1:Number):void
        {
            this.customLayoutData.percentHeight = arg1;
            return;
        }

        public function get percentWidth():Number
        {
            return this.customLayoutData.percentWidth;
        }

        public function set percentWidth(arg1:Number):void
        {
            this.customLayoutData.percentWidth = arg1;
            return;
        }

        public function get right():Number
        {
            return this.customLayoutData.right;
        }

        public function set right(arg1:Number):void
        {
            this.customLayoutData.right = arg1;
            return;
        }

        public function get top():Number
        {
            return this.customLayoutData.top;
        }

        public function set top(arg1:Number):void
        {
            this.customLayoutData.top = arg1;
            return;
        }

        public function get verticalCenter():Number
        {
            return this.customLayoutData.verticalCenter;
        }

        public function set verticalCenter(arg1:Number):void
        {
            this.customLayoutData.verticalCenter = arg1;
            return;
        }

        public override function set width(arg1:Number):void
        {
            super.width = arg1;
            return;
        }

        internal function get customLayoutData():frontend.components.core.CustomLayoutData
        {
            if (this._customLayoutData == null) 
            {
                this._customLayoutData = new frontend.components.core.CustomLayoutData(this);
            }
            return this._customLayoutData;
        }

        protected override function draw():void
        {
            var loc1:*=SIGMALink.scaleFactor;
            SIGMALink.scaleFactor = NaN;
            super.draw();
            SIGMALink.scaleFactor = loc1;
            return;
        }

        protected function initLayout():void
        {
            layout = new feathers.layout.AnchorLayout();
            return;
        }

        protected var _customLayout:frontend.components.core.CustomLayout;

        internal var _customLayoutData:frontend.components.core.CustomLayoutData;
    }
}


//  class Spacer
package frontend.components.core 
{
    import feathers.controls.*;
    
    public class Spacer extends feathers.controls.LayoutGroup
    {
        public function Spacer()
        {
            super();
            height = 10;
            width = 10;
            return;
        }
    }
}


//  class TouchLayoutGroup
package frontend.components.core 
{
    import __AS3__.vec.*;
    import feathers.controls.*;
    import feathers.events.*;
    import flash.geom.*;
    import flash.utils.*;
    import starling.events.*;
    
    public class TouchLayoutGroup extends feathers.controls.LayoutGroup
    {
        public function TouchLayoutGroup()
        {
            new Vector.<String>(4)[0] = STATE_UP;
            new Vector.<String>(4)[1] = STATE_DOWN;
            new Vector.<String>(4)[2] = STATE_HOVER;
            new Vector.<String>(4)[3] = STATE_DISABLED;
            this._stateNames = new Vector.<String>(4);
            super();
            addEventListener(starling.events.TouchEvent.TOUCH, this.touchHandler);
            return;
        }

        public function get currentState():String
        {
            return this._currentState;
        }

        public override function set isEnabled(arg1:Boolean):void
        {
            if (this._isEnabled == arg1) 
            {
                return;
            }
            super.isEnabled = arg1;
            if (this._isEnabled) 
            {
                if (this._currentState == STATE_DISABLED) 
                {
                    this.changeState(STATE_UP);
                }
                this.touchable = true;
            }
            else 
            {
                this.touchable = false;
                this.changeState(STATE_DISABLED);
                this.touchPointID = -1;
            }
            return;
        }

        public function get isLongPressEnabled():Boolean
        {
            return this._isLongPressEnabled;
        }

        public function set isLongPressEnabled(arg1:Boolean):void
        {
            this._isLongPressEnabled = arg1;
            if (!arg1) 
            {
                this.removeEventListener(starling.events.Event.ENTER_FRAME, this.longPress_enterFrameHandler);
            }
            return;
        }

        protected function get stateNames():__AS3__.vec.Vector.<String>
        {
            return this._stateNames;
        }

        protected function touchHandler(arg1:starling.events.TouchEvent):void
        {
            var loc1:*=null;
            var loc2:*=false;
            if (!this._isEnabled) 
            {
                this.touchPointID = -1;
                return;
            }
            if (this.touchPointID >= 0) 
            {
                loc1 = arg1.getTouch(this, null, this.touchPointID);
                if (!loc1) 
                {
                    return;
                }
                if (!this.stage) 
                {
                    return;
                }
                loc1.getLocation(this.stage, HELPER_POINT);
                loc2 = this.contains(this.stage.hitTest(HELPER_POINT));
                if (loc1.phase != starling.events.TouchPhase.MOVED) 
                {
                    if (loc1.phase == starling.events.TouchPhase.ENDED) 
                    {
                        this.resetTouchState(loc1);
                        if (!this._hasLongPressed && loc2) 
                        {
                            arg1.stopPropagation();
                            this.trigger();
                        }
                    }
                }
                else 
                {
                    if (this._isLongPressEnabled) 
                    {
                        this._longPressGlobalPosition.x = loc1.globalX;
                        this._longPressGlobalPosition.y = loc1.globalY;
                    }
                    if (loc2 || this.keepDownStateOnRollOut) 
                    {
                        this.changeState(STATE_DOWN);
                    }
                    else 
                    {
                        this.changeState(STATE_UP);
                    }
                }
                return;
            }
            loc1 = arg1.getTouch(this, starling.events.TouchPhase.BEGAN);
            if (loc1) 
            {
                this.changeState(STATE_DOWN);
                this.touchPointID = loc1.id;
                if (this._isLongPressEnabled) 
                {
                    this._touchBeginTime = flash.utils.getTimer();
                    if (this._longPressGlobalPosition) 
                    {
                        this._longPressGlobalPosition.x = loc1.globalX;
                        this._longPressGlobalPosition.y = loc1.globalY;
                    }
                    else 
                    {
                        this._longPressGlobalPosition = new flash.geom.Point(loc1.globalX, loc1.globalY);
                    }
                    this._hasLongPressed = false;
                    this.addEventListener(starling.events.Event.ENTER_FRAME, this.longPress_enterFrameHandler);
                }
                return;
            }
            loc1 = arg1.getTouch(this, starling.events.TouchPhase.HOVER);
            if (loc1) 
            {
                this.changeState(STATE_HOVER);
                return;
            }
            this.changeState(STATE_UP);
            return;
        }

        protected function longPress_enterFrameHandler(arg1:starling.events.Event):void
        {
            var loc2:*=false;
            var loc1:*=(flash.utils.getTimer() - this._touchBeginTime) / 1000;
            if (loc1 >= this._longPressDuration) 
            {
                this.removeEventListener(starling.events.Event.ENTER_FRAME, this.longPress_enterFrameHandler);
                loc2 = this.contains(this.stage.hitTest(this._longPressGlobalPosition));
                if (loc2) 
                {
                    this._hasLongPressed = true;
                    this.dispatchEventWith(feathers.events.FeathersEventType.LONG_PRESS);
                }
            }
            return;
        }

        protected function changeState(arg1:String):void
        {
            if (this._currentState == arg1) 
            {
                return;
            }
            if (this.stateNames.indexOf(arg1) < 0) 
            {
                throw new ArgumentError("Invalid state: " + arg1 + ".");
            }
            this._currentState = arg1;
            this.invalidate(INVALIDATION_FLAG_STATE);
            this.dispatchEventWith(feathers.events.FeathersEventType.STATE_CHANGE);
            return;
        }

        protected function resetTouchState(arg1:starling.events.Touch=null):void
        {
            this.touchPointID = -1;
            this.removeEventListener(starling.events.Event.ENTER_FRAME, this.longPress_enterFrameHandler);
            if (this._isEnabled) 
            {
                this.changeState(STATE_UP);
            }
            else 
            {
                this.changeState(STATE_DISABLED);
            }
            return;
        }

        protected function trigger():void
        {
            this.dispatchEventWith(starling.events.Event.TRIGGERED);
            return;
        }

        public static const STATE_DISABLED:String="disabled";

        public static const STATE_DOWN:String="down";

        public static const STATE_HOVER:String="hover";

        public static const STATE_UP:String="up";

        internal static const HELPER_POINT:flash.geom.Point=new flash.geom.Point();

        protected var _currentState:String="up";

        protected var _isLongPressEnabled:Boolean=false;

        public var keepDownStateOnRollOut:Boolean=false;

        protected var _hasLongPressed:Boolean=false;

        protected var _longPressDuration:Number=0.5;

        protected var _longPressGlobalPosition:flash.geom.Point;

        protected var _touchBeginTime:int;

        protected var _stateNames:__AS3__.vec.Vector.<String>;

        protected var touchPointID:int=-1;
    }
}


//  class VGroup
package frontend.components.core 
{
    import feathers.layout.*;
    
    public class VGroup extends frontend.components.core.VHGroup
    {
        public function VGroup()
        {
            super();
            return;
        }

        protected override function initLayout():void
        {
            layout = new feathers.layout.VerticalLayout();
            return;
        }
    }
}


//  class VHGroup
package frontend.components.core 
{
    public class VHGroup extends frontend.components.core.Group
    {
        public function VHGroup()
        {
            super();
            return;
        }

        public function get gap():Number
        {
            return _customLayout.gap;
        }

        public function set gap(arg1:Number):void
        {
            _customLayout.gap = arg1;
            return;
        }

        public function get horizontalAlign():String
        {
            return _customLayout.horizontalAlign;
        }

        public function set horizontalAlign(arg1:String):void
        {
            _customLayout.horizontalAlign = arg1;
            return;
        }

        public function get padding():Number
        {
            return _customLayout.padding;
        }

        public function set padding(arg1:Number):void
        {
            _customLayout.padding = arg1;
            return;
        }

        public function get paddingBottom():Number
        {
            return _customLayout.paddingBottom;
        }

        public function set paddingBottom(arg1:Number):void
        {
            _customLayout.paddingBottom = arg1;
            return;
        }

        public function get paddingLeft():Number
        {
            return _customLayout.paddingLeft;
        }

        public function set paddingLeft(arg1:Number):void
        {
            _customLayout.paddingLeft = arg1;
            return;
        }

        public function get paddingRight():Number
        {
            return _customLayout.paddingRight;
        }

        public function set paddingRight(arg1:Number):void
        {
            _customLayout.paddingRight = arg1;
            return;
        }

        public function get paddingTop():Number
        {
            return _customLayout.paddingTop;
        }

        public function set paddingTop(arg1:Number):void
        {
            _customLayout.paddingTop = arg1;
            return;
        }

        public function get verticalAlign():String
        {
            return _customLayout.verticalAlign;
        }

        public function set verticalAlign(arg1:String):void
        {
            _customLayout.verticalAlign = arg1;
            return;
        }
    }
}


