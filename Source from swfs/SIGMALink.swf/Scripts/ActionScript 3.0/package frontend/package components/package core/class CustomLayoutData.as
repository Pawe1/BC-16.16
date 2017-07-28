//class CustomLayoutData
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


