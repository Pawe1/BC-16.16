//class Group
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


